import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_f_w_online_shop_app/Models/Cart_Model.dart';
import 'package:t_f_w_online_shop_app/Models/user_model.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'package:t_f_w_online_shop_app/components/Product_Model.dart';
import 'package:t_f_w_online_shop_app/database/shared_pref.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit getShopCubit(context) => BlocProvider.of(context);

  int index = 0;

  List<String> categories = ["Hand bag", "Jewellery", "Footwear", "Dresses"];

  cubitChangeCategory(int index) {
    this.index = index;
    print(categories[this.index]);
    print('cubit index = ${this.index}');
    emit(ShopChangeIndexState());
  }

  List<Color> colorList = [
    Color(0xFF3D82AE),
    Color(0xFFD3A984),
    Color(0xFF989493),
  ];

  Color color;

  List<bool> boolList = [true, false, false];
  cubitChangeColor(int index) {
    if (index == 0) {
      boolList = [true, false, false];
    } else if (index == 1) {
      boolList = [false, true, false];
    } else {
      boolList = [
        false,
        false,
        true,
      ];
    }
    print(index.toString());
    emit(ShopChangeColorState());
  }

  int numOfItems = 1;
  cubitNumOfItems(int index) {
    if (index == 1) {
      numOfItems++;
    } else if (index == -1) {
      if (numOfItems > 1) {
        numOfItems--;
      }
    }
    emit(ShopChangeNumOfItemsState());
  }

  IconData icon = Icons.visibility;
  bool isPassword = true;

  cubitChangePasswordVisibility() {
    isPassword = !isPassword;
    icon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopChangePasswordVisibilityState());
  }

  int userType = 1;
  cubitSelectUserType(int index) {
    userType = index;
    emit(
      ShopSelectUserTypeState(),
    );
  }

  Color itemColor = Colors.white;
  cubitSelectItemColor(Color color) {
    itemColor = color;
    emit(ShopSelectItemColorState());
  }

  PickedFile pickedPostFile;
  File postFile;
  cubitImagePostPicker() async {
    ImagePicker picker = ImagePicker();
    // Pick an image from gallery
    pickedPostFile = await picker.getImage(source: ImageSource.gallery);
    postFile = File(pickedPostFile.path);
    emit(ShopImagePickerState());
  }

  // -------------------------------------------------------

  cubitRegistration({String email, name, password, phone}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UserModel userModel = UserModel(
          name: name, email: email, phone: phone, uID: value.user.uid);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(value.user.uid.toString())
          .set(userModel.toMap())
          .then((value) {
        emit(ShopSuccessfullySavedUserInfoState());
      }).catchError((error) {
        print(error.toString());
        emit(ShopErrorSavedUserInfoState());
      });
      emit(ShopSuccessfullyRegistrationState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorRegistrationState());
    });
  }

  String userToken;
  String userName;
  String userNumber;

  cubitLogin(String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userToken = value.user.uid;
      SharedPref.putData('userToken', userToken);
      emit(ShopSuccessfullyLoginState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorLoginState());
    });
  }

  cubitUploadItemImage({String title, description, int size, price, id}) {
    FirebaseStorage.instance
        .ref()
        // e3ml create l folder esmo ItemImages 5od mno last pathSegments
        .child('ItemImages/${Uri.file(postFile.path).pathSegments.last}')
        // w erf3 feh el sora el mwgoda f el postFile
        .putFile(postFile)
        .then(
      (value) {
        print('valueeeeee ${itemColor.toString()}');
        value.ref.getDownloadURL().then((value) {
          cubitUploadItemPackage(
              image: value.toString(),
              price: price,
              id: id,
              size: size,
              title: title,
              intColor: itemColor.value);
          cubitGetItemPackage();
          emit(ShopSuccessfullyUploadItemImageState());
        });
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorUploadItemImageState());
      },
    );
  }

  cubitUploadItemPackage(
      {String image,
      title,
      description,
      int price,
      size,
      intColor,
      id,
      Color color}) {
    Product product = Product(
        id: id,
        image: image,
        title: title,
        size: size,
        price: price,
        color: color,
        intColor: intColor);
    FirebaseFirestore.instance
        .collection('ItemPackage')
        .doc(id.toString())
        .set(product.toMap())
        .then((value) {
      emit(ShopSuccessfullyUploadItemPackageState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUploadItemPackageState());
    });
  }

  List<Product> productsList = [];
  cubitGetItemPackage() {
    FirebaseFirestore.instance.collection('ItemPackage').get().then((value) {
      value.docs.forEach((element) {
        productsList.add(Product.fromJson(element.data()));

        emit(ShopSuccessfullyGetItemPackageState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetItemPackageState());
    });
  }

  cubitAddToCart(int productID, int cartNumOfItems, String dateTime) {
    String userToken = SharedPref.getData('userToken');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userToken.toString())
        .get()
        .then((value) async {
      UserModel userModel = UserModel.fromJson(value.data());
      CartModel cartModel = CartModel(
          dateTime: dateTime,
          cartNumOfItems: cartNumOfItems,
          productID: productID,
          name: userModel.name,
          phone: userModel.phone,
          uID: userModel.uID,
          email: userModel.email);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userToken.toString())
          .collection('Orders')
          .doc(productID.toString())
          .set(cartModel.toMap())
          .then((value) {
        print('done added successfully');
        cubitGetOrders();
        emit(ShopSuccessfullyItemAddedState());
      }).then((value) => () {
                emit(ShopErrorItemAddedState());
              });
    });
  }

  List<CartModel> cartList = [];
  String isTheSame;
  cubitGetOrders() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      cartList = [];
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(element.id)
            .collection('Orders')
            .orderBy('dateTime')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            cartList.add(CartModel.fromJson(element.data()));

            emit(ShopSuccessfullyGetOrdersCartListState());
          });
        }).catchError((error) {
          print(error.toString());
          emit(ShopErrorGetOrdersCartListState());
        });
      });
      emit(ShopSuccessfullyGetOrdersUserListState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetOrdersUserListState());
    });
  }
}

// List<CartModel> cartList = [];
// List<UserModel> userList = [];
// String isTheSame;
// cubitGetOrders()  {
//   FirebaseFirestore.instance.collection('Users').get().then((value) {
//     value.docs.forEach((element)  {
//       isTheSame = element.id;
//       print('user list= $isTheSame}');
//       userList.add(UserModel.fromJson(element.data()));
//
//       FirebaseFirestore.instance
//           .collection('Users')
//           .doc(element.id)
//           .collection('Orders')
//           .get()
//           .then((value) {
//         value.docs.forEach((element) {
//           print('cart list= $isTheSame');
//           cartList.add(CartModel.fromJson(element.data()));
//
//           emit(ShopSuccessfullyGetOrdersCartListState());
//         });
//       }).catchError((error) {
//         print(error.toString());
//         emit(ShopErrorGetOrdersCartListState());
//       });
//     });
//     emit(ShopSuccessfullyGetOrdersUserListState());
//   }).catchError((error) {
//     print(error.toString());
//     emit(ShopErrorGetOrdersUserListState());
//   });
// }

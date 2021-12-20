import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'package:t_f_w_online_shop_app/components/Orders.dart';
import 'package:t_f_w_online_shop_app/components/color.dart';
import 'package:t_f_w_online_shop_app/constants.dart';
import 'package:t_f_w_online_shop_app/text_form_field.dart';

TextEditingController idController = TextEditingController();
TextEditingController titleController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController sizeController = TextEditingController();

class ShopAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        ShopCubit shopCubit = ShopCubit.getShopCubit(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/add_to_cart.svg",
                  ),
                  onPressed: () {
                    shopCubit.cubitGetOrders();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Orders();
                    }));
                  })
            ],
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
              child: Text(
                'Admin',
                style: TextStyle(
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / 30, vertical: size.height / 60),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: SizedBox(
                      height: size.height / 12,
                      child: defaultFormField(
                          label: 'id',
                          controller: idController,
                          type: TextInputType.number),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 60),
                    child: SizedBox(
                      height: size.height / 12,
                      child: defaultFormField(
                        label: 'title',
                        controller: titleController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 12,
                    child: defaultFormField(
                        label: 'price',
                        controller: priceController,
                        type: TextInputType.number),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 60),
                    child: SizedBox(
                      height: size.height / 12,
                      child: defaultFormField(
                          label: 'size',
                          controller: sizeController,
                          type: TextInputType.number),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height / 60),
                    child: SizedBox(
                      width: size.width / 1.3,
                      height: size.height / 16,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopColor()));
                        },
                        color: Color(0xFF3D82AE),
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Select Color',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 2),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Icon(
                              Icons.color_lens,
                              color: shopCubit.itemColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  shopCubit.postFile != null
                      ? Container(
                          width: size.width / 1.6,
                          height: size.height / 5,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            image: DecorationImage(
                                image: FileImage(shopCubit.postFile)),
                          ),
                        )
                      : Container(
                          width: size.width / 1.6,
                          height: size.height / 5,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 60),
                    child: SizedBox(
                      width: size.width / 1.3,
                      height: size.height / 16,
                      child: FlatButton(
                        onPressed: () {
                          shopCubit.cubitImagePostPicker();
                        },
                        color: Color(0xFF3D82AE),
                        textColor: Colors.white,
                        child: Text(
                          'Select Image',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height / 16,
                    child: FlatButton(
                      onPressed: () async {
                        await shopCubit.cubitUploadItemImage(
                          id: int.parse(idController.text),
                          title: titleController.text,
                          size: int.parse(sizeController.text),
                          price: int.parse(priceController.text),
                        );
                        idController.clear();
                        titleController.clear();
                        priceController.clear();
                        sizeController.clear();
                      },
                      color: Color(0xFF3D82AE),
                      textColor: Colors.white,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

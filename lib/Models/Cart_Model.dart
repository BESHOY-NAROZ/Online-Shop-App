class CartModel {
  int cartNumOfItems;
  int productID;
  String name;
  String email;
  String phone;
  String uID;
  String dateTime;

  // int cartItemColor;

  CartModel(
      {this.cartNumOfItems,
      this.productID,
      this.name,
      this.email,
      this.phone,
      this.uID,
      this.dateTime
      //   this.cartItemColor
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartNumOfItems = json['cartNumOfItems'];
    productID = json['productID'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uID = json['uID'];
    dateTime = json['dateTime'];
    // cartItemColor = json['cartItemColor'];
  }

  Map<String, dynamic> toMap() {
    return {
      'cartNumOfItems': cartNumOfItems,
      'productID': productID,
      'name': name,
      'email': email,
      'phone': phone,
      'uID': uID,
      'dateTime': dateTime,
      // 'cartItemColor': cartItemColor,
    };
  }
}

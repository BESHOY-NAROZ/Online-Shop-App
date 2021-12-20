import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_f_w_online_shop_app/constants.dart';
import 'package:t_f_w_online_shop_app/database/shared_pref.dart';
import 'package:t_f_w_online_shop_app/users/user_type.dart';

import 'file:///C:/Users/besho/AndroidStudioProjects/t_f_w_online_shop_app/lib/home/body.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              color: kTextColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              color: kTextColor,
            ),
            onPressed: () {
              SharedPref.removeData('userToken');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserType()));
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}

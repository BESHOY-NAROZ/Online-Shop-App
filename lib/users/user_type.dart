import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'package:t_f_w_online_shop_app/firebase_login&regestration/login.dart';
import 'package:t_f_w_online_shop_app/users/admin.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        ShopCubit shopCubit = ShopCubit.getShopCubit(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
              child: Text(
                'WELCOME',
                style: TextStyle(
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
          ),
          body: Center(
            child: ToggleSwitch(
              labels: [
                'Admin',
                'User',
              ],
              initialLabelIndex: shopCubit.userType,
              fontSize: 20,
              minHeight: 60,
              minWidth: 100,
              onToggle: (index) {
                shopCubit.cubitSelectUserType(index);
                if (shopCubit.userType == 1) {
                  print(shopCubit.userType);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopLogin()));
                } else if (shopCubit.userType == 0) {
                  print(shopCubit.userType);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopAdmin()));
                }
              },
            ),
          ),
        );
      },
    );
  }
}

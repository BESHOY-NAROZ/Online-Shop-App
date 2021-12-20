import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';

class ShopColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.getShopCubit(context);

        return Scaffold(
            body: Column(
          children: <Widget>[
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialPicker(
                pickerColor: Color(shopCubit.itemColor.value),
                onColorChanged: (color) {
                  shopCubit.cubitSelectItemColor(color);
                  print(color);
                },
                enableLabel: true,
              ),
            ),
          ],
        ));
      },
    );
  }
}

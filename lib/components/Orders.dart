import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.getShopCubit(context);
        return Scaffold(
          body: ListView.separated(
              itemBuilder: (context, index) {
                return ConditionalBuilder(
                  condition: shopCubit.cartList.length > 0,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Customer Name: ${shopCubit.cartList[index].name}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Color(0xFF3D82AE),
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Customer email: ${shopCubit.cartList[index].email}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Color(0xFF3D82AE),
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Customer Phone: ${shopCubit.cartList[index].phone}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Color(0xFF3D82AE),
                                    fontWeight: FontWeight.bold),
                          ),
                          if (shopCubit.cartList[index].productID != null)
                            Text(
                              'Order ID: ${shopCubit.cartList[index].productID}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      color: Color(0xFF3D82AE),
                                      fontWeight: FontWeight.bold),
                            ),
                          if (shopCubit.cartList[index].cartNumOfItems != null)
                            Text(
                              'Order Count: ${shopCubit.cartList[index].cartNumOfItems}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      color: Color(0xFF3D82AE),
                                      fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    );
                  },
                  fallback: (context) {
                    return Center(child: LinearProgressIndicator());
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 2,
                  color: Color(0xFF3D82AE),
                );
              },
              itemCount: shopCubit.cartList.length),
        );
      },
    );
  }
}

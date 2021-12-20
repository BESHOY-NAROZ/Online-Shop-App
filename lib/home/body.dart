import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'package:t_f_w_online_shop_app/constants.dart';
import 'package:t_f_w_online_shop_app/home/details.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ShopCubit shopCubit = ShopCubit();
    // shopCubit.getShopCubit(context);

    ShopCubit shopCubit = ShopCubit.getShopCubit(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 3),
              child: Text(
                'Women',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: shopCubit.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        shopCubit.cubitChangeCategory(index);
                        print(shopCubit.categories[index]);
                        print('body index = $index');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Column(
                          children: <Widget>[
                            Text(
                              shopCubit.categories[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index == shopCubit.index
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                            Container(
                              height: 2,
                              width: 30,
                              color: index == shopCubit.index
                                  ? Colors.black
                                  : Colors.transparent,
                              margin: EdgeInsets.only(top: 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            shopCubit.productsList != null
                ? ConditionalBuilder(
                    condition: shopCubit.productsList.length > 0,
                    builder: (context) {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: shopCubit.productsList.length,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: kDefaultPadding,
                            crossAxisSpacing: kDefaultPadding,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details(
                                        product: shopCubit.productsList[index]),
                                  ),
                                );
                              },
                              child: itemCard(index, shopCubit),
                            );
                          },
                        ),
                      );
                    },
                    fallback: (context) {
                      return Center(
                        child: Center(child: LinearProgressIndicator()),
                      );
                    },
                  )
                : Text('There is no products added yet.',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        );
      },
    );
  }

  Column itemCard(int index, ShopCubit shopCubit) {
    return Column(
      children: <Widget>[
        Container(
          width: 160,
          height: 180,
          decoration: BoxDecoration(
            color: Color(shopCubit.productsList[index].intColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Hero(
            tag: '${shopCubit.productsList[index].id}',
            child: Image(
              image: NetworkImage(shopCubit.productsList[index].image),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 3),
          child: Text(
            shopCubit.productsList[index].title,
            style: TextStyle(color: kTextColor),
          ),
        ),
        Text(
          '\$ ${shopCubit.productsList[index].price.toString()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

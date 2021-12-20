import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'package:t_f_w_online_shop_app/components/Product_Model.dart';
import 'package:t_f_w_online_shop_app/constants.dart';

class Details extends StatelessWidget {
  Product product;

  Details({this.product});

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.getShopCubit(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        return Scaffold(
            backgroundColor: Color(product.intColor),
            appBar: AppBar(
              backgroundColor: Color(product.intColor),
              leading: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/back.svg',
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                IconButton(
                    icon: SvgPicture.asset('assets/icons/search.svg'),
                    onPressed: () {}),
                IconButton(
                    icon: SvgPicture.asset('assets/icons/cart.svg'),
                    onPressed: () {})
              ],
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.444,
                      margin: EdgeInsets.only(top: size.height * .42),
                      padding: EdgeInsets.only(
                          top: kDefaultPadding,
                          left: kDefaultPadding,
                          right: kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding * 2,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'COLOR',
                                      ),
                                      Row(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              shopCubit.cubitChangeColor(0);
                                            },
                                            child: DotCircle(
                                              color: Color(0xFF3D82AE),
                                              colorCircle: shopCubit.boolList[0]
                                                  ? Color(0xFF3D82AE)
                                                  : Colors.transparent,
                                              shopCubit: shopCubit,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              shopCubit.cubitChangeColor(1);
                                            },
                                            child: DotCircle(
                                              color: Color(0xFFD3A984),
                                              colorCircle: shopCubit.boolList[1]
                                                  ? Color(0xFFD3A984)
                                                  : Colors.transparent,
                                              shopCubit: shopCubit,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              shopCubit.cubitChangeColor(2);
                                            },
                                            child: DotCircle(
                                              color: Color(0xFF989493),
                                              colorCircle: shopCubit.boolList[2]
                                                  ? Color(0xFF989493)
                                                  : Colors.transparent,
                                              shopCubit: shopCubit,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'SIZE',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: kDefaultPadding / 2),
                                        child: Text(
                                          '${product.size} CM',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: kDefaultPadding / 2,
                                  left: kDefaultPadding / 2,
                                  right: kDefaultPadding / 2),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 35,
                                    height: 27,
                                    child: OutlineButton(
                                      onPressed: () {
                                        shopCubit.cubitNumOfItems(-1);
                                      },
                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding / 2),
                                    child: Text(
                                      '${shopCubit.numOfItems}'.padLeft(2, '0'),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35,
                                    height: 27,
                                    child: OutlineButton(
                                      onPressed: () {
                                        shopCubit.cubitNumOfItems(1);
                                      },
                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    height: 27,
                                    width: 27,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                        'assets/icons/heart.svg'),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: kDefaultPadding * 1),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 58,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(product.intColor)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/add_to_cart.svg',
                                      color: Color(product.intColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: kDefaultPadding),
                                      child: SizedBox(
                                        height: 50,
                                        child: FlatButton(
                                            color: Color(product.intColor),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18)),
                                            onPressed: () {
                                              shopCubit.cubitAddToCart(
                                                  product.id,
                                                  shopCubit.numOfItems,
                                                  DateTime.now().toString());
                                            },
                                            child: Text(
                                              'BUY NOW',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ),
                                  )
                                  //  FlatButton(onPressed: (){}, child: ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Hand Bag',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            product.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'price\n'),
                                    TextSpan(
                                      text: '\$ ${product.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Hero(
                                  tag: '${product.id}',
                                  child: Image(
                                    image: NetworkImage(product.image),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }
}

class DotCircle extends StatelessWidget {
  const DotCircle({
    @required this.shopCubit,
    @required this.color,
    @required this.colorCircle,
  });

  final ShopCubit shopCubit;
  final Color color;
  final Color colorCircle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding / 2, left: kDefaultPadding),
      padding: EdgeInsets.all(2.5),
      height: 20,
      width: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: colorCircle), shape: BoxShape.circle),
    );
  }
}

//                Text(
//                   'Hand Bag',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   product.title,
//                   style: Theme.of(context).textTheme.headline4.copyWith(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(text: 'price\n'),
//                           TextSpan(
//                             text: '\$ ${product.price}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline4
//                                 .copyWith(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(child: Image.asset(product.image))
//                   ],
//                 ),

//Color(0xFF3D82AE)
//Color(0xFFD3A984)
//Color(0xFF989493)

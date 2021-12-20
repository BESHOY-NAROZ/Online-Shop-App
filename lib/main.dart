import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'package:t_f_w_online_shop_app/database/shared_pref.dart';

import 'file:///C:/Users/besho/AndroidStudioProjects/t_f_w_online_shop_app/lib/home/home.dart';
import 'file:///C:/Users/besho/AndroidStudioProjects/t_f_w_online_shop_app/lib/users/user_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref.sharedDefinition();
  String userToken = SharedPref.getData('userToken');
  runApp(MyApp(userToken));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String userToken;
  MyApp(this.userToken);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ShopCubit()
          ..cubitGetItemPackage()
          ..cubitGetOrders();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              //textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: userToken != null ? MyHomePage() : UserType(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_f_w_online_shop_app/block/cubit.dart';
import 'package:t_f_w_online_shop_app/block/states.dart';
import 'file:///C:/Users/besho/AndroidStudioProjects/t_f_w_online_shop_app/lib/home/body.dart';
import 'package:t_f_w_online_shop_app/firebase_login&regestration/registeration.dart';
import 'file:///C:/Users/besho/AndroidStudioProjects/t_f_w_online_shop_app/lib/home/home.dart';
import 'package:t_f_w_online_shop_app/text_form_field.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
var validateKey = GlobalKey<FormState>();

class ShopLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopSuccessfullyLoginState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      },
      builder: (BuildContext context, ShopStates state) {
        ShopCubit shopCubit = ShopCubit.getShopCubit(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(12),
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: validateKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'login now to browse our offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      defaultFormField(
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ('email must not be empty');
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        prefix: Icons.mail_outline,
                        label: 'Email Address',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ('password must not be empty');
                            }
                            return null;
                          },
                          isPassword: shopCubit.isPassword,
                          controller: passwordController,
                          prefix: Icons.lock_outline,
                          label: 'Password',
                          suffix: shopCubit.icon,
                          suffixPressed: () {
                            shopCubit.cubitChangePasswordVisibility();
                          }),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                          elevation: 20,
                          color: Colors.blue,
                          onPressed: () {
                            if (validateKey.currentState.validate()) {
                              print('Validate');
                              shopCubit.cubitLogin(emailController.text,
                                  passwordController.text);
                            } else {
                              print('Not Validate');
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Don\'t have an account'),
                          FlatButton(
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShopRegistration()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

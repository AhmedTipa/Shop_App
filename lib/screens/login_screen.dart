import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:social__app/screens/register.dart';
import 'package:social__app/screens/shop_app/shop_screen.dart';

import '../Dio_and_Cashe/cache_helper.dart';
import '../constants.dart';
import '../cubit/shopcubit.dart';
import '../cubit/shopstates.dart';

class LogInScreeen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopUserLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              FlutterToastr.show(
                '${state.loginModel.message}',
                context,
                position: FlutterToastr.bottom,
                backgroundColor: Colors.green,
                duration: FlutterToastr.lengthLong,
              );
              CacheHelper.savedata(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                if (value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopScreen()),
                      (route) => false);
                }
              });
            } else {
              print(state.loginModel.message);
              FlutterToastr.show(
                '${state.loginModel.message}',
                context,
                position: FlutterToastr.bottom,
                backgroundColor: Colors.red,
                duration: FlutterToastr.lengthLong,
              );
            }
          }
        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter Your Email';
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please Enter Your password';
                        },
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.shopUserLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        obscureText: cubit.isVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeIconVisible();
                            },
                            icon: Icon(cubit.icon),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopUserLoginLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.shopUserLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Don\'t have an account ?',
                          ),
                          TextButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            },
                            child: Text(
                              'register'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

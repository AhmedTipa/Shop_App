import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:social__app/screens/shop_app/shop_screen.dart';

import '../Dio_and_Cashe/cache_helper.dart';
import '../constants.dart';
import '../cubit/shopcubit.dart';
import '../cubit/shopstates.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopUserRegisterSuccessState) {
            if (state.registerModel.status) {
              FlutterToastr.show(
                '${state.registerModel.message}',
                context,
                position: FlutterToastr.bottom,
                backgroundColor: Colors.green,
                duration: FlutterToastr.lengthLong,
              );
              CacheHelper.savedata(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopScreen()),
                        (route) => false);
              });
            } else {
              FlutterToastr.show(
                '${state.registerModel.message}',
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
                        'register'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter Your Name';
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
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
                            cubit.shopUserRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
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
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter Your Phone';
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.lock_outline),
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
                        condition: state is! ShopUserRegisterLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.shopUserRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            child: Text(
                              'Register',
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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Dio_and_Cashe/cache_helper.dart';
import '../../cubit/shopcubit.dart';
import '../../cubit/shopstates.dart';
import '../on_boarding_screen.dart';

class Setting extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        var model = ShopCubit
            .get(context)
            .userProfile;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.userProfile != null,
          builder: (context) =>
              Center(
                child: SingleChildScrollView(
                  child: Padding(

                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if(state is ShopUpdateDataLoadingState||state is ShopGetUserProfileLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
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
                              if (value!.isEmpty)
                                return 'Please Enter Your Email';
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
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please Enter Your Phone';
                            },
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
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
                          Container(
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                              ),
                              onPressed: () {
                                CacheHelper.removeData(key: 'token').then((
                                    value) =>
                                {
                                  if (value)
                                    {
                                      LinearProgressIndicator(),
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OnBoardingScreen()),
                                              (route) => false)
                                    }
                                });
                              },
                              child: Text(
                                'LogOut'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                              ),
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  cubit.shopUpdateData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }

                              },
                              child: Text(
                                'update'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

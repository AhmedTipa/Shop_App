import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social__app/screens/on_boarding_screen.dart';
import 'package:social__app/screens/shop_app/shop_screen.dart';

import 'Dio_and_Cashe/cache_helper.dart';
import 'Dio_and_Cashe/dio_helper.dart';
import 'constants.dart';
import 'cubit/bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      DioHelper.init();
    },
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();
  Widget ? widget;
  var onboarding = CacheHelper.getData(key: 'onBoarding');
  print(onboarding);
  token = CacheHelper.getData(key: 'token');
  print(token);
  if (onboarding != null) {
    if (token != null)
      widget = ShopScreen();
    else
      widget = OnBoardingScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    token: token,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final String? token;

  MyApp({
    this.startWidget,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:startWidget,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: Colors.white, //لازم scaffold معاها
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 20,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black12,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black12,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        //لازم scaffold معاها
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 20,
            backgroundColor: Colors.black12,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}

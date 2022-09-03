import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social__app/cubit/shopstates.dart';

import '../Dio_and_Cashe/dio_helper.dart';
import '../constants.dart';
import '../models/shop_categories_model.dart';
import '../models/shop_change_favorite_model.dart';
import '../models/shop_favorites_model.dart';
import '../models/shop_home_model.dart';
import '../models/shop_login_model.dart';
import '../models/shop_search_model.dart';
import '../screens/shop_app/category.dart';
import '../screens/shop_app/favorite.dart';
import '../screens/shop_app/home.dart';
import '../screens/shop_app/setting.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  IconData icon = Icons.visibility_sharp;
  bool isVisible = false;

  void changeIconVisible() {
    isVisible = !isVisible;
    isVisible ? icon = Icons.visibility_sharp : icon = Icons.visibility_off;
    emit(ShopChangePasswordVisibleState());
  }

  ShopLoginModel? loginModel;

  void shopUserLogin({
    required String email,
    required String password,
  }) {
    emit(ShopUserLoginLoadingState());
    DioHelper.postData(url: Login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      emit(ShopUserLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserLoginErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    Home(),
    Categories(),
    Favorites(),
    Setting(),
  ];
  int currentIndex = 0;

  void changeBtmNavBar(index) {
    currentIndex = index;
    emit(ShopChangeBtmNavBarState());
  }

  HomeModel? homeModel;
  Map<dynamic, dynamic> favorites = {};

  void getHomeData() {
    emit(ShopHomeModelLoadingState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopHomeModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeModelErrorState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(ShopCategoriesModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesModelErrorState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavoritesData(dynamic productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());

    DioHelper.postData(url: Favoritess, token: token, data: {
      "product_id": productId,
    }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId];
        emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
      } else {
        getFavoritesData();
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      emit(ShopChangeFavoritesErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: Favoritess, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrorState(error));
    });
  }

  ShopLoginModel? userProfile;

  void getUserProfileData() {
    emit(ShopGetUserProfileLoadingState());
    DioHelper.getData(url: Profile, token: token).then((value) {
      userProfile = ShopLoginModel.fromJson(value.data);
      print(userProfile!.data!.phone);
      emit(ShopGetUserProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserProfileErrorState(error));
    });
  }

  ShopLoginModel? registerModel;

  void shopUserRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopUserRegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      registerModel = ShopLoginModel.fromJson(value.data);
      print(registerModel!.status);
      emit(ShopUserRegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserRegisterErrorState(error.toString()));
    });
  }

  ShopLoginModel? updateDataModel;

  void shopUpdateData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateDataLoadingState());
    DioHelper.putData(url: updateProfile, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      print(value.data);
      userProfile = ShopLoginModel.fromJson(value.data);

      emit(ShopUpdateDataSuccessState(userProfile!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateDataErrorState(error.toString()));
    });
  }

    ShopSearchModel?searchModel;
  void getSearchData({required String text}) {
    emit(ShopGetSearchDataLoadingState());
    DioHelper.postData(
        url: Search,
      token: token,
        data: {
          'text':text,
        },

    ).then((value) {
      searchModel=ShopSearchModel.fromJson(value.data);
      emit(ShopGetSearchDataSuccessState());
    }).catchError((error){
      emit(ShopGetSearchDataErrorState(error));
    });
  }
}

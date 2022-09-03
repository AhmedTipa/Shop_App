

import '../models/shop_change_favorite_model.dart';
import '../models/shop_login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangePasswordVisibleState extends ShopStates {}

class ShopUserLoginLoadingState extends ShopStates {}

class ShopUserLoginSuccessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopUserLoginSuccessState(this.loginModel);
}

class ShopUserLoginErrorState extends ShopStates {
  final String error;

  ShopUserLoginErrorState(this.error);
}

class ShopChangeBtmNavBarState extends ShopStates {}

class ShopHomeModelLoadingState extends ShopStates {}

class ShopHomeModelSuccessState extends ShopStates {}

class ShopHomeModelErrorState extends ShopStates {
  final String error;

  ShopHomeModelErrorState(this.error);
}

class ShopCategoriesModelSuccessState extends ShopStates {}

class ShopCategoriesModelErrorState extends ShopStates {
  final String error;

  ShopCategoriesModelErrorState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {
  final String error;

  ShopChangeFavoritesErrorState(this.error);
}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopStates {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopGetUserProfileLoadingState extends ShopStates {}

class ShopGetUserProfileSuccessState extends ShopStates {}

class ShopGetUserProfileErrorState extends ShopStates {
  final String error;

  ShopGetUserProfileErrorState(this.error);
}

class ShopUserRegisterLoadingState extends ShopStates {}

class ShopUserRegisterSuccessState extends ShopStates {
  final ShopLoginModel registerModel;

  ShopUserRegisterSuccessState(this.registerModel);
}

class ShopUserRegisterErrorState extends ShopStates {
  final String error;

  ShopUserRegisterErrorState(this.error);
}

class ShopUpdateDataLoadingState extends ShopStates {}

class ShopUpdateDataSuccessState extends ShopStates {
  final ShopLoginModel updateDataModel;

  ShopUpdateDataSuccessState(this.updateDataModel);
}

class ShopUpdateDataErrorState extends ShopStates {
  final String error;

  ShopUpdateDataErrorState(this.error);
}

class ShopGetSearchDataLoadingState extends ShopStates {}

class ShopGetSearchDataSuccessState extends ShopStates {

}

class ShopGetSearchDataErrorState extends ShopStates {
  final String error;

  ShopGetSearchDataErrorState(this.error);
}

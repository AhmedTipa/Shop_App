class ShopLoginModel {
 late bool status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?UserData.fromJson(json['data']):null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
   String ?token;
  int? points;
  int? credit;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.token,
  //   this.points,
  //   this.credit,
  // });
  UserData.fromJson(Map<String,dynamic>json)     //ده اسمه named constructor
  {
        id=json['id'];
        name=json['name'];
        email=json['email'];
        phone=json['phone'];
        image=json['image'];
        token=json['token'];
        points=json['points'];
        credit=json['credit'];
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../../cubit/shopcubit.dart';
import '../../cubit/shopstates.dart';
import '../../models/shop_categories_model.dart';
import '../../models/shop_home_model.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoritesSuccessState){
            if(state.model.status==false){
              FlutterToastr.show(
                '${state.model.message}',
                context,
                position: FlutterToastr.bottom,
                backgroundColor: Colors.green,
                duration: FlutterToastr.lengthLong,
              );

            }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) =>
                HomeBuilder(cubit.homeModel!, cubit.categoriesModel!,context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget HomeBuilder(HomeModel model, CategoriesModel categoriesModel,context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners
                  .map(
                    // دي بتعمل list للصور كلها ال عندك في ال data

                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 250,
                viewportFraction: 1,
                initialPage: 0,
                autoPlayCurve: Curves.fastOutSlowIn,

              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 110,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          CategoriesBuildel(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data!.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(model.data!.products.length,
                  (index) => ProductBuilder(model.data!.products[index],context)),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,

            ),
          ),
        ],
      ),
    );

Widget ProductBuilder(Products model,context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
              ),
              if (model.oldPrice != 0 && model.oldPrice != model.price)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  //دي بتعرفك ان في لسه كلام متبقي ,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      //دي بتعرفك ان في لسه كلام متبقي ,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    if (model.oldPrice != 0 && model.oldPrice != model.price)
                      Text(
                        '${model.oldPrice}',
                        //دي بتعرفك ان في لسه كلام متبقي ,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration
                              .lineThrough, //بتحط خط تحت الكلام او عليه وهكذا
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavoritesData(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorites[model.id]? Colors.red:Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget CategoriesBuildel(DataModel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        Container(
          width: 110,
          color: Colors.black54.withOpacity(0.5),
          child: Text(
            '${model.name}',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

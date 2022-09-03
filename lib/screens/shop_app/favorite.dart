import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shopcubit.dart';
import '../../cubit/shopstates.dart';
import '../../models/shop_favorites_model.dart';


class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is !ShopGetFavoritesLoadingState,
          builder: (context)=>ListView.separated(
              itemBuilder: (context, index) =>
                  buildFavorites(cubit.favoritesModel!.data!.data![index],context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.black26,
                  width: double.infinity,
                  height: 1,
                ),
              ),
              itemCount: cubit.favoritesModel!.data!.data!.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
Widget buildFavorites(FavoritesData model,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage('${model.product!.image}'),
              height: 120,
              width: 120,
            ),
             if ('${model.product!.price}' != 0 && '${model.product!.oldPrice}' != '${model.product!.price}')
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                'Discount',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),SizedBox(width: 20,),
        Expanded(
          child: Column(
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                //دي بتعرفك ان في لسه كلام متبقي ,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
              '${model.product!.price}',
                    //دي بتعرفك ان في لسه كلام متبقي ,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  if ('${model.product!.price}' != 0 && '${model.product!.oldPrice}' != '${model.product!.price}')
                  Text(
                    '${model.product!.oldPrice}',
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
                       ShopCubit.get(context).changeFavoritesData(model.product!.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id] ? Colors.red:Colors.grey ,
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

  ),
);
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shopcubit.dart';
import '../../cubit/shopstates.dart';
import '../../models/shop_categories_model.dart';


class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCategories(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.black26,
                    width: double.infinity,
                    height: 1,
                  ),
                ),
            itemCount: cubit.categoriesModel!.data!.data.length);
      },
    );
  }
}

Widget buildCategories(DataModel dataModel) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${dataModel.image}'),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${dataModel.name}',
          ),
          Spacer(),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_outlined))
        ],
      ),
    );

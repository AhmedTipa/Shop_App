import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shopcubit.dart';
import '../../cubit/shopstates.dart';
import '../../models/shop_home_model.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (text) {
                        cubit.getSearchData(text: searchController.text);
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Please Enter Your Search';
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is ShopGetSearchDataLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                      itemBuilder: (context, index) => buildSearch(
                          cubit.searchModel!.data!.product![index], context),
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.black26,
                              width: double.infinity,
                              height: 1,
                            ),
                          ),
                      itemCount: cubit.searchModel!.data!.product!.length),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearch(Products model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 120,
                  width: 120,
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    //دي بتعرفك ان في لسه كلام متبقي ,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Spacer(),
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
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavoritesData(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]
                                  ? Colors.red
                                  : Colors.grey,
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

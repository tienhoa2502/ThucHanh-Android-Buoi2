import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category/category_bloc.dart';
import '../../widgets/top_container.dart';

class CategoryDisplayScreen extends StatefulWidget {
  const CategoryDisplayScreen({super.key});

  @override
  State<CategoryDisplayScreen> createState() => _CategoryDisplayScreenState();
}

class _CategoryDisplayScreenState extends State<CategoryDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: [
          TopContainer(title: 'Category', searchBarTitle: "search Category"),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return  const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryLoaded) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.categories[index].imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.categories[index].categoryName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.white
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${state.categories[index].productCount} Products",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.white
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            },
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}

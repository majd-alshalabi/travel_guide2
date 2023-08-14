import 'package:flutter/material.dart';
import 'package:travel_guide/core/constants/app_images.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Column(
        children: [
          Text('Favorites'),
          Container(
            width: width * 0.8,
            height: height * 0.7,
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  Image.asset(
                    ImagesApp.imagesSyria,
                    // width: width,
                    // height: height,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

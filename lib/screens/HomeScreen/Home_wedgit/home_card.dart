import 'package:flutter/material.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/models/MoviesModels/movies_model.dart';

class HomeCard extends StatelessWidget {
  HomeCard({super.key,
    required this.moviesmodel,
    this.width = 250,
    this.height = 350,
  });
  Movies moviesmodel;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(moviesmodel.mediumCoverImage ??""),
              fit: BoxFit.cover,
          ),
        ),
    ),
      Positioned(
        top: 12,
        left: 8,
        child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.Grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${moviesmodel.rating}",style: TextStyle(color: AppColors.White),),
            SizedBox(width: 5,),
            Image.asset(Assets.images1.star1.path,color: AppColors.Yellow,),
          ],
        ),
      ),
      ),
    ],
    );
  }
}

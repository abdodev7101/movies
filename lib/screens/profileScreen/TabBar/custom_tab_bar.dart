import 'package:flutter/material.dart';
import 'package:movie_app/utiles/const/appColors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: AppColors.Yellow,
      labelColor: AppColors.White,
      unselectedLabelColor: AppColors.White,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(
          icon: Icon(Icons.list,color: AppColors.Yellow,),
          text: "Watch List",
        ),
        Tab(
          icon: Icon(Icons.folder,color: AppColors.Yellow,),
          text: "History",
        ),
      ],
    );
  }
}
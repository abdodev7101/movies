// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/Wedgits/bottomBar/cubit/bottom_bar_cubit.dart';
// import 'package:movie_app/Wedgits/bottomBar/cubit/state.dart';
// import 'package:movie_app/generated/assets.dart';
// import 'package:movie_app/utiles/const/appColors.dart';
//
// class BottomBar extends StatelessWidget {
//   const BottomBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BottomBarCubit,BottomBarState>(
//       builder: (context, state) {
//       var cubit = BottomBarCubit.get(context);
//       return Scaffold(
//         backgroundColor: AppColors.Black,
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(24),
//
//             child: BottomNavigationBar(
//               showSelectedLabels: false,
//               showUnselectedLabels: false,
//               backgroundColor: AppColors.Grey,
//               type: BottomNavigationBarType.fixed,
//               currentIndex: cubit.cuttentindex,
//               selectedItemColor: AppColors.Yellow,
//               unselectedItemColor: AppColors.White,
//               onTap: (value){
//                 cubit.changeindex(value);
//               },
//             items: [
//               bottomNavitem(
//                 image: Assets.images1.homeIcon.path,
//                 index: 0,
//                 currentindex: cubit.cuttentindex,
//               ),
//               bottomNavitem(
//                 image: Assets.images1.searchIcon.path,
//                 index: 1,
//                 currentindex: cubit.cuttentindex,
//               ),
//               bottomNavitem(
//                 image: Assets.images1.browseIcon.path,
//                 index: 2,
//                 currentindex: cubit.cuttentindex,
//               ),
//               bottomNavitem(
//                 image: Assets.images1.profielIcon.path,
//                 index: 3,
//                 currentindex: cubit.cuttentindex,
//               ),
//             ],
//             ),
//           ),
//         ),
//         body: cubit.BottomBarPages[cubit.cuttentindex],
//       );
//     }, listener: (context, state) {
//
//     },);
//   }
// }
// // bottomNavitem({index,currentindex,image}){
// //
// // }
// BottomNavigationBarItem bottomNavitem({
//   required int index,
//   required int currentindex,
//   required String image,
// }) {
//   bool isSelected = index == currentindex;
//   return BottomNavigationBarItem(
//     icon: Image.asset(
//       image,
//       color: isSelected ? AppColors.Yellow : AppColors.White,
//     ),
//     label: '',
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Wedgits/bottomBar/cubit/bottom_bar_cubit.dart';
import 'package:movie_app/Wedgits/bottomBar/cubit/state.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/utiles/const/appColors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        var cubit = BottomBarCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.Black,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  enableFeedback: false,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: AppColors.Grey,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.cuttentindex,
                  selectedItemColor: AppColors.Yellow,
                  unselectedItemColor: AppColors.White,
                  onTap: (value) {
                    cubit.changeindex(value);
                  },
                  items: [
                    bottomNavitem(
                      image: Assets.images1.homeIcon.path,
                      index: 0,
                      currentindex: cubit.cuttentindex,
                    ),
                    bottomNavitem(
                      image: Assets.images1.searchIcon.path,
                      index: 1,
                      currentindex: cubit.cuttentindex,
                    ),
                    bottomNavitem(
                      image: Assets.images1.browseIcon.path,
                      index: 2,
                      currentindex: cubit.cuttentindex,
                    ),
                    bottomNavitem(
                      image: Assets.images1.profielIcon.path,
                      index: 3,
                      currentindex: cubit.cuttentindex,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: cubit.BottomBarPages[cubit.cuttentindex],
        );
      },
      listener: (context, state) {},
    );
  }
}

BottomNavigationBarItem bottomNavitem({
  required int index,
  required int currentindex,
  required String image,
}) {
  bool isSelected = index == currentindex;
  return BottomNavigationBarItem(
    icon: Image.asset(
      image,
      color: isSelected ? AppColors.Yellow : AppColors.White,
    ),
    label: '',
  );
}

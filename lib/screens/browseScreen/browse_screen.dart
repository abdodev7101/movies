import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screens/HomeScreen/Home_wedgit/home_card.dart';
import 'package:movie_app/screens/MovieDetailsScreen/movie_details_screen.dart';
import 'package:movie_app/screens/browseScreen/cubit/browse_cubit.dart';
import 'package:movie_app/screens/browseScreen/cubit/state.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowseCubit,BrowseState>(
      builder: (context, state) {
        var cubit = BrowseCubit.get(context);
      return Scaffold(
        backgroundColor: AppColors.Black,
        body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final isSelected = index == cubit.selectedIndex;
                      return GestureDetector(
                        onTap: () => cubit.changeGenre(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ?  AppColors.Yellow : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.Yellow, width: 2),
                          ),
                          child: Text(
                            cubit.genres[index],
                            style: AppStyles.BoldBlack20.copyWith(
                              color: isSelected ? Colors.black : AppColors.Yellow,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10,);
                    },
                    itemCount: cubit.genres.length,
                  ),
                ),
                 SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: cubit.selectedMovies.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.67,
                    ),
                    itemBuilder: (context, index) {
                      final movie = cubit.selectedMovies[index];
                      return GestureDetector(
                        onTap: (){
                       Utils.navigateTo(
                           MovieDetailsScreen(movieId: movie.id!.toInt(),
                           ),
                        context
                       );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Image.network(
                                movie.mediumCoverImage ?? '',
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.Grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${movie.rating ?? 0}',
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.star,color: AppColors.Yellow,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
        ),
      );
    }, listener: (context, state) {

    },);
  }
}

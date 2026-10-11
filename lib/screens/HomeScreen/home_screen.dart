import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/HomeScreen/Home_wedgit/home_card.dart';
import 'package:movie_app/screens/HomeScreen/cubit/home_screen_cubit.dart';
import 'package:movie_app/screens/HomeScreen/cubit/state.dart';
import 'package:movie_app/screens/MovieDetailsScreen/movie_details_screen.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class HomeScreen extends StatefulWidget {

   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeScreenCubit.get(context).getMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = HomeScreenCubit.get(context);
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.Black,
          body: state is GetMoviesLoadingData
              ? Center(child: CircularProgressIndicator(color: AppColors.White))
              : Stack(
            children: [
              if (cubit.movies.isNotEmpty)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 480,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            cubit
                                .movies[cubit.currentIndex]
                                .largeCoverImage ??
                                '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.Black.withAlpha(80),
                        AppColors.Black
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      Assets.images1.availableNow.path,
                      color: AppColors.White,
                      alignment: Alignment.center,
                    ),
                    if (cubit.movies.isNotEmpty)
                      CarouselSlider.builder(
                        itemCount: cubit.movies.length,
                        itemBuilder: (context, index, realIndex) {
                          final movie = cubit.movies[index];
                          return GestureDetector(
                            onTap: () {
                             Utils.navigateTo(
                                 MovieDetailsScreen(
                                   movieId: movie.id!.toInt(),
                                 )
                                 , context
                             );
                            },
                            child: HomeCard(
                              moviesmodel: movie,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() => cubit.currentIndex = index);
                          },
                          height: 380,
                          enlargeCenterPage: true,
                          viewportFraction: 0.55,
                          enlargeFactor: 0.3,
                          enableInfiniteScroll: true,
                        ),
                      ),
                    Image.asset(
                      Assets.images1.watchNow.path,
                      width: 300,
                      height: 120,
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text("Action", style: AppStyles.Reguler20,),
                          trailing: GestureDetector(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("See More", style: AppStyles.BoldYellow20,),
                                Icon(Icons.arrow_forward, color: AppColors.Yellow,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.moviesByGenre["Action"]?.length ?? 0,
                            itemBuilder: (context, index) {
                              final movie = cubit.moviesByGenre["Action"]![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Utils.navigateTo(
                                        MovieDetailsScreen(
                                          movieId: movie.id!.toInt(),
                                        )
                                        , context
                                    );
                                  },
                                  child: HomeCard(
                                    moviesmodel: movie,
                                    width: 110,
                                    height: 160,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text("Comedy", style: AppStyles.Reguler20,),
                          trailing: GestureDetector(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("See More", style: AppStyles.BoldYellow20,),
                                Icon(Icons.arrow_forward, color: AppColors.Yellow,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.moviesByGenre["Comedy"]?.length ?? 0,
                            itemBuilder: (context, index) {
                              final movie = cubit.moviesByGenre["Comedy"]![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Utils.navigateTo(
                                        MovieDetailsScreen(movieId: movie.id!.toInt())
                                        , context
                                    );
                                  },
                                  child: HomeCard(
                                    moviesmodel: movie,
                                    width: 110,
                                    height: 160,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text("Romance", style: AppStyles.Reguler20,),
                          trailing: GestureDetector(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("See More", style: AppStyles.BoldYellow20,),
                                Icon(Icons.arrow_forward, color: AppColors.Yellow,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.moviesByGenre["Romance"]?.length ?? 0,
                            itemBuilder: (context, index) {
                              final movie = cubit.moviesByGenre["Romance"]![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Utils.navigateTo(
                                        MovieDetailsScreen(
                                          movieId: movie.id!.toInt(),
                                        )
                                        , context
                                    );
                                  },
                                  child: HomeCard(
                                    moviesmodel: movie,
                                    width: 110,
                                    height: 160,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
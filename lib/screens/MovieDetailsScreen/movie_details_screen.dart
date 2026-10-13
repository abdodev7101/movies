import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/HomeScreen/Home_wedgit/home_card.dart';
import 'package:movie_app/screens/MovieDetailsScreen/cubit/movie_details_screen_cubit.dart';
import 'package:movie_app/screens/MovieDetailsScreen/cubit/state.dart';
import 'package:movie_app/screens/profileScreen/cubit/profile_cubit.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    MovieDetailsCubit.get(context).getMovieDetails(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        var cubit = MovieDetailsCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.Black,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          cubit.movieDetails?.largeCoverImage ?? '',
                          height: 380,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.Black.withAlpha(150),
                              Colors.transparent,
                              AppColors.Black.withAlpha(210),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.White,
                            size: 20,
                          ),
                          onPressed: () =>
                          Navigator.pop(context)
                        ),
                      ),
                      Positioned(
                        top: 18,
                        right: 15,
                        child: IconButton(
                          icon: Icon(
                            Icons.bookmark,
                            color: (cubit.movieDetails != null &&
                                ProfileCubit.get(context).isSaved(cubit.movieDetails!))
                                ? AppColors.Yellow
                                : AppColors.White,
                          ),
                          onPressed: () {
                            if (cubit.movieDetails != null) {
                              ProfileCubit.get(context).toggleWish(cubit.movieDetails!);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      Image.asset(
                        Assets.images1.startMovie.path,
                        height: 70,
                        width: 70,
                      ),
                      Positioned(
                        bottom: 8,
                        left: 10,
                        right: 10,
                        child: Text(
                          cubit.movieDetails?.titleEnglish ?? "",
                          style: AppStyles.BoldWhite24,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    cubit.movieDetails?.year?.toString() ?? "",
                    style: AppStyles.BoldGrey20,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (cubit.movieDetails != null) {
                          ProfileCubit.get(context).addToHistory(cubit.movieDetails!);
                        }
                        //شرح
                        final directUrl = cubit.movieDetails?.url ?? '';

                        if (directUrl.isNotEmpty) {
                          final Uri url = Uri.parse(directUrl);
                          try {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            debugPrint('Could not launch $url: $e');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.Red,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text("Watch", style: AppStyles.BoldWhite20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                            color: AppColors.Grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite, color: AppColors.Yellow),
                              SizedBox(width: 5),
                              Text(
                                "${cubit.movieDetails?.likeCount ?? 0}",
                                style: AppStyles.BoldWhite24,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                            color: AppColors.Grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: AppColors.Yellow,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${cubit.movieDetails?.runtime ?? 0}",
                                style: AppStyles.BoldWhite24,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.Grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.Yellow,
                                size: 25,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${cubit.movieDetails?.rating ?? 0}",
                                style: AppStyles.BoldWhite24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Screen Shots", style: AppStyles.BoldWhite24),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            child: Image.network(
                              cubit.movieDetails?.largeCoverImage ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            child: Image.network(
                              cubit.movieDetails?.backgroundImageOriginal ?? "",
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Similar", style: AppStyles.BoldWhite24),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemCount: cubit.similarMovies.length > 4
                                ? 4
                                : cubit.similarMovies.length,
                            itemBuilder: (context, index) {
                              final simMovie = cubit.similarMovies[index];
                              return GestureDetector(
                                onTap: () {
                                  Utils.navigateTo(
                                    MovieDetailsScreen(
                                      movieId: cubit.similarMovies[index].id!
                                          .toInt(),
                                    ),
                                    context,
                                  );
                                },
                                child: HomeCard(
                                  moviesmodel: simMovie,
                                  width: 190,
                                  height: 280,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Summary", style: AppStyles.BoldWhite24),
                          SizedBox(height: 10),
                          Text(
                            cubit.movieDetails?.descriptionFull ?? "No Summary",
                            style: AppStyles.Reguler16,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cast", style: AppStyles.BoldWhite24),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.all(8),
                            height: 90,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(16),
                              color: AppColors.Grey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: Image.asset(Assets.images1.cast1.path),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Name : Hayley Atwell",
                                        style: AppStyles.Reguler20,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Character : Captain Carter",
                                        style: AppStyles.Reguler20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            height: 95,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(16),
                              color: AppColors.Grey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: Image.asset(Assets.images1.cast2.path),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Text(
                                        "Name : Elizabeth Olsen",
                                        style: AppStyles.Reguler20,
                                      ),
                                      Text(
                                        "Character : Wanda Maximoff The Scarlet Witch",
                                        style: AppStyles.Reguler20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Genres", style: AppStyles.BoldWhite24),

                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.movieDetails?.genres?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.Grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    cubit.movieDetails?.genres?[index] ?? '',
                                    style: AppStyles.Reguler16,
                                  ),
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
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

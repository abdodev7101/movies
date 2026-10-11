import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/MovieDetailsScreen/movie_details_screen.dart';
import 'package:movie_app/screens/searchScreen/cubit/search_cubit.dart';
import 'package:movie_app/screens/searchScreen/cubit/state.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';
import 'package:movie_app/utiles/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    SearchCubit.get(context).clearSearch();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchState>(
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
        backgroundColor: AppColors.Black,
        appBar: AppBar(
          leading: null,

          backgroundColor: AppColors.Black,
          title: Padding(
            padding: const EdgeInsetsGeometry.only(
              top: 10,
              bottom: 10,
              left: 5,
              right: 5,
            ),
            child: TextField(
              controller: cubit.searchController,
              onChanged: cubit.onSearchChanged,
              style: TextStyle(color: AppColors.White),
              decoration: InputDecoration(
                fillColor: AppColors.Grey,
                prefixIcon: Image.asset(Assets.images1.searchIcon.path, color: AppColors.White),
                hint: Text("Search", style: AppStyles.Reguler16),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
          body: Builder(
            builder: (context) {

              if (state is SearchLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SearchErrorState) {
                return Center(
                  child: Text(state.error, style: AppStyles.BoldWhite24),
                );
              }
              if (state is SearchInitialState) {
                return Center(child: Image.asset(Assets.images1.popcorn.path));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cubit.results.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.67,
                ),
                itemBuilder: (context, index) {
                  final movie = cubit.results[index];
                  return GestureDetector(
                    onTap: (){
                      Utils.navigateToAndFinish(MovieDetailsScreen(movieId: movie.id!.toInt(),
                      ),
                      context
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        movie.mediumCoverImage ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          ),
      );
    }, listener: (context, state) {

    },);
  }
}

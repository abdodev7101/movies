import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Wedgits/bottomBar/cubit/state.dart';
import 'package:movie_app/screens/HomeScreen/home_screen.dart';
import 'package:movie_app/screens/browseScreen/browse_screen.dart';
import 'package:movie_app/screens/profileScreen/profile_screen.dart';
import 'package:movie_app/screens/searchScreen/search_screen.dart';

class BottomBarCubit extends Cubit<BottomBarState>{
  BottomBarCubit() : super(BottomBarInitialState());
  static BottomBarCubit get(context) => BlocProvider.of<BottomBarCubit>(context);
int cuttentindex = 0;

  void changeindex(int index) {
    cuttentindex = index;
    emit(ChangeIndexState());
  }
List BottomBarPages=[
  HomeScreen(),
  SearchScreen(),
  BrowseScreen(),
  ProfileScreen(),
];
}


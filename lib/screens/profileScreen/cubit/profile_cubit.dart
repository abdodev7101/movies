import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/screens/profileScreen/cubit/state.dart';
import 'package:movie_app/utiles/models/MoviesModels/movies_model.dart';
import 'package:movie_app/utiles/models/user_model.dart';
import 'package:movie_app/utiles/remote/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState()) {
    loadListsFromPrefs();
  }

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);

  var db = FirebaseFirestore.instance;
  UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> Avatars = [
    Assets.images1.gamer1.path,
    Assets.images1.gamer2.path,
    Assets.images1.gamer3.path,
  ];

  String get avatarPath => Avatars[userModel?.avatar ?? 0];

  Future<void> getUserData() async {
    emit(ProfileLoadingState());
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        var doc = await db
            .collection(EndPoints.userCollection)
            .doc(uid)
            .get();
        if (doc.exists && doc.data() != null) {
          userModel = UserModel.fromJson(doc.data()!);
          nameController.text = userModel?.name ?? '';
          phoneController.text = userModel?.phone ?? '';

          emit(ProfileSuccessState());
        }
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> updateUserData() async {
    emit(UpdateUserLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final name = nameController.text.trim();
        final phone = phoneController.text.trim();

        await user.updateDisplayName(name);

        userModel = UserModel(
          id: user.uid,
          name: name,
          email: user.email ?? userModel?.email ?? '',
          phone: phone,
          avatar: userModel?.avatar ?? 0,
        );

        await db
            .collection(EndPoints.userCollection)
            .doc(user.uid)
            .update(userModel!.toJson());

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", jsonEncode(userModel!.toJson()));

        emit(UpdateUserSuccessState());
      }
    } catch (e) {
      emit(UpdateUserErrorState(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(DeleteUserLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await db.collection(EndPoints.userCollection).doc(user.uid).delete();
        await user.delete();

        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        emit(DeleteUserSuccessState());
      }
    } catch (e) {
      emit(DeleteUserErrorState(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(SignOutErrorState(e.toString()));
    }
  }

  List<Movies> wishList = [];

  List<Movies> historyList = [];

  bool isSaved(Movies movie) {
    return wishList.any((element) => element.id == movie.id);
  }

  void toggleWish(Movies movie) {
    if (isSaved(movie)) {
      wishList.removeWhere((element) => element.id == movie.id);
    } else {
      wishList.add(movie);
    }
    emit(WishListChangedState());
    saveListsToPrefs();
  }

  void addToHistory(Movies movie) {
    bool exists = historyList.any((element) => element.id == movie.id);
    if (!exists) {
      historyList.add(movie);
      emit(HistoryChangedState());
      saveListsToPrefs();
    }
  }

  Future<void> saveListsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> wishJsonList = wishList.map((e) => jsonEncode(e.toJson())).toList();
    List<String> historyJsonList = historyList.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList('saved_wish_list', wishJsonList);
    await prefs.setStringList('saved_history_list', historyJsonList);
  }

  Future<void> loadListsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? wishJsonList = prefs.getStringList('saved_wish_list');
    List<String>? historyJsonList = prefs.getStringList('saved_history_list');

    if (wishJsonList != null) {
      wishList = wishJsonList.map((e) => Movies.fromJson(jsonDecode(e))).toList();
    }

    if (historyJsonList != null) {
      historyList = historyJsonList.map((e) => Movies.fromJson(jsonDecode(e))).toList();
    }

    emit(ProfileInitialState());
  }
}
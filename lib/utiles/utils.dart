import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utiles/models/user_model.dart';

abstract class Utils {
  static navigateTo(screen, context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => screen));
  }

  static navigateToAndFinish(screen, context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

}
UserModel? userModel;

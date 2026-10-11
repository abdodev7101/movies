
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/utiles/const/appColors.dart';
import 'package:movie_app/utiles/const/appStyles.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String icon;
  final TextEditingController? controller;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

   CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsetsGeometry.only(
          top: 10,
          bottom: 10,
          left: 5,
          right: 5,
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          onChanged: widget.onChanged,
          style: TextStyle(color: AppColors.White),
          decoration: InputDecoration(
            fillColor: AppColors.Grey,
            prefixIcon: Image.asset(widget.icon, color: AppColors.White),
            hint: Text(widget.hint, style: AppStyles.Reguler16),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
              icon: _obscure
                  ? Image.asset(
                Assets.images1.eyeOffIcon.path,
                color: AppColors.White,
                width: 24,
              )
                  : const Icon(
                Icons.visibility,
                color: AppColors.White,
              ),
            )
                : null,
          ),
            ),
      );
  }
}
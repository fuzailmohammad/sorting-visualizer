import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sorting_visualizer/app/theme/app_colors.dart';
import 'package:sorting_visualizer/app/theme/styles.dart';
import 'package:sorting_visualizer/utils/helper/text_field_wrapper.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? maxLength;
  final TextInputType inputType;
  final TextFieldWrapper wrapper;
  final bool isEnabled;

  CustomTextField({
    required this.wrapper,
    required this.hintText,
    this.maxLength,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: wrapper.controller,
        style: Styles.tsPrimaryColorRegular18,
        maxLength: maxLength,
        keyboardType: inputType,
        enabled: isEnabled,
        decoration: InputDecoration(
          errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
          errorStyle: Styles.tsPrimaryColorRegular18,
          counterText: '',
          fillColor: AppColors.white,
          filled: true,
          hintText: hintText,
          enabled: isEnabled,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

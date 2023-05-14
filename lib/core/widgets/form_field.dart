
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pfe_parking_admin/core/theme/theme.dart';

class CustomField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final IconData prefixIc;
  final Widget? suffixIc;
  final String hint;
  final bool isObscure;
  const CustomField({
    Key? key,
    this.onSaved,
    this.validator,
    this.suffixIc,
    required this.prefixIc,
    required this.hint,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h),
        suffixIcon: suffixIc,
        suffixIconColor: AppTheme.kgreyColor,
        prefixIcon: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 27.w,
          ),
          child: Icon(
            prefixIc,
            color: AppTheme.kgreyColor,
          ),
        ),
        filled: true,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppTheme.kgreyColor),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
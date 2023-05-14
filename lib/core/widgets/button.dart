
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPress;
  final Widget child;
  final double width;
  const CustomButton({
    Key? key,
    required this.onPress,
    required this.child,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.h,
      width: width,
      child: ElevatedButton(onPressed: onPress, child: child),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckbox extends HookWidget {
  final bool isChecked;
  final void Function()? onTap;
  final String text;
  final MainAxisAlignment contentPosition;
  const CustomCheckbox({
    Key? key,
    required this.isChecked,
    this.onTap,
    required this.text,
    required this.contentPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: contentPosition,
        children: [
          AnimatedContainer(
              height: 19.h,
              width: 19.w,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: isChecked
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
              child: isChecked
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14.r,
                    )
                  : null),
          SizedBox(width: 15.h),
          Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: GoogleFonts.jost().fontFamily),
            ),
          ),
        ],
      ),
    );
  }
}
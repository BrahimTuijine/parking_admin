// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_parking_admin/core/theme/theme.dart';
import 'package:pfe_parking_admin/core/widgets/button.dart';
import 'package:pfe_parking_admin/core/widgets/check_box.dart';
import 'package:pfe_parking_admin/core/widgets/form_field.dart';

class NormalLogin extends HookWidget {
  NormalLogin({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isChecked = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 37.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Login to your \nAccount',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SizedBox(height: 35.h),
                CustomField(
                  validator: (p0) {
                    return null;
                  },
                  prefixIc: Icons.email,
                  hint: 'Email',
                  onSaved: (value) {},
                ),
                SizedBox(height: 28.h),
                CustomField(
                  validator: (p0) {
                    return null;
                  },
                  prefixIc: Icons.lock,
                  hint: 'Password',
                  onSaved: (value) {},
                ),
                SizedBox(height: 55.h),
                CustomCheckbox(
                  contentPosition: MainAxisAlignment.center,
                  isChecked: isChecked.value,
                  text: 'Remember me',
                  onTap: () {
                    isChecked.value = !isChecked.value;
                  },
                ),
                SizedBox(height: 42.h),
                CustomButton(
                  onPress: () {
                    // context.go('/map');
                  },
                  child: const Text('Sign in'),
                ),
                SizedBox(height: 42.h),
                Text(
                  'Forgot the password?',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppTheme.primaryColor,
                      fontFamily: GoogleFonts.jost().fontFamily),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

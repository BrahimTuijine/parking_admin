import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/core/widgets/button.dart';
import 'package:pfe_parking_admin/core/widgets/form_field.dart';
import 'package:pfe_parking_admin/services/create_user.dart';
import 'package:pfe_parking_admin/services/users.dart';

class CreateUser extends HookWidget {
  CreateUser({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> userData = {"email": "", "password": ""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create User',
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                CustomField(
                  hint: 'Email',
                  prefixIc: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "can not be empty";
                    } else if (!value.contains('@')) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  onSaved: (email) {
                    userData['email'] = email;
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomField(
                  hint: 'Password',
                  prefixIc: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "can not be empty";
                    } else if (value.length < 5) {
                      return "lenght > 5";
                    }
                    return null;
                  },
                  onSaved: (password) {
                    userData['password'] = password;
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                HookBuilder(builder: (context) {
                  final isLoading = useState<bool>(false);
                  if (isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CustomButton(
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        isLoading.value = true;

                        final result = await CreateFirebaseAuthUser.createUser(
                            email: userData['email'],
                            password: userData['password']);

                        if (result == null) {
                          await UsersStore.addUser(
                            {'email': userData['email']},
                          );
                          if (context.mounted) {
                            context.pop();
                          }
                        } else {
                          final snackBar = SnackBar(
                            // actions: const [SizedBox.shrink()],

                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'On Snap!',
                              message: result,

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.failure,
                            ),
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                          isLoading.value = false;
                        }
                      }
                    },
                    child: const Text('Create User'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

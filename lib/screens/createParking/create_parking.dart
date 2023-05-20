// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/core/widgets/button.dart';
import 'package:uuid/uuid.dart';

import '../../core/widgets/form_field.dart';

class CreateParking extends HookWidget {
  CreateParking({
    super.key,
    required this.idAiroPort,
  });

  final String idAiroPort;

  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> parkingData = {
    "id": const Uuid().v4(),
    "name": '',
    'price': 2.5,
    "saved": false,
    "location": {"lat": 45645646, "lng": 4564656},
    "floors": []
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Parking',
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                const CustomField(
                  hint: 'Parking name',
                  prefixIc: Icons.text_format,
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
                      // context.go('/map');
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        isLoading.value = true;

                        await FirebaseFirestore.instance
                            .collection('airports')
                            .doc(idAiroPort)
                            .update({
                          "parking": FieldValue.arrayUnion([parkingData])
                        });
                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    },
                    child: const Text('Create paring'),
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

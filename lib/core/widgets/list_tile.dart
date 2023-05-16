// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pfe_parking_admin/core/theme/theme.dart';

class ParkingListTile extends StatelessWidget {
  final String name;
  final String airoPortName;
  final double price;
  const ParkingListTile({
    Key? key,
    required this.name,
    required this.airoPortName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(
          image: AssetImage("assets/parking.png"),
        ),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
      ),
      subtitle: Text(
        airoPortName,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppTheme.kgreyColor),
      ),
      trailing: Text(price.toString()),
    );
  }
}

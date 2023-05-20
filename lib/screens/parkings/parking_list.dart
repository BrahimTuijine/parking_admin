// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/core/theme/theme.dart';
import 'package:pfe_parking_admin/core/widgets/list_tile.dart';

import 'package:pfe_parking_admin/models/parking_data.dart';

class ParkingList extends HookWidget {
  final ParkingData parkingData;
  const ParkingList({
    super.key,
    required this.parkingData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          context.go('/airoports/createParking', extra: parkingData.idAiroPort);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Paking List',
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: parkingData.parkingList.length,
        itemBuilder: (BuildContext context, int index) {
          return ParkingListTile(
            airoPortName: parkingData.airoPortName,
            name: parkingData.parkingList[index].name,
            price: parkingData.parkingList[index].price,
          );
        },
      ),
    );
  }
}

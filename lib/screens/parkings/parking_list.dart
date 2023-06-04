// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/core/theme/theme.dart';
import 'package:pfe_parking_admin/core/widgets/button.dart';
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
          final p = parkingData.parkingList[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26.r),
                    topRight: Radius.circular(26.r),
                  ),
                ),
                backgroundColor: Colors.transparent,
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * .2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26.r),
                        topRight: Radius.circular(26.r),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: CustomButton(
                                backgroundColor: AppTheme.kgreyColor,
                                onPress: () {
                                  context.pop();
                                },
                                child: const Text('Cancel')),
                          ),
                          SizedBox(
                            width: 200.w,
                            child: CustomButton(
                                backgroundColor: AppTheme.primaryColor,
                                onPress: () async {
                                  final parkingList = parkingData.parkingList
                                      .where((element) => element.id != p.id)
                                      .toList();
                                  print(parkingList);

                                  await FirebaseFirestore.instance
                                      .collection('airports')
                                      .doc(parkingData.idAiroPort)
                                      .update(
                                    {
                                      "parking": parkingList
                                          .map((element) => element.toJson())
                                          .toList(),
                                    },
                                  );

                                  if (context.mounted) {
                                    context.pop();
                                    context.pop();
                                  }
                                },
                                child: const Text('Delete')),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: ParkingListTile(
              airoPortName: parkingData.airoPortName,
              name: parkingData.parkingList[index].name,
              price: parkingData.parkingList[index].price,
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/models/airoport.dart';
import 'package:pfe_parking_admin/models/parking_data.dart';
import 'package:pfe_parking_admin/services/parking.dart';

class AiroportList extends HookWidget {
  const AiroportList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AiroPort List',
          style: TextStyle(fontSize: 15.sp),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  context.go('/normalLogin');
                }
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<Airoport>>(
          stream: ParkingService.readAiroports(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.airplanemode_on_rounded),
                    title: Text(snapshot.data![index].name),
                    onTap: () {
                      context.go(
                        '/parkings',
                        extra: ParkingData(
                          parkingList: snapshot.data![index].parking,
                          airoPortName: snapshot.data![index].name,
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

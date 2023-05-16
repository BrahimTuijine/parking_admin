import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_parking_admin/models/airoport.dart';

class ParkingService {
  static Stream<List<Airoport>> readAiroports() {
    return FirebaseFirestore.instance
        .collection('airports')
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                final result = Airoport.fromJson(e.data());
                return result;
              },
            ).toList());
  }
}

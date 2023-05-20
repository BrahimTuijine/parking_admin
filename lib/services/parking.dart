import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_parking_admin/models/airoport.dart';

class ParkingService {
  static Stream<List<Airoport>> readAiroports() {
    return FirebaseFirestore.instance
        .collection('airports')
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                Map<String, dynamic> map = {"idAiroPort": e.id, ...e.data()};
                final result = Airoport.fromJson(map);
                return result;
              },
            ).toList());
  }
}

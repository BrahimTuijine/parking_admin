import 'package:pfe_parking_admin/models/airoport.dart';

class ParkingData {
  final List<Parking> parkingList;
  final String airoPortName;
  final String idAiroPort;
  ParkingData({
    required this.parkingList,
    required this.airoPortName,
    required this.idAiroPort,
  });
}

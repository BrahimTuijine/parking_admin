class PaymentModel {
  final String? idDoc;
  final String? paymentID;
  final String user;
  final String parking;
  final String airoport;
  final String floor;
  final String place;
  final String date;
  final String duration;
  final int? endTime;
  final bool checked;
  final bool canceled;
  final bool conpleted;

  PaymentModel({
    required this.idDoc,
    required this.endTime,
    required this.checked,
    required this.paymentID,
    required this.user,
    required this.parking,
    required this.airoport,
    required this.floor,
    required this.place,
    required this.date,
    required this.duration,
    required this.canceled,
    required this.conpleted,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
      paymentID: json["paymentID"],
      user: json["user"],
      parking: json["parking"],
      airoport: json["airoport"],
      floor: json["floor"],
      place: json["place"],
      date: json["date"],
      duration: json["duration"],
      canceled: json["canceled"],
      conpleted: json["conpleted"],
      checked: json["checked"],
      endTime: json["endTime"],
      idDoc: json["idDoc"]);

  Map<String, dynamic> toJson() => {
        "user": user,
        "parking": parking,
        "airoport": airoport,
        "floor": floor,
        "place": place,
        "date": date,
        "duration": duration,
        "canceled": canceled,
        "conpleted": conpleted,
        "paymentID": paymentID,
        "endTime": endTime,
        "checked": checked,
      };
}

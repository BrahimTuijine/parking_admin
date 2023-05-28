import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_parking_admin/models/payment_model.dart';

class FirebaseQrCode {
  static Future<List<PaymentModel>> fetchPayments() async {
    final f = await FirebaseFirestore.instance.collection('payments').get();
    final result = f.docs.map((e) {
      Map<String, dynamic> map = {"idDoc": e.id, ...e.data()};
      return PaymentModel.fromJson(map);
    }).toList();
    return result;
  }

  static Stream<List<PaymentModel>> fetchPaymentsStream() {
    return FirebaseFirestore.instance
        .collection('payments')
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                Map<String, dynamic> map = {"idDoc": e.id, ...e.data()};
                final result = PaymentModel.fromJson(map);
                return result;
              },
            ).toList());
  }

  static Future<PaymentModel?> getPaymentWithId(String payementID) async {
    final fetchedResult = await fetchPayments();

    final pp = fetchedResult
        .where((element) => element.paymentID == payementID)
        .toList();

    if (pp.isEmpty) {
      return null;
    } else {
      return pp.first;
    }
  }

  static Future<void> updatePayment(String idDoc) async {
    await FirebaseFirestore.instance
        .collection('payments')
        .doc(idDoc)
        .update({"conpleted": true});
  }
}

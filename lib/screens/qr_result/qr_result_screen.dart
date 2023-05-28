import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pfe_parking_admin/core/theme/theme.dart';
import 'package:pfe_parking_admin/core/widgets/button.dart';
import 'package:pfe_parking_admin/models/payment_model.dart';
import 'package:pfe_parking_admin/services/qr_code_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeResult extends StatelessWidget {
  const QrCodeResult({Key? key, required this.p}) : super(key: key);

  final PaymentModel p;

  @override
  Widget build(BuildContext context) {
    final current = DateTime.now().hour;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Ticket',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 750.h,
              width: 373.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.r),
                border: Border.all(
                  color: AppTheme.kgreyColor,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scan this on the scanner machine\nwhen you are in the parking lot',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kgreyColor,
                        ),
                  ),
                  QrImageView(
                    data: p.paymentID!,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  QrDetails(
                    title1: 'Airoport: ',
                    title2: 'Parking: ',
                    text1: p.airoport,
                    text2: p.parking,
                  ),
                  SizedBox(height: 28.h),
                  QrDetails(
                    title1: 'Floor: ',
                    title2: 'Place: ',
                    text1: '(${p.floor})',
                    text2: '(${p.floor}-${p.place})',
                  ),
                  SizedBox(height: 28.h),
                  QrDetails(
                    title1: 'Date: ',
                    title2: 'Duration: ',
                    text1: '(${p.date})',
                    text2: p.duration,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    p.user,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.kgreyColor,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: 100.h,
                        child: Lottie.asset(
                          p.endTime! > current
                              ? 'assets/lottie/success.json'
                              : 'assets/lottie/error.json',
                          reverse: true,
                        ),
                      ),
                      Visibility(
                        visible: p.endTime! > current,
                        child: Text(
                          "User Can Acess Parking",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.kgreyColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: p.endTime! < current,
                    child: Text(
                      "Could not Access Parking",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.kgreyColor,
                          ),
                    ),
                  ),
                  Visibility(
                    visible: p.endTime! < current,
                    child: Text(
                      "Charge: ${(current - p.endTime!) * 1} TND",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.kgreyColor,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: HookBuilder(
                      builder: (context) {
                        final isLoading = useState<bool>(false);
                        return isLoading.value
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onPress: () async {
                                  isLoading.value = true;
                                  await FirebaseQrCode.updatePayment(p.idDoc!);
                                  if (context.mounted) context.pop();
                                },
                                child: const Text("Done"),
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}

class QrDetails extends StatelessWidget {
  const QrDetails({
    super.key,
    required this.title1,
    required this.title2,
    required this.text1,
    required this.text2,
  });

  final String title1;
  final String title2;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          text: TextSpan(
            text: title1,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.kgreyColor,
                ),
            children: <TextSpan>[
              TextSpan(
                text: text1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: title2,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.kgreyColor,
                ),
            children: <TextSpan>[
              TextSpan(
                text: text2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pfe_parking_admin/core/theme/theme.dart';
import 'package:pfe_parking_admin/models/payment_model.dart';
import 'package:pfe_parking_admin/services/qr_code_service.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          padding: EdgeInsets.only(top: 30.h),
          automaticIndicatorColorAdjustment: true,
          dividerColor: Colors.black,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.kgreyColor,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(
              text: 'Booked',
              icon: Icon(Icons.payment),
            ),
            Tab(
              text: 'Completed',
              icon: Icon(Icons.done_all),
            ),
          ],
        ),
        body: StreamBuilder<List<PaymentModel>>(
          stream: FirebaseQrCode.fetchPaymentsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final onGoing = snapshot.data!
                  .where((element) =>
                      element.canceled == false && element.conpleted == false)
                  .toList();
              final completed = snapshot.data!
                  .where((element) =>
                      element.canceled == false && element.conpleted == true)
                  .toList();

              return TabBarView(
                children: [
                  CustomTabItem(payments: onGoing),
                  CustomTabItem(payments: completed),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    super.key,
    required this.payments,
  });

  final List<PaymentModel> payments;

  @override
  Widget build(BuildContext context) {
    return payments.isNotEmpty
        ? ListView.builder(
            itemCount: payments.length,
            itemBuilder: (BuildContext context, int index) {
              final item = payments[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35.w,
                  vertical: 20.h,
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.local_parking_outlined,
                    ),
                  ),
                  title: Text(
                    item.parking,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.user,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppTheme.kgreyColor),
                      ),
                      Text(
                        item.airoport,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppTheme.kgreyColor),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.do_not_disturb_alt_sharp),
                Text(
                  'No Data Found',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                ),
              ],
            ),
          );
  }
}

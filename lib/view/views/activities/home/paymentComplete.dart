import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:skylark/view/constants/constants.dart';
import 'package:skylark/view/views/activities/home/HomeActivity.dart';
import 'package:skylark/view/widgets/customeAppBar.dart';
import 'package:skylark/view/widgets/loggerWidget.dart';
import 'package:skylark/view/widgets/toast.dart';

class PaymentCompleteActivity extends StatefulWidget {
  DateTime date;
  PaymentCompleteActivity({Key? key, required this.date}) : super(key: key);

  @override
  _PaymentCompleteActivityState createState() =>
      _PaymentCompleteActivityState(date);
}

class _PaymentCompleteActivityState extends State<PaymentCompleteActivity> {
  DateTime date;
  _PaymentCompleteActivityState(this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(title: "Confirmation"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildColumn(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Payment Successful", style: kTextStyleHeader1),
        const SizedBox(height: 20),
        Text(
          "Your service has successfully been booked for the ${date}\n Please check your email address for your confirmation",
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeActivity(),
              ),
            );
          },
          child: Text("Back To Home"),
        )
      ],
    );
  }
}

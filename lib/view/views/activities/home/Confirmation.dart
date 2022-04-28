import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:skylark/model/core/BookingModel.dart';
import 'package:skylark/provider/BookingProvider.dart';
import 'package:skylark/provider/SharedPreferenceProvider.dart';
import 'package:skylark/view/constants/constants.dart';
import 'package:skylark/view/constants/enum.dart';
import 'package:skylark/view/views/activities/home/paymentComplete.dart';
import 'package:skylark/view/widgets/customeAppBar.dart';
import 'package:skylark/view/widgets/dialogs.dart';
import 'package:skylark/view/widgets/loggerWidget.dart';
import 'package:skylark/view/widgets/toast.dart';

class Confirmation extends StatefulWidget {
  DateTime date;
  String service, serviceId, price;
  Confirmation({
    Key? key,
    required this.date,
    required this.serviceId,
    required this.service,
    required this.price,
  }) : super(key: key);

  @override
  _ConfirmationState createState() =>
      _ConfirmationState(date, service, price, serviceId);
}

class _ConfirmationState extends State<Confirmation> {
  DateTime date;
  String service, price, serviceId;
  _ConfirmationState(this.date, this.service, this.price, this.serviceId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(
        title: "Confirmation",
        context: context,
      ),
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
      children: [
        SizedBox(height: 20),
        const Text("Booking Details", style: kTextStyleHeader1),
        const SizedBox(height: 20),
        buildRow(title: "Date", value: date),
        buildRow(title: "Service", value: service),
        buildRow(title: "Price", value: "ZMW $price"),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await beginPayment();
            },
            child: const Text("Confirm"),
          ),
        )
      ],
    );
  }

  Widget buildRow({required title, required value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title:", style: kTextStyleHint),
          Text("$value"),
        ],
      ),
    );
  }

  beginPayment() async {
    try {
      String currency = FlutterwaveCurrency.ZMW;
      var refrence = DateTime.now().millisecondsSinceEpoch.toString();
      Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: this.context,
        encryptionKey: "FLWSECK_TESTa83747c7397c",
        publicKey: "FLWPUBK_TEST-a57bd9375b9aa5bf9422064fc04521bf-X",
        currency: currency,
        amount: "10",
        email: "michaelnawa1998@gmail.com",
        fullName: "michael nawa",
        txRef: refrence,
        isDebugMode: true,
        phoneNumber: "0978905095",
        acceptCardPayment: true,
        acceptUSSDPayment: true,
        acceptAccountPayment: false,
        acceptZambiaPayment: true,
      );

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        toastMessage(context: context, message: "ERROR; no response");
      } else {
        final isSuccessful = checkPaymentIsSuccessful(
          response: response,
          amount: price,
          currency: currency,
          txref: refrence,
        );
        if (isSuccessful) {
          toastMessage(context: context, message: "Payment Successful");

          makeBooking();
        } else {
          toastMessage(context: context, message: "ERROR; ${response.message}");
        }
      }
    } catch (error) {
      loggerError(message: error.toString());
    }
  }

  bool checkPaymentIsSuccessful({
    required ChargeResponse response,
    required currency,
    required amount,
    required txref,
  }) {
    return response.data?.status == FlutterwaveConstants.SUCCESSFUL;
  }

  Future<void> makeBooking() async {
    SharedPreferenceProvider sp = SharedPreferenceProvider();
    BookingProvider bookingProvider = BookingProvider();
    PopUpDialog dialog = PopUpDialog(context: context);
    //
    dialog.showLoadingAnimation(context: context);
    var userId = await sp.getStringValue(getEnumValue(UserDetails.userId));
    var response = await bookingProvider.bookingsCreate(
      showResponse: true,
      model: BookingModelObj(
        id: 0,
        userId: int.parse(userId!),
        serviceId: int.parse(serviceId),
        modelId: 2,
        bookingDate: date,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentCompleteActivity(date: date),
      ),
    );
  }
}

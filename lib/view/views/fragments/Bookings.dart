import 'package:flutter/material.dart';
import 'package:skylark/provider/BookingProvider.dart';
import 'package:skylark/provider/SharedPreferenceProvider.dart';
import 'package:skylark/view/constants/enum.dart';
import 'package:skylark/view/widgets/toast.dart';

import '../../../model/core/BookingModel.dart';
import '../../widgets/customeAppBar.dart';
import '../../widgets/serviceCardPro.dart';

class BookingFragment extends StatefulWidget {
  const BookingFragment({Key? key}) : super(key: key);

  @override
  _BookingFragmentState createState() => _BookingFragmentState();
}

class _BookingFragmentState extends State<BookingFragment> {
  var provider = BookingProvider();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var sp = SharedPreferenceProvider();
    var userId = await sp.getStringValue(getEnumValue(UserDetails.userId));
    await provider.bookingGetByID(userID: int.parse(userId ?? "0"));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: modelsList(),
            ),
    );
  }

  Widget modelsList() {
    return StreamBuilder(
        stream: provider.providerList,
        builder: (
          context,
          AsyncSnapshot<List<BookingModelObj>> snapshot,
        ) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                var dataValue = data[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    child: serviceCardPro(
                      context: context,
                      imagePath: dataValue.servicesModel?.imagePath ?? "",
                      title:
                          "SERVICE: ${dataValue.servicesModel?.title}\nDATE BOOKED: ${dataValue.timestamp}",
                      function: () {
                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: () async {
                            await provider.bookingsDelete(id: dataValue.id);
                            toastMessage(
                              context: context,
                              message: "Booking ${dataValue.id} removed",
                            );
                            Navigator.pop(context);
                          },
                        );
                        Widget cancel = TextButton(
                          child: Text("NO"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text("CANCEL BOOKING"),
                              content: Text(
                                "Are you sure you want to canel booking?",
                              ),
                              actions: [
                                cancel,
                                okButton,
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

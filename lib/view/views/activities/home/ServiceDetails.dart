import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skylark/view/constants/constants.dart';
import 'package:skylark/view/widgets/loggerWidget.dart';
import 'package:skylark/view/widgets/toast.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../model/core/BookingModel.dart';
import '../../../../model/core/LocationModel.dart';
import '../../../../provider/BookingProvider.dart';
import '../../../../provider/LocationProvider.dart';
import '../../../widgets/mapMarkers.dart';
import '../../../widgets/meetings.dart';
import 'Confirmation.dart';

class ServiceDetails extends StatefulWidget {
  String title, imagePath, serviceId, aboutService, cost;
  ServiceDetails({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.serviceId,
    required this.aboutService,
    required this.cost,
  }) : super(key: key);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState(
        title,
        imagePath,
        serviceId,
        aboutService,
        cost,
      );
}

class _ServiceDetailsState extends State<ServiceDetails> {
  String title, imagePath, serviceId, aboutService, cost;
  var bookingProvider = BookingProvider();
  final List<Meeting> meetings = <Meeting>[];
  var LocationProviders = LocationProvider();
  BookingModel? bookingModel;
  bool isLoading = true;
  LocationModel? locationModel;
  _ServiceDetailsState(
    this.title,
    this.imagePath,
    this.serviceId,
    this.aboutService,
    this.cost,
  );

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var data = await bookingProvider.bookingsGetAll();
    var result = await LocationProviders.locationGetAll();

    for (var dataValue in data!.results!) {
      final DateTime date = dataValue.bookingDate!;
      final DateTime today = DateTime(date.year, date.month, date.day);
      final DateTime startTime = DateTime(today.year, today.month, today.day);
      final DateTime endTime = startTime.add(const Duration(hours: 2));
      setState(() {
        locationModel = result;
        meetings.add(Meeting(
          'BOOKED',
          startTime,
          endTime,
          kAccent,
          true,
        ));
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text(title),
              background: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: buildBody(),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: kTextStyleHeader1),
                  SizedBox(height: 5),
                  Text("Lusaka, Zambia", style: kTextStyleHint),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        openBottomSheet();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Check Availablity"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("About Service", style: kTextStyleHeader2),
                  SizedBox(height: 10),
                  Text(aboutService, style: kTextStyleHint),
                  SizedBox(height: 20),
                  Text("Location Center", style: kTextStyleHeader2),
                  SizedBox(height: 10),
                  locationMap(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Cost",
                            style: kTextStyleHint.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("K $cost"),
                        ],
                      ),
                      SizedBox(width: 80),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            openBottomSheet();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("BOOK NOW"),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  void openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Select Booking Date",
                  style: kTextStyleHeader2,
                ),
              ),
              calenderBody(),
            ],
          ),
        );
      },
    );
  }

  calenderBody() {
    return Expanded(
      child: SfCalendar(
        view: CalendarView.month,
        onSelectionChanged: (data) {
          submitData(data);
        },
        dataSource: MeetingDataSource(meetings),
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
      ),
    );
  }

  void submitData(CalendarSelectionDetails data) {
    DateTime date = data.date!;
    final DateTime today = DateTime(date.year, date.month, date.day);
    final DateTime startTime = DateTime(today.year, today.month, today.day);
    bool dateBooked = false;
    for (var i = 0; i < meetings.length; i++) {
      var meetingDate = meetings[i].from;
      if (meetingDate == startTime) {
        dateBooked = true;
        i = meetings.length;
      } else {
        dateBooked = false;
      }
    }

    if (dateBooked) {
      Navigator.pop(context);
      toastMessage(context: context, message: "Date already booked");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Confirmation(
            date: date,
            serviceId: serviceId,
            service: title,
            price: cost,
          ),
        ),
      );
    }
  }

  locationMap() {
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(
            double.parse(locationModel?.results.first.latitude ?? ""),
            double.parse(locationModel?.results.first.longitude ?? ""),
          ),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
          ),
          MarkerLayerOptions(
            markers: [
              mapMarkers(
                latitude: double.parse(
                  locationModel?.results.first.latitude ?? "",
                ),
                longitude: double.parse(
                  locationModel?.results.first.longitude ?? "",
                ),
                title: locationModel?.results.first.title ?? "",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

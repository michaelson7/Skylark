import 'package:flutter/material.dart';
import '../../../../model/core/ModelsModel.dart';
import '../../../../model/core/ServicesModel.dart';
import '../../../../provider/ModelsProvider.dart';
import '../../../../provider/ServicesProvider.dart';
import '../../../widgets/ImageList.dart';
import '../../../widgets/customeAppBar.dart';
import '../../../widgets/serviceCard.dart';
import '../../../widgets/serviceCardPro.dart';
import 'ServiceDetails.dart';

class ServiceList extends StatefulWidget {
  String title;
  ServiceList({Key? key, required this.title}) : super(key: key);

  @override
  _ServiceListState createState() => _ServiceListState(title);
}

class _ServiceListState extends State<ServiceList> {
  String title;
  var modelsProvider = ModelsProvider();
  var servicesProvider = ServicesProvider();
  bool isLoading = true;
  Widget? widgetValue;
  _ServiceListState(this.title);

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await modelsProvider.getAllModels();
    await servicesProvider.getAllServices();
    switch (title) {
      case "Popular Packages":
      case "Services":
        setState(() => widgetValue = servicesList());
        break;
      case "Top Models":
        setState(() => widgetValue = modelsList());
        break;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(
        title: title,
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: widgetValue,
            ),
    );
  }

  servicesList() {
    return StreamBuilder(
        stream: servicesProvider.providerList,
        builder: (
          context,
          AsyncSnapshot<List<ServicesModelObj>> snapshot,
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
                      imagePath: dataValue.imagePath ?? "",
                      title: dataValue.title,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetails(
                              title: dataValue.title,
                              cost: dataValue.cost.toStringAsFixed(1),
                              aboutService: dataValue.description,
                              serviceId: dataValue.id.toString(),
                              imagePath: dataValue.imagePath ?? "",
                            ),
                          ),
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

  Widget? modelsList() {
    return StreamBuilder(
        stream: modelsProvider.providerList,
        builder: (
          context,
          AsyncSnapshot<List<ModelsModelObj>> snapshot,
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
                      imagePath: dataValue.imagePath ?? "",
                      title: dataValue.title,
                      function: () {},
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

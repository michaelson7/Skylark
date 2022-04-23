import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skylark/provider/ServicesProvider.dart';
import 'package:skylark/view/constants/constants.dart';
import '../../../model/core/ModelsModel.dart';
import '../../../model/core/ServicesModel.dart';
import '../../../provider/ModelsProvider.dart';
import '../../widgets/ImageList.dart';
import '../../widgets/seeMoreBtn.dart';
import '../../widgets/serviceCard.dart';
import '../../widgets/serviceCardPro.dart';
import '../activities/home/ServiceDetails.dart';
import '../activities/home/ServiceList.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  var modelsProvider = ModelsProvider();
  var servicesProvider = ServicesProvider();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await modelsProvider.getAllModels();
    await servicesProvider.getAllServices();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildModelsList(),
                  const SizedBox(height: 20),
                  buildServiceList(),
                  const SizedBox(height: 30),
                  buildPopularServiceList(),
                  const SizedBox(height: 30),
                  buildTopModels(),
                ],
              ),
      ),
    );
  }

  Widget buildModelsList() {
    return SizedBox(
      height: 40,
      child: StreamBuilder(
          stream: modelsProvider.providerList,
          builder: (context, AsyncSnapshot<List<ModelsModelObj>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int i) => Row(
                  children: [
                    Text(
                      "${data?[i].title}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }

  Widget buildServiceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Services", style: kTextStyleHeader2),
            seeMoreBtn(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceList(title: "Services"),
                  ),
                );
              },
              text: "See More",
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 160,
          child: StreamBuilder(
              stream: servicesProvider.providerList,
              builder: (
                context,
                AsyncSnapshot<List<ServicesModelObj>> snapshot,
              ) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var dataValue = data[i];
                      return Row(
                        children: [
                          serviceCard(
                            imagePath: dataValue.imagePath,
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
                          const SizedBox(width: 15),
                        ],
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              }),
        )
      ],
    );
  }

  Widget buildPopularServiceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Popular Packages", style: kTextStyleHeader2),
            seeMoreBtn(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ServiceList(title: "Popular Packages"),
                  ),
                );
              },
              text: "See More",
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 160,
          child: StreamBuilder(
              stream: servicesProvider.providerList,
              builder: (
                context,
                AsyncSnapshot<List<ServicesModelObj>> snapshot,
              ) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var dataValue = data[i];
                      return Row(
                        children: [
                          serviceCardPro(
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
                          const SizedBox(width: 15),
                        ],
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              }),
        )
      ],
    );
  }

  Widget buildTopModels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Top Models", style: kTextStyleHeader2),
            seeMoreBtn(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceList(title: "Top Models"),
                  ),
                );
              },
              text: "See More",
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 70,
          child: StreamBuilder(
              stream: modelsProvider.providerList,
              builder: (context, AsyncSnapshot<List<ModelsModelObj>> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var dataValue = data[i];
                      return Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.elliptical(35, 35),
                                  ),
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop,
                                    ),
                                    image: CachedNetworkImageProvider(
                                      dataValue.imagePath ?? "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey,
                                ),
                                height: 70,
                                width: 70,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataValue.title,
                                      style: kTextStyleHeader2,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      dataValue.title,
                                      style: kTextStyleHint,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                        ],
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              }),
        )
      ],
    );
  }
}

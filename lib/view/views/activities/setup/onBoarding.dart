import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skylark/view/constants/constants.dart';
import 'package:skylark/view/views/activities/setup/RegistrationActivity.dart';
import 'package:skylark/view/views/activities/setup/login.dart';

class OnBoarding extends StatelessWidget {
  static String id = "OnBoarding";
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: buildContainer(context),
            ),
          )
        ],
      ),
    );
  }

  SizedBox buildContainer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Welcome To Skylark",
            style: kTextStyleHeader1.copyWith(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              "Company Slogan",
              style: kTextStyleHint,
            ),
          ),
          buttons(
            function: () {
              Navigator.pushNamed(context, LoginActivity.id);
            },
            title: "Login",
          ),
          buttons(
            function: () {
              Navigator.pushNamed(context, RegistrationActivity.id);
            },
            title: "Register",
          ),
        ],
      ),
    );
  }

  Widget buttons({
    required Function function,
    required title,
  }) {
    return InkWell(
      onTap: () => function(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                title,
                style: kTextStyleWhite,
              )),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skylark/model/core/UsersModel.dart';
import 'package:skylark/provider/UsersProvider.dart';
import 'package:skylark/view/constants/constants.dart';
import 'package:skylark/view/views/activities/home/HomeActivity.dart';
import 'package:skylark/view/views/activities/setup/RegistrationActivity.dart';
import 'package:skylark/view/widgets/toast.dart';

import '../../../widgets/customeAppBar.dart';
import '../../../widgets/dialogs.dart';

class LoginActivity extends StatefulWidget {
  static String id = "LoginActivity";
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  var username = TextEditingController(), password = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    username.text = "admin@admin.com";
    password.text = "admin@admin.com";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(title: "Login"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: buildColumn(context),
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Login Credentials",
            style: kTextStyleHeader2,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: username,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          TextFormField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                submitData();
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Continue"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, RegistrationActivity.id);
                      },
                      child: Text(
                        "Register Now",
                        style: kTextStyleAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> submitData() async {
    if (_key.currentState!.validate()) {
      var provider = UsersProvider();
      PopUpDialog dialog = PopUpDialog(context: context);
      dialog.showLoadingAnimation(context: context);
      //
      var result = await provider.usersLogin(
        showResponse: true,
        model: UsersModel(
          id: 0,
          names: "names",
          email: username.text,
          password: password.text,
          accountTypeId: 0,
        ),
      );
      //
      if (!result!.error) {
        Navigator.pushReplacementNamed(context, HomeActivity.id);
      } else {
        toastMessage(context: context, message: "${result.errorMessage}");
      }
    } else {
      toastMessage(context: context, message: "Please fill in data");
    }
  }
}

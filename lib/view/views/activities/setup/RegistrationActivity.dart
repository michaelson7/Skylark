import 'package:flutter/material.dart';
import 'package:skylark/view/views/activities/setup/login.dart';

import '../../../../model/core/UsersModel.dart';
import '../../../../provider/UsersProvider.dart';
import '../../../constants/constants.dart';
import '../../../widgets/customeAppBar.dart';
import '../../../widgets/dialogs.dart';
import '../../../widgets/toast.dart';
import '../home/HomeActivity.dart';

class RegistrationActivity extends StatefulWidget {
  static String id = "RegistrationActivity";
  const RegistrationActivity({Key? key}) : super(key: key);

  @override
  State<RegistrationActivity> createState() => _RegistrationActivityState();
}

class _RegistrationActivityState extends State<RegistrationActivity> {
  var emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(
        title: "Registration",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: buildColumn(context),
      ),
    );
  }

  Form buildColumn(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Sign Up", style: kTextStyleHeader2),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(height: 20),
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
            padding: const EdgeInsets.all(15),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, LoginActivity.id);
                      },
                      child: Text(
                        "Login Now",
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
        model: UsersModel(
          id: 0,
          names: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          accountTypeId: 2,
        ),
      );
      //
      if (!result!.error) {
        Navigator.popAndPushNamed(context, HomeActivity.id);
      } else {
        toastMessage(context: context, message: "${result.errorMessage}");
      }
    } else {
      toastMessage(context: context, message: "Please fill in data");
    }
  }
}

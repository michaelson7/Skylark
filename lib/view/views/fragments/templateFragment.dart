import 'package:flutter/material.dart';

class TemplateFragment extends StatefulWidget {
  const TemplateFragment({Key? key}) : super(key: key);

  @override
  _TemplateFragmentState createState() => _TemplateFragmentState();
}

class _TemplateFragmentState extends State<TemplateFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Template"),
    );
  }
}

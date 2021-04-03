import 'package:flutter/material.dart';
import 'package:fluttera_share/widgets/header.dart';
import 'package:fluttera_share/widgets/progress.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,isAppTittle:true,titleText: "Profile"),
      body: Center(child: Text("Profile")),
      //LinearProgressIndicator(),
    );
  }
}

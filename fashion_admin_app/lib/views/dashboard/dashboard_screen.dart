import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: beigeColor,
          title: Text(
        'Home',
        style: TextStyle(fontSize: 30),
      )),
      body: Center(
        child: Text("hi ia m dashbord"),
      ),
    );
  }
}

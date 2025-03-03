
import 'package:fashion_client_app/widgets/custom_empty_widget.dart';
import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: CustomEmptyWidget(text: "Please check your internet connection", asset: "assets/offline.json")
      ),
    );
  }
}

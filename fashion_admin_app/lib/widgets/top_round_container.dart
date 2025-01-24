import 'package:flutter/material.dart';

class TopRoundContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  const TopRoundContainer({
    super.key,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius:const BorderRadius.only(topLeft: Radius.circular(40))),
      child: child,
    );
  }
}

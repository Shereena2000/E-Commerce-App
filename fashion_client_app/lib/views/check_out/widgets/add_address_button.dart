import 'package:flutter/material.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add),
      title: const Text("Use a different address"),
      onTap: () {
        Navigator.pushNamed(context, '/addDetails');
      },
    );
  }
}
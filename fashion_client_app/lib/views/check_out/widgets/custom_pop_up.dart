import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomPopUp({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              onEdit();
            },
            child: const Text("Edit"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text("Delete"),
          ),
        ),
      ],
    );
  }
}

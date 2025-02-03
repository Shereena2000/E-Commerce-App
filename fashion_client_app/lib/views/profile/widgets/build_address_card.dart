import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/profile_service.dart';
import 'package:fashion_client_app/views/add_details_screen.dart';

import 'package:flutter/material.dart';

class BuildAddressCard extends StatelessWidget {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String? label;
  final String pinCode;
  final String email;
  final String? state;
 const BuildAddressCard({
    super.key,
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.label,
    required this.pinCode,
    required this.email,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    print(label);
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: blackColor,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddDetailsScreen(profileId: id, isModify: true)),
                  );
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: blackColor,
                  size: 20,
                ),
                onPressed: () {
                  ProfileService().deleteProfiles(doId: id);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: label != null && label!.isNotEmpty
                ? Text(
                    label!,
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox(),
          ),
          const SizedBox(height: 8),
          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          state != null
              ? Text(
                  'State:  $state',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                )
              : SizedBox(),
          Text(
            'Pin code:  $pinCode',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Text(
            email,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Text(
            phone,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

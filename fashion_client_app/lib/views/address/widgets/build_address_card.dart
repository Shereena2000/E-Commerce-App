import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/views/address/add_address_screen.dart';
import 'package:fashion_client_app/widgets/additional_confirm.dart';
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
    return Container(
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
                      builder: (context) => AddAddressScreen(
                        id: id,
                        isModify: true,
                        name: name,
                        email: email,
                        address: address,
                        pinCode: pinCode,
                        state: state,
                        phoneNumber: phone,
                        addresslabel: label,
                      ),
                    ),
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
                    showDialog(
        context: context,
        builder: (context) => AdditionalConfirm(
              contentText: "Are you sure you want to delete this?",
              onNo: () {
                Navigator.pop(context);
              },
              onYes: () {
            DbService().deleteAddress(doId: id);
                Navigator.pop(context);
              },
            ));

                },
              ),
            ],
          ),
          Text(address, style: normalText),
          Text('Pincode:  $pinCode', style: normalText),
          state != null
              ? Text('State:  $state', style: normalText)
              : const SizedBox(),
          Text(email, style: normalText),
          Text(phone, style: normalText),
          liteSpacing,
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
                : const SizedBox(),
          ),
          liteSpacing,
        ],
      ),
    );
  }
}

  

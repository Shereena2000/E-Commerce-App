import 'package:fashion_client_app/model/address_form_data.dart';
import 'package:fashion_client_app/provider/address_provider.dart';
import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class AddresslabelSelector extends StatelessWidget {
  const AddresslabelSelector({
    super.key,
    required this.id,
    required this.formData,
    required this.provider,
  });

  final String id;
  final AddressFormData formData;
  final AddressProvider provider;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: addressLabelList
          .map((label) => InkWell(
                onTap: () => provider.updateFormData(id, addressLabel: label),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: formData.addressLabel == label
                          ? Colors.black
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(label),
                ),
              ))
          .toList(),
    );
  }
}




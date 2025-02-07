import 'package:fashion_client_app/provider/profile_provider.dart';
import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.formData,
      required this.id,
      required this.provider});

  final AddressFormData formData;
  final String id;
  final ProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: formData.state,
      decoration: const InputDecoration(
        labelText: 'State',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
      items: statesList
          .map((state) => DropdownMenuItem(
                value: state,
                child: Text(state,),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          provider.updateFormData(id, state: value);
        }
      },
    );
  }
}
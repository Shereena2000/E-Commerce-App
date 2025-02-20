import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/provider/address_provider.dart';
import 'package:fashion_client_app/utils/form_validator.dart';
import 'package:fashion_client_app/utils/my_validator.dart';
import 'package:fashion_client_app/views/address/widgets/address_label_selector.dart';
import 'package:fashion_client_app/views/address/widgets/custom_drop_down.dart';
import 'package:fashion_client_app/widgets/build_text_feild.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatelessWidget {
  final bool isModify;
  final String id;
  final String? name;
  final String? email;
  final String? address;
  final String? pinCode;
  final String? state;
  final String? phoneNumber;
  final String? addresslabel;

  AddAddressScreen({
    super.key,
    required this.id,
    this.name,
    this.email,
    this.address,
    this.pinCode,
    this.state,
    this.phoneNumber,
    this.addresslabel,
    required this.isModify,
  }) {
    // Initialize controllers with provided values
    nameController.text = name ?? '';
    emailController.text = email ?? '';
    addressController.text = address ?? '';
    pinCodeController.text = pinCode ?? '';
    phoneNumberController.text = phoneNumber ?? '';
  }

  // Controllers as final fields
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isModify ? 'Modify Details' : 'Add Details'),
      ),
      body: Consumer<AddressProvider>(
        builder: (context, provider, child) {
          final formData = provider.getFormData(id);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (isModify) {
              provider.initializeFormData(
                id,
                state: state,
                addressLabel: addresslabel,
              );
            }
          });

          return Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextFeild(
                    controller: nameController,
                    validator: (value) => validateNotEmpty(value),
                    label: 'Name',
                  ),
                  moderateSpacing,
                  BuildTextFeild(
                    controller: emailController,
                    label: 'Email',
                    validator: (value) => MyValidator.emailValidator(value),
                  ),
                  moderateSpacing,
                  InkWell(
                    onTap: (){
                      provider.getLocation(context,addressController,pinCodeController);
                    },
                    child: const Row(
                      children: [
                        litewidthspacing,
                        Icon(Icons.location_on),
                        moderateSpacing,
                        Text("Use My Location")
                      ],
                    ),
                  ),
                  moderateSpacing,
                  BuildTextFeild(
                    controller: addressController,
                    label: 'Address',
                    validator: (value) => validateNotEmpty(value),
                    maxLines: 3,
                  ),
                  moderateSpacing,
                  Row(children: [
                    Expanded(
                        child: BuildTextFeild(
                      controller: pinCodeController,
                      label: 'Pin Code',
                      validator: (value) => validatePincode(value),
                    )),
                    litewidthspacing,
                    Expanded(
                      child: CustomDropDown(
                        formData: formData,
                        id: id,
                        provider: provider,
                      ),
                    ),
                  ]),
                  moderateSpacing,
                  BuildTextFeild(
                    controller: phoneNumberController,
                    label: 'Phone Number',
                    validator: (value) => validatePhoneNumber(value),
                  ),
                  moderateSpacing,
                  const Text(
                    'Save as',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  liteSpacing,
                  AddresslabelSelector(
                    id: id,
                    formData: formData,
                    provider: provider,
                  ),
                  largerSpacing,
                  Center(
                    child: CustomButton(
                      text: isModify ? "Update" : 'ADD',
                      onPressed: () => provider.handleSubmit(
                        formKey: formKey,
                        isModify: isModify,
                        id: id,
                        name: nameController.text,
                        email: emailController.text,
                        addAddress: addressController.text,
                        pinCode: pinCodeController.text,
                        phoneNumber: phoneNumberController.text,
                        context: context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

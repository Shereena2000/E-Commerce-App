import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/profile_service.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AddDetailsScreen extends StatefulWidget {
  final bool isModify;
  final String profileId;
  final String? name;
  final String? email;
  final String? address;
  final String? pinCode;
  final String? state;
  final String? phoneNumber;
  final String? addresslabel;
  const AddDetailsScreen(
      {super.key,
      required this.profileId,
      this.name,
      this.email,
      this.address,
      this.pinCode,
      this.state,
      this.phoneNumber,
      this.addresslabel,
      required this.isModify});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}
class _AddDetailsScreenState extends State<AddDetailsScreen> {
    final formKey = GlobalKey<FormState>();
late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController pinCodeController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressLabelController;
  late String selectedState;
  
  List<String> items = ['state 1', 'state 2', 'state 3'];
  
  @override
  void initState() {
    super.initState();
    // Initialize controllers only once
    nameController = TextEditingController(text: widget.name ?? '');
    emailController = TextEditingController(text: widget.email ?? '');
    addressController = TextEditingController(text: widget.address ?? '');
    pinCodeController = TextEditingController(text: widget.pinCode ?? '');
    phoneNumberController = TextEditingController(text: widget.phoneNumber ?? '');
    addressLabelController = TextEditingController(text: widget.addresslabel ?? '');
    
    selectedState = widget.state ?? 'state 1';
  }

  void handleSubmit() async {
    if (formKey.currentState!.validate()) {
      if (widget.isModify) {
        await ProfileService().updateProfiles(doId: widget.profileId, data: {
          "name": nameController.text,
          "email": emailController.text,
          "address": addressController.text,
          "pinCode": pinCodeController.text,
          "state": selectedState,
          "phoneNumber": phoneNumberController.text,
          "addresslabel": addressLabelController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address Updated")));
      } else {
        await ProfileService().createProfiles(data: {
          "name": nameController.text,
          "email": emailController.text,
          "address": addressController.text,
          "pinCode": pinCodeController.text,
          "state": selectedState,
          "phoneNumber": phoneNumberController.text,
          "addresslabel": addressLabelController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address Added")));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isModify ? 'Modify Details' : 'Add Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? "This field cannot be empty" : null,
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    validator: (value) => value!.isEmpty ? "This field cannot be empty" : null,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: addressController,
                    validator: (value) => value!.isEmpty ? "This field cannot be empty" : null,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: pinCodeController,
                          validator: (value) => value!.isEmpty ? "This field cannot be empty" : null,
                          decoration: const InputDecoration(
                            labelText: 'Pin Code',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedState,
                          decoration: const InputDecoration(
                            labelText: 'State',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                          ),
                          items: items.map((state) => DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          )).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a state";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null && value.isNotEmpty) {
                              setState(() {
                                selectedState = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: (value) => value!.isEmpty ? "This field cannot be empty" : null,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Save as',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          addressLabelController.text = "Home";
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: blackColor, width: 0.5),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Home',
                          style: TextStyle(color: blackColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          addressLabelController.text = "Work";
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: blackColor, width: 0.5),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Work',
                          style: TextStyle(color: blackColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          addressLabelController.text = "Other";
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: blackColor, width: 0.5),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Other',
                          style: TextStyle(color: blackColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                      child: CustomButton(
                          text: widget.isModify ? "Update" : 'ADD',
                          onPressed: handleSubmit)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

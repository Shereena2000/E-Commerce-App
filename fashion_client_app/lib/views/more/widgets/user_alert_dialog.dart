import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/utils/form_validator.dart';
import 'package:fashion_client_app/utils/my_validator.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:fashion_client_app/widgets/custon_text_form_feild.dart';
import 'package:flutter/material.dart';

class UserAlertDialog extends StatelessWidget {
    final String name;
  final String email;
  const UserAlertDialog({
    super.key, required this.name, required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController(text: name);
    TextEditingController _emailController = TextEditingController(text: email);
    return AlertDialog(
      backgroundColor: whiteColor,
      title: Center(child: Text("Update")),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormFeild(
              hint: "Enter your name",
              label: "Name",
              controller: _nameController,
              validator: (value) => validateNotEmpty(value),
            ),
            moderateSpacing,
            CustomTextFormFeild(
              hint: "Enter your email",
              label: "Email",
              controller: _emailController,
              validator: (value) => MyValidator.emailValidator(value),
              readOnly: true,
            ),
            largerSpacing,
            CustomButton(
                text: "Update",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var data = {
                      "name": _nameController.text,
                      "email": _emailController.text
                    };
                    await DbService().updateUserData(data: data);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Profile Updated")));
                  }
                })
          ],
        ),
      ),
    );
  }
}

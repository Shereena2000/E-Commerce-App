import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/utils/form_validator.dart';
import 'package:fashion_admin_app/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';

class ModifyCoupon extends StatefulWidget {
  final String id, code, desc;
  final int discount;
  const ModifyCoupon(
      {super.key,
      required this.id,
      required this.code,
      required this.desc,
      required this.discount});

  @override
  State<ModifyCoupon> createState() => _ModifyCouponState();
}

class _ModifyCouponState extends State<ModifyCoupon> {
  final formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController disPercentController = TextEditingController();

  @override
  void initState() {
    descController.text = widget.desc;
    codeController.text = widget.code;
    disPercentController.text = widget.discount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: Center(child: Text(widget.id.isNotEmpty ? "Update Coupon" : "Add Coupon")),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
          const    Text("All will be converted to Uppercase"),
              smallSpacing,
              CustomTextFormFeild(
                icon: Icons.discount_outlined,
                hint: "Coupon Code",
                label: "Coupon Code",
                controller: codeController,
                validator: (value) => validateNotEmpty(value),
              ),
             moderateSpacing,
              CustomTextFormFeild(
                icon: Icons.edit,
                hint: "Description",
                label: "Description",
                controller: descController,
                validator: (value) => validateNotEmpty(value),
              ),
             moderateSpacing,
              CustomTextFormFeild(
                icon: Icons.percent,
                hint: "Discount % ",
                label: "Discount % ",
                controller: disPercentController,
                validator: (value) => validateNotEmpty(value),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:const Text("Cancel")),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              var data = {
                "code": codeController.text.toUpperCase(),
                "desc": descController.text,
                "discount": int.parse(disPercentController.text)
              };

              if (widget.id.isNotEmpty) {
                DbService().updateCouponCode(docId: widget.id, data: data);
                ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Coupon Code updated.")));
              } else {
                DbService().createCouponCode(data: data);
                ScaffoldMessenger.of(context).showSnackBar(
                 const   SnackBar(content: Text("Coupon Code added.")));
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.id.isNotEmpty ? "Update Coupon" : "Add Coupon"),
        ),
      ],
    );
  }
}

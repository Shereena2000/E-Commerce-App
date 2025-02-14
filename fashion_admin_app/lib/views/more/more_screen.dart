
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:fashion_admin_app/providers/user_provider.dart';
import 'package:fashion_admin_app/widgets/additional_confirm.dart';
import 'package:fashion_admin_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'More'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 6, 
        separatorBuilder: (context, index) {
          if (index == 1 || index == 3) {
            return const Divider();
          }
          return const SizedBox.shrink();
        },
        itemBuilder: (context, index) => _buildListTile(context, index),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _createListTile("Coupons", Icons.arrow_forward_ios,
            () => Navigator.pushNamed(context, '/coupon'));
      case 2:
        return _createListTile(
            "Terms & Conditions", Icons.arrow_forward_ios, () {});
      case 4:
        return _createListTile(
            "Privacy Policy", Icons.arrow_forward_ios, () {});
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            const ListTile(
              title: Text(
                "ACCOUNT",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, value, child) => ListTile(
                title: Text(value.name),
                subtitle: Text(value.email),
              ),
            ),
           
            _createListTile("LOG OUT", null, () {
              showDialog(
                context: context,
                builder: (context) => AdditionalConfirm(
                  
                  contentText: "Are you sure you want to log out?",
                  onYes: () {
                    AuthService().logOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  onNo: () => Navigator.pop(context),
                ),
              );
            }, textColor: Colors.red),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _createListTile(String title, IconData? icon, VoidCallback onTap,
      {Color? textColor}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      trailing: icon != null ? Icon(icon) : null,
      onTap: onTap,
    );
  }
}

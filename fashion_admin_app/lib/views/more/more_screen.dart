
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
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
      appBar: const CustomAppBar(title: 'More'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _createListTile(
              "Coupons", Icons.arrow_forward_ios, 
              () => Navigator.pushNamed(context, '/coupon')),
        
          _buildAccountSection(context),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text(
            "ACCOUNT",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
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
              onYes: () async {
                Provider.of<AdminProviders>(context, listen: false).cancelProvider();
                Provider.of<UserProvider>(context, listen: false).cancelProvider();
                await AuthService().logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              onNo: () => Navigator.pop(context),
            ),
          );
        }, textColor: Colors.red),
      ],
    );
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

import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:fashion_client_app/views/more/profile/saved_details_screen.dart';
import 'package:fashion_client_app/widgets/additional_confirm.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 170,
            ),
            const SizedBox(height: 20),
            _buildMenuItem(
              icon: Icons.local_shipping,
              title: 'My Orders',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.favorite,
              title: 'My Wishlist',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.local_offer,
              title: 'Discount & offers',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.save_alt,
              title: 'Saved Details',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SavedDetailsScreen()));
              },
            ),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AdditionalConfirm(
                        contentText: "Are you sure you want to log out",
                        onYes: () {
                          AuthService().logOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/signin', (route) => false);
                        },
                        onNo: () {
                          Navigator.pop(context);
                        }));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required icon, required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 15,
            ),
            onTap: onTap),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}

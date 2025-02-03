import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:fashion_client_app/provider/user_provider.dart';
import 'package:fashion_client_app/views/more/widgets/user_alert_dialog.dart';
import 'package:fashion_client_app/views/profile/profile_details_screen.dart';
import 'package:fashion_client_app/views/wishlist/wishlist_screen.dart';
import 'package:fashion_client_app/widgets/additional_confirm.dart';
import 'package:fashion_client_app/widgets/app_bar_logo_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarLogoTitle(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Hello ${userProvider.name}!"),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return UserAlertDialog(
                                  name: userProvider.name,
                                  email: userProvider.email,
                                );
                              });
                        },
                        icon: Image.asset("assets/edit_icon.png"))
                  ],
                );
              },
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishlistScreen()));
              },
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
                        builder: (context) => const ProfileDetailsScreen()));
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

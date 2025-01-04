
import 'package:fashion_client_app/views.dart/saved_details_screen.dart';
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
           Image.asset('assets/logo.png',width: 170,),
            const SizedBox(height: 20),
            _buildMenuItem(icon: Icons.local_shipping, title: 'My Orders',onTap: () {
              
            },),
            _buildMenuItem(icon: Icons.favorite, title: 'My Wishlist',onTap: () {
              
            },),
            _buildMenuItem(icon: Icons.local_offer,title:  'Discount & offers',onTap: () {
              
            },),
            _buildMenuItem(icon: Icons.save_alt,title:  'Saved Details',onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedDetailsScreen()));
                 
            },),
            _buildMenuItem(icon: Icons.logout,title:  'Logout',onTap: () {
              
            },),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required icon,required String title,required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
          onTap: onTap
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
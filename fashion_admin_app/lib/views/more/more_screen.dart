
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(automaticallyImplyLeading: false,backgroundColor: beigeColor,
          title:const Text(
        'More',
        style: screenText,
      )),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title:const Text("Coupons"),
            trailing:const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        const  Divider(),
          ListTile(
            title:const Text("Terms & Conditions"),
            trailing:const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
         
         
         
         const Divider(),
          ListTile(
            title:const Text("Privacy Policy"),
            trailing:const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        const  SizedBox(height: 16),
      const    ListTile(
            title: Text(
              "ACCOUNT",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        
      const    ListTile(
            title: Text("Shereena M.J"),
            subtitle: Text("shereenamj340@gmail.com"),
           
          ),
        const  SizedBox(height: 16),
          ListTile(
            title:const Text(
              "LOG OUT",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              AuthService().logOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
            },
          ),
         
        ],
      ),

  
    );
  }
}

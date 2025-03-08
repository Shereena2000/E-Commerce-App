import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:fashion_client_app/controllers/connectivity_service.dart';
import 'package:fashion_client_app/provider/address_provider.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/user_provider.dart';
import 'package:fashion_client_app/views/offline/offline_screen.dart';
import 'package:fashion_client_app/views/profile/widgets/build_menu_item.dart';
import 'package:fashion_client_app/views/profile/widgets/legal_info_widget.dart';
import 'package:fashion_client_app/views/address/saved_address_screen.dart';
import 'package:fashion_client_app/views/wishlist/wishlist_screen.dart';
import 'package:fashion_client_app/widgets/additional_confirm.dart';
import 'package:fashion_client_app/widgets/app_version_widget.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:fashion_client_app/widgets/user_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  bool _isDeviceOffline(AsyncSnapshot<List<ConnectivityResult>> snapshot) {
    return snapshot.hasData && snapshot.data!.contains(ConnectivityResult.none);
  }

  @override
  Widget build(BuildContext context) {
    final connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);

    return StreamBuilder<List<ConnectivityResult>>(
      stream: connectivityService.connectivityStream,
      builder: (context, connectivitySnapshot) {
        // Check if the device is offline
        if (_isDeviceOffline(connectivitySnapshot)) {
          return const OfflineScreen();
        }
        return Scaffold(
          appBar: const CustomMainAppBar(),
          body: SafeArea(
            child: ListView(
              children: [
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    print(userProvider.name);
                    return UserNameWidget(
                      name: userProvider.name,
                      email: userProvider.email,
                    );
                  },
                ),
                const SizedBox(height: 20),
                buildMenuItem(
                  icon: Icons.local_shipping,
                  title: 'My Orders',
                  onTap: () {
                    Navigator.pushNamed(context, '/order');
                  },
                ),
                buildMenuItem(
                  icon: Icons.favorite,
                  title: 'My Wishlist',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WishlistScreen()));
                  },
                ),
                buildMenuItem(
                  icon: Icons.local_offer,
                  title: 'Discount & offers',
                  onTap: () {
                    Navigator.pushNamed(context, '/discount');
                  },
                ),
                buildMenuItem(
                  icon: Icons.save_alt,
                  title: 'Saved Details',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedAddressScreen(),
                      ),
                    );
                  },
                ),
                buildMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AdditionalConfirm(
                        contentText: "Are you sure you want to log out",
                        onYes: () async {
                          print("Logging out...");
                          try {
                            Provider.of<AddressProvider>(context, listen: false)
                                .cancelProvider();
                            Provider.of<UserProvider>(context, listen: false)
                                .cancelProvider();
                            Provider.of<CartProvider>(context, listen: false)
                                .cancelProvider();
                            await AuthService().logOut();
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                (route) => false,
                              );
                            }
                          } catch (e) {
                            print("Error during logout: $e");
                          }
                        },
                        onNo: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
                largerSpacing,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    legalInfo(
                        title: "About Us",
                        onTap: () {
                          Navigator.pushNamed(context, '/about_us');
                        }),
                    legalInfo(
                        title: "Terms of Use",
                        onTap: () {
                          Navigator.pushNamed(context, '/terms_of_use');
                        }),
                    legalInfo(
                        title: "Privacy Policy",
                        onTap: () {
                          Navigator.pushNamed(context, '/privacy_policy');
                        }),
                  ],
                ),
                largerSpacing,
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppVersionWidget(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

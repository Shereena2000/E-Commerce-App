import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashion_client_app/controllers/connectivity_service.dart';
import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/views/home/service/home_service.dart';
import 'package:fashion_client_app/views/home/widget/vertical_indicator.dart';
import 'package:fashion_client_app/views/home/widget/vertical_page_view.dart';
import 'package:fashion_client_app/views/offline/offline_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController verticalController = PageController();
  final PageController horizontalController = PageController();
  bool _isDeviceOffline(AsyncSnapshot<List<ConnectivityResult>> snapshot) {
    return snapshot.hasData && snapshot.data!.contains(ConnectivityResult.none);
  }
 @override
void dispose() {
  verticalController.dispose(); // Dispose of the vertical PageController
  horizontalController.dispose(); // Dispose of the horizontal PageController
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    final connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);
    return SafeArea(
      child: StreamBuilder<List<ConnectivityResult>>(
        stream: connectivityService.connectivityStream,
        builder: (context, connectivitySnapshot) {
          // Check if the device is offline
         if (_isDeviceOffline(connectivitySnapshot)) {
            return const OfflineScreen();
          }
          return SafeArea(
            child: Scaffold(
              body: FutureBuilder(
                future: HomeService().fetchPromosByCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Promos not found."));
                  }

                  final Map<String, List<PromoModel>> groupedPromos =
                      snapshot.data!;
                  final List<String> categories = groupedPromos.keys.toList();

                  return Stack(
                    children: [
                      VerticalPageView(
                        verticalController: verticalController,
                        horizontalController: horizontalController,
                        groupedPromos: groupedPromos,
                        categories: categories,
                      ),
                      VerticalPageIndicator(
                        verticalPageIndex: context
                            .watch<HomeStateProvider>()
                            .verticalPageIndex,
                        totalPages: categories.length,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
 
}

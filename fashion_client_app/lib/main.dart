import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/firebase_options.dart';
import 'package:fashion_client_app/provider/auth_state_provider.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/wishlist_provider.dart';
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:fashion_client_app/provider/profile_provider.dart';
import 'package:fashion_client_app/provider/search_provider.dart';
import 'package:fashion_client_app/provider/user_provider.dart';
import 'package:fashion_client_app/views/address/add_address_screen.dart';
import 'package:fashion_client_app/views/authentication/forgot_screen.dart';
import 'package:fashion_client_app/views/authentication/signin_screen.dart';
import 'package:fashion_client_app/views/authentication/sigup_screen.dart';
import 'package:fashion_client_app/views/authentication/welcome_screen.dart';
import 'package:fashion_client_app/views/cart/cart_screen.dart';
import 'package:fashion_client_app/views/categories/categories_screen.dart';
import 'package:fashion_client_app/views/home/home_screen.dart';
import 'package:fashion_client_app/views/search/search_screen.dart';
import 'package:fashion_client_app/views/splash/splash_screen.dart';
import 'package:fashion_client_app/widgets/custom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeStateProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => AuthStateProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => FilterStateProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fashion',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: whiteColor),
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(color: Colors.black),
            headlineMedium: TextStyle(color: Colors.black),
            headlineSmall: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/signin': (context) => SigninScreen(),
          '/signUp': (context) => SigupScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/navBar': (context) => const CustomNavBar(),
          '/home': (context) => const HomeScreen(),
          '/categories': (context) => const CategoriesScreen(),
          '/search': (context) => const SearchScreen(),
          '/cart': (context) => const CartScreen(),
          '/addDetails': (context) =>
              AddAddressScreen(id: "", isModify: false),
          '/forgot': (context) => const ForgotScreen(),
        },
      ),
    );
  }
}

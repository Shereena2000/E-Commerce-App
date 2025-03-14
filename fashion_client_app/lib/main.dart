
import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/connectivity_service.dart';
import 'package:fashion_client_app/firebase_options.dart';
import 'package:fashion_client_app/provider/auth_state_provider.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/checkout_provider.dart';
import 'package:fashion_client_app/provider/wishlist_provider.dart';
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:fashion_client_app/provider/address_provider.dart';
import 'package:fashion_client_app/provider/search_provider.dart';
import 'package:fashion_client_app/provider/user_provider.dart';
import 'package:fashion_client_app/views/address/add_address_screen.dart';
import 'package:fashion_client_app/views/authentication/forgot_screen.dart';
import 'package:fashion_client_app/views/authentication/signin_screen.dart';
import 'package:fashion_client_app/views/authentication/sigup_screen.dart';
import 'package:fashion_client_app/views/authentication/welcome_screen.dart';
import 'package:fashion_client_app/views/cart/cart_screen.dart';
import 'package:fashion_client_app/views/categories/categories_screen.dart';
import 'package:fashion_client_app/views/check_out/screens/checkout_verify_screen.dart';
import 'package:fashion_client_app/views/discount/discount_screen.dart';
import 'package:fashion_client_app/views/home/home_screen.dart';
import 'package:fashion_client_app/views/legal_agreement/about_us_screen.dart';
import 'package:fashion_client_app/views/legal_agreement/privacy_policy_screen.dart';
import 'package:fashion_client_app/views/legal_agreement/terms_of_use_screen.dart';
import 'package:fashion_client_app/views/orders/screens/order_screen.dart';
import 'package:fashion_client_app/views/orders/screens/view_order_screen.dart';
import 'package:fashion_client_app/views/profile/profile_screen.dart';
import 'package:fashion_client_app/views/search/search_screen.dart';
import 'package:fashion_client_app/views/splash/splash_screen.dart';
import 'package:fashion_client_app/widgets/custom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  await dotenv.load(fileName: ".env");
    String? stripeKey = dotenv.env["STRIPE_PUBLISH_KEY"];
  if (stripeKey == null || stripeKey.isEmpty) {
    throw Exception("Stripe publishable key is missing in .env file");
  }
  Stripe.publishableKey = stripeKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => AuthStateProvider()),
        ChangeNotifierProvider(create: (context) => HomeStateProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
       
        ChangeNotifierProvider(create: (context) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => FilterStateProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CheckoutProvider()),
        Provider<ConnectivityService>(create: (context) => ConnectivityService()),
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
          '/addDetails': (context) => AddAddressScreen(id: "", isModify: false),
          '/forgot': (context) => const ForgotScreen(),
          '/discount': (context) => const DiscountScreen(),
          '/checkout': (context) => const CheckoutVerifyScreen(),
          '/order': (context) => const OrderScreen(),
          '/vieworder': (context) => const ViewOrderScreen(),
          '/about_us': (context) => const AboutUsScreen(),
          '/terms_of_use': (context) => const TermsOfUseScreen(),
          '/privacy_policy': (context) => const PrivacyPolicyScreen(),
          'profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}

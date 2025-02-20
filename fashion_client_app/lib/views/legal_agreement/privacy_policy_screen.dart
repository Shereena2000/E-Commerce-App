import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomMainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: headlineText,
              ),
              smallSpacing,
              Text(
                "Last Updated: Feb 14, 2025",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "Welcome to Fashoin! Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our app.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "1. Information We Collect",
                style: normalboldText,
              ),
              Text(
                "We collect the following types of information:\n\n"
                "Personal Information: Name, email, phone number, and shipping address (when you place an order).\n"
                "Location Data: We use Geolocator to fetch your location for address autofill. You can choose to allow or deny location access.\n"
                "Device Information: We may collect device type, OS, and app usage data to improve our services.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "2. How We Use Your Information",
                style: normalboldText,
              ),
              Text(
                "We use your information for:\n\n"
                "Processing and delivering orders.\n"
                "Providing customer support.\n"
                "Sending updates, promotions, and important notifications.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "3. Location Data Usage",
                style: normalboldText,
              ),
              Text(
                "We access your location only when you use the address autofill feature.\n"
                "Your location data is not stored permanently or shared with third parties.\n"
                "You can disable location access in your device settings.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "4. Data Sharing & Security",
                style: normalboldText,
              ),
              Text(
                "We do not sell or rent your personal data.\n"
                "We may share data with trusted third-party service providers for order processing and delivery.\n"
                "We use Firebase Authentication and Firestore for secure user authentication and data storage.\n"
                "We implement security measures to protect your data, but no method is 100% secure.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "5. Your Rights & Choices",
                style: normalboldText,
              ),
              Text(
                "You can update or delete your personal information in your account settings.\n"
                "You can opt out of marketing communications anytime.\n"
                "You can disable location access in your device settings.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "6. Changes to This Policy",
                style: normalboldText,
              ),
              Text(
                "We may update this policy from time to time. Please review it periodically. Your continued use of Fashion after updates means you accept the changes.",
                style: normalText,
              ),
              smallSpacing,
              Text(
                "7. Contact Us",
                style: normalboldText,
              ),
              Text(
                "For any questions about this Privacy Policy, contact us at:\n"
                "📩 shereenajamezz@gmail.com",
                style: normalText,
              ),
              liteSpacing
            ],
          ),
        ),
      ),
    );
  }
}

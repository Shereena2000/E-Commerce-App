import 'package:fashion_client_app/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final version = snapshot.data!;
            return Text(
                'Version: ${version.version} (${version.buildNumber})',
                style: extraSmallText);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

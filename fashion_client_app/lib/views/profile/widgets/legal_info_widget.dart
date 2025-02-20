  import 'package:fashion_client_app/constants/texts.dart';
import 'package:flutter/material.dart';

legalInfo({required String title, required Function onTap}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
         onTap:     () => onTap(),
            child: Text(title, style: normalText)),
      );
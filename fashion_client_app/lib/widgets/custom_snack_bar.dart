import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String errorMessage;
  const CustomSnackBar({
    super.key, required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding:const EdgeInsets.all(16),
          height: 80,
          decoration:const BoxDecoration(
              color:blackColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
        const      SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
               const     Text(
                      "Oh snap!",
                      style: TextStyle(fontSize: 18, color: whiteColor),
                    ),
                    const Spacer(),
                    Text(
                      errorMessage,
                      style:const TextStyle(color: whiteColor, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: -10,
          top: -10,
          child: Container(
            width: 30, 
            height: 30,
            decoration: BoxDecoration(
              color: blackColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1, // Adjust border width as needed
              ),
            ),
            child:const Center(
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

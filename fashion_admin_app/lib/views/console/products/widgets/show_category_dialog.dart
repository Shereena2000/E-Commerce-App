import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCategoryDialog(BuildContext context,ProductProvider provider) {
   showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: whiteColor,
                title:const Center(child:  Text("Select Category ")),
                content: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context)
                                  .size
                                  .height *
                              0.6),
                      child: SingleChildScrollView(
                        child: Consumer<AdminProviders>(
                            builder: (context, value,
                                    child) =>
                                Column(
                                  mainAxisSize:
                                      MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: value.categories
                                      .map((e) => TextButton(
                                          onPressed: () {
                                            provider
                                                .categoriesController
                                                .text = e["name"];
                                            Navigator.pop(
                                                context);
                                          },
                                          child: Text(
                                            e["name"],
                                            style: const TextStyle(
                                                color:
                                                    blackColor),
                                          )))
                                      .toList(),
                                )),
                      ),
                    )
                  ],
                ),
              ));
  }


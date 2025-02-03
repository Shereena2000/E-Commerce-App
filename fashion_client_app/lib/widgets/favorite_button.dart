import 'package:fashion_client_app/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;
  final double? size;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        return IconButton(
          onPressed: () async {
            wishlistProvider.updateFavorite(productId);
            await wishlistProvider.addAndRemoveWishlist(productId);
          },
          icon: Icon(
            wishlistProvider.isFavorite(productId)
                ? Icons.favorite
                : Icons.favorite_outline,
            size: size ?? 22,
          ),
        );
      },
    );
  }
}
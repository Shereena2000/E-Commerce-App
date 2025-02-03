import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart", style: appBarText),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.cart.isEmpty) {
              return const Center(
                child: Text("No cart item"),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.cart.length, // Example count
                      itemBuilder: (context, index) {
                        return CartItem(
                            image: value.product[index].images[0],
                            name: value.product[index].name,
                            new_price: value.product[index].newPrice,
                            old_price: value.product[index].oldPrice,
                            maxQuantity: value.product[index].maxQuantity,
                            selectedQuantity: value.cart[index].quantity,
                            productId: value.product[index].id);
                      },
                    ),
                  ),
                  CouponInput(),
                  OrderSummary(),
                  CustomButton(text: "Place Order", onPressed: () {})
                ],
              );
            }
          }
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String image, name, productId;
  final int new_price, old_price, maxQuantity, selectedQuantity;
  CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.productId,
    required this.new_price,
    required this.old_price,
    required this.maxQuantity,
    required this.selectedQuantity,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: whiteColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image, // Replace with actual image
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
                          Text("Color: "),
                          CircleAvatar(radius: 5, backgroundColor: Colors.red),
                        ],
                      ),
                      const Text("Size: S"),
                      smallSpacing,
                      Row(
                        children: [
                          QuantitySelector(
                            productId: productId,
                            maxQuantity: maxQuantity,
                          ),
                          const Spacer(),
                          Text(" \₹$new_price",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () async {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .deleteItem(productId);
                              },
                              child: const Text("Remove")),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Move to Wishlist")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CouponInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          hintText: "Enter Coupon code",
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: whiteColor,
              ),
              onPressed: () {},
              child: const Text("Apply"),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: whiteColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Order Summary",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text("Total MRP"), Text("₹6,998")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Delivery Charges"),
                  Text("₹99 FREE", style: TextStyle(color: Colors.green))
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Amount payable",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("₹6,998", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final String productId;
  final int maxQuantity;
  const QuantitySelector({
    Key? key,
    required this.productId,
    required this.maxQuantity,
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int count = 1;
  increaseCount(int max) async {
    if (count >= max) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Maximum Quantity reached")));
      return;
    } else {
      Provider.of<CartProvider>(context, listen: false)
          .addToCart(CartModel(productId: widget.productId, quantity: count));
      setState(() {
        count++;
      });
    }
  }

  decreaseCount() async {
    if (count > 1) {
      Provider.of<CartProvider>(context, listen: false)
          .decreaseCount(widget.productId);
      setState(() {
        count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              decreaseCount();
              setState(() {});
            },
            icon: const Icon(
              Icons.remove,
              size: 15,
            ),
          ),
          Text(
            "$count",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: () {
              increaseCount(widget.maxQuantity);
            },
            icon: const Icon(
              Icons.add,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}

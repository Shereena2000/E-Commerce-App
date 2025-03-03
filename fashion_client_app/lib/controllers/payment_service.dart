import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/checkout_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  Future<void> processPayment(
    BuildContext context,
    CheckoutProvider checkoutProvider,
    CartProvider cartData,
  ) async {
    
    try {
      print("Starting payment process...");

      // Validate delivery details
      if (checkoutProvider.selectedAddress == null ||
          checkoutProvider.selectedAddress!.address.isEmpty ||
          checkoutProvider.selectedAddress!.phone.isEmpty ||
          checkoutProvider.selectedAddress!.name.isEmpty ||
          checkoutProvider.selectedAddress!.email.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please fill in your delivery details.",style: TextStyle(color: whiteColor),),
      backgroundColor:blackColor,
    ),
  ); 
  return;
       
      }

     

      // Calculate total amount
      int totalAmount = cartData.cart.fold(0, (sum, item) {
        var product = cartData.product.firstWhere(
          (p) => p.id == item.productId,
          orElse: () => throw Exception(
              "Product not found for cart item: ${item.productId}"),
        );
        return sum + (product.newPrice * item.quantity);
      });

      print("Calculated Total Amount: $totalAmount");

      // Initialize payment sheet
      print("Initializing payment sheet...");
      await checkoutProvider.initPaymentSheet(
        context,
        totalAmount - checkoutProvider.discount,
      );

      // Present payment sheet
      print("Presenting payment sheet...");
      await Stripe.instance.presentPaymentSheet();
      print("Payment sheet presented successfully.");

      // Prepare order data
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("User is not logged in.");
      }

      List<Map<String, dynamic>> products = cartData.cart.map((cartItem) {
        var product = cartData.product.firstWhere(
          (p) => p.id == cartItem.productId,
          orElse: () => throw Exception(
              "Product not found for cart item: ${cartItem.productId}"),
        );

        return {
          "id": product.id,
          "name": product.name,
          "image": product.images.isNotEmpty
              ? product.images[0]
              : "assets/placeholder.jpg",
          "size": cartItem.size,
          "color": cartItem.color,
          "single_price": product.newPrice,
          "total_price": product.newPrice * cartItem.quantity,
          "quantity": cartItem.quantity,
        };
      }).toList();

      Map<String, dynamic> orderData = {
        "address_details": checkoutProvider.selectedAddress!.toJson(),
        "user_id": currentUser.uid,
        "name": checkoutProvider.selectedAddress!.name,
        "email": checkoutProvider.selectedAddress!.email,
        "address": checkoutProvider.selectedAddress!.address,
        "phone": checkoutProvider.selectedAddress!.phone,
        "discount": checkoutProvider.discount,
        "total": totalAmount - checkoutProvider.discount,
        "products": products,
        "status": "PAID",
        "created_at": DateTime.now().millisecondsSinceEpoch,
      };

      print("Order Data: $orderData");

      // Create order in Firestore
      print("Creating order in Firestore...");
      await DbService().createOrder(data: orderData);
      print("Order created successfully.");

      // Reduce product quantities in Firestore
      print("Reducing product quantities...");

      // Create a map of product IDs to cart items
      Map<String, CartModel> cartItemMap = {};
      for (var cartItem in cartData.cart) {
        cartItemMap[cartItem.productId] = cartItem;
      }

      for (var item in cartData.product) {
        if (cartItemMap.containsKey(item.id)) {
          print(
              "Reducing quantity for product: ${item.id}, Quantity: ${cartItemMap[item.id]!.quantity}");
          await DbService().reduceQuantity(
            productId: item.id,
            quantity: cartItemMap[item.id]!.quantity,
          );
        } else {
          print("Product not found in cart: ${item.id}");
        }
      }

      print("Product quantities reduced successfully.");

      // Empty the cart
      print("Emptying cart...");
      await DbService().emptyCard();
      print("Cart emptied successfully.");

      // Navigate back and show success message
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Payment Done", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
      );
    } on StripeException catch (e) {
      print("Stripe Error: ${e.error.localizedMessage}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment Failed: ${e.error.localizedMessage}"),
          backgroundColor: Colors.red,
        ),
      );
    } on FirebaseException catch (e) {
      print("Firebase Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Firebase Error: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    } on Exception catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print("Unexpected Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

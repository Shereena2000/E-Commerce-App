import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:flutter/material.dart';

class ModifyOrder extends StatefulWidget {
  final OrdersModel order;
  const ModifyOrder({super.key, required this.order});

  @override
  State<ModifyOrder> createState() => _ModifyOrderState();
}

class _ModifyOrderState extends State<ModifyOrder> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: whiteColor,
      title:const Center(child: Text("Modify this order")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
     
          TextButton(
              onPressed: () async{

              await  DbService().updateOrderStatus(docId: widget.order.id, data: 
                {
                  "status" : "PAID"
                });
                Navigator.pop(context);
                Navigator.pop(context);
               
              },
              child: Text("Order Paid by user")),
          TextButton(
              onPressed: () async{

              await  DbService().updateOrderStatus(docId: widget.order.id, data: 
                {
                  "status" : "SHIPPED"
                });
                Navigator.pop(context);
                Navigator.pop(context);
               
              },
              child: Text("Order Shipped")),
          TextButton(
              onPressed: ()async {
                 await  DbService().updateOrderStatus(docId: widget.order.id, data: 
                {
                  "status" : "DELIVERED"
                });
                Navigator.pop(context);
                Navigator.pop(context);
               
              },
              child: Text("Order Delivered")),
          TextButton(
              onPressed: () async{
                await  DbService().updateOrderStatus(docId: widget.order.id, data: 
                {
                  "status" : "CANCELLED"
                });
                Navigator.pop(context);
                Navigator.pop(context);
               
              },
              child: Text("Cancel Order")),
        ],
      ),
    );
  }
}

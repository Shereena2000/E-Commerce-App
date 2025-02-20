
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/address_model.dart';
import 'package:fashion_client_app/provider/checkout_provider.dart';
import 'package:fashion_client_app/views/address/add_address_screen.dart';
import 'package:fashion_client_app/views/check_out/widgets/custom_pop_up.dart';
import 'package:flutter/material.dart';

Widget buildAddressCard(BuildContext context, CheckoutProvider checkoutData, List<AddressModel> address, int index) {
  return Card(
    color: checkoutData.selectedAddressIndex == index ? Colors.green[50] : Colors.white,
    child: ListTile(
      leading: Radio(
        value: index,
        groupValue: checkoutData.selectedAddressIndex,
        onChanged: (value) {
          checkoutData.setSelectedAddress(index, address[index]);
        },
      ),
      title: Text("${address[index].name}, ${address[index].address}"),
      subtitle: Text("${address[index].state}, ${address[index].pinCode}"),
      trailing: CustomPopUp(
        onEdit: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAddressScreen(
                id: address[index].id,
                isModify: true,
                name: address[index].name,
                email: address[index].email,
                address: address[index].address,
                pinCode: address[index].pinCode,
                state: address[index].state,
                phoneNumber: address[index].phone,
                addresslabel: address[index].addressLabel,
              ),
            ),
          );
        },
        onDelete: () {
          DbService().deleteAddress(doId: address[index].id);
          Navigator.pop(context);
        },
      ),
    ),
  );
}

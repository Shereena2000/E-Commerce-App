import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:fashion_client_app/views/products/widgets/filter_checklist.dart';
import 'package:flutter/material.dart';


class FilterItem extends StatelessWidget {
  final String text;
  final Map<String, bool> checklistItems;
  final FilterStateProvider filterStateProvider;

  const FilterItem({
    super.key,
    required this.text,
    required this.checklistItems,
    required this.filterStateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              filterStateProvider.updateTapped(text);
            },
            title: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              filterStateProvider.getTappedState(text)
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
          ),
          if (filterStateProvider.getTappedState(text))
            FilterChecklist(
              checklistItems: checklistItems,
              text: text,
              filterStateProvider: filterStateProvider,
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              height: 2,
              color: greyColor,
            ),
          ),
        ],
      ),
    );
  }
}

// class FilterItem extends StatelessWidget {
//   final String text;
//   final Map<String, bool> checklistItems;

//   const FilterItem({
//     super.key,
//     required this.text,
//     required this.checklistItems,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FilterStateProvider>(
//       builder: (context, filterStateProvider, child) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               ListTile(
//                 onTap: () {
//                   filterStateProvider.updateTapped(text);
//                 },
//                 title: Text(
//                   text,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 trailing: Icon(
//                   filterStateProvider.getTappedState(text)
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                 ),
//               ),
//               if (filterStateProvider.getTappedState(text))
//                 FilterChecklist(
//                   checklistItems: checklistItems,
//                   text: text,
//                   filterStateProvider: filterStateProvider,
//                 ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Divider(
//                   height: 2,
//                   color: greyColor,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
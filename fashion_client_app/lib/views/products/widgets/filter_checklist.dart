import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:flutter/material.dart';
class FilterChecklist extends StatelessWidget {
  const FilterChecklist({
    super.key,
    required this.checklistItems,
    required this.text,
    required this.filterStateProvider,
  });

  final Map<String, bool> checklistItems;
  final String text;
  final FilterStateProvider filterStateProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: checklistItems.keys.map((item) {
        return CheckboxListTile(
          visualDensity: VisualDensity.compact,
          title: Text(item, style: normalText),
          value: filterStateProvider.getChecklist(text)?[item] ?? false,
          onChanged: (value) {
            filterStateProvider.updateChecklist(text, item, value ?? false);
          },
        );
      }).toList(),
    );
  }
}
// class FilterChecklist extends StatelessWidget {
//   const FilterChecklist({
//     super.key,
//     required this.checklistItems,
//     required this.text,
//     required this.filterStateProvider,
//   });

//   final Map<String, bool> checklistItems;
//   final String text;
//   final FilterStateProvider filterStateProvider;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: checklistItems.keys.map((item) {
//         return CheckboxListTile(
//           visualDensity: VisualDensity.compact,
//           title: Text(item, style: normalText),
//           value: filterStateProvider.getChecklist(text)?[item] ?? false,
//           onChanged: (value) {
//             filterStateProvider.updateChecklist(text, item, value ?? false);
//           },
//         );
//       }).toList(),
//     );
//   }
// }
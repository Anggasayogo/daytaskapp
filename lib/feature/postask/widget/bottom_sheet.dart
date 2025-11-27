import 'package:flutter/material.dart';

class BottomSheetWithList {
  static void show(
    BuildContext context,
    List<Map<String, dynamic>> items, // List of items with 'id' and 'name'
    Function(Map<String, dynamic>)
        onItemSelected, // Callback that receives the selected item
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicator bar at the top of the sheet
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Text(
                'Select an Item',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey, // Color of the line
                    thickness: 1, // Thickness of the line
                    height: 1, // Height of the divider
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4, // Adjust vertical padding
                        horizontal: 8, // Adjust horizontal padding
                      ),
                      title: Text(
                        items[index]['name'], // Display 'name'
                        style: const TextStyle(fontSize: 14), // Text style
                      ),
                      trailing: const Icon(
                        Icons.chevron_right, // Chevron right icon
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        onItemSelected(items[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

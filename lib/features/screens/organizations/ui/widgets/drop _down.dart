import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  final List<String> items;
  final Function(String) onSelected;

  const DropdownMenu(
      {super.key, required this.items, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4.0,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () => onSelected(items[index]),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: items.length,
      ),
    );
  }
}

void showCustomDropdown(BuildContext context, List<String> items,
    Offset position, Function(String) onSelected) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry; // Declare it as late to initialize later

  entry = OverlayEntry(
    builder: (context) {
      return Positioned(
        left: position.dx,
        top: position.dy,
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  entry.remove(); // Remove the overlay
                  onSelected(items[index]); // Pass the selected value
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: items.length,
          ),
        ),
      );
    },
  );

  overlay.insert(entry); // Insert the overlay into the widget tree
}

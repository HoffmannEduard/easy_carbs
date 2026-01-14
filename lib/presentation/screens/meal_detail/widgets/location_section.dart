import 'package:flutter/material.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 100),
        child: IntrinsicWidth(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              hintText: 'Location',
              contentPadding: EdgeInsets.all(8),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TripInfo extends StatelessWidget {
  final String description;
  final String info;
  const TripInfo({super.key, required this.description, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "$info",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
/*
class TripInfo extends StatelessWidget {
  final String text;
  final String description;
  const TripInfo({super.key, required this.description, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
*/
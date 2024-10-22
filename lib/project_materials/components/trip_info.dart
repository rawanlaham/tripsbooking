import 'package:flutter/material.dart';

class TripInfo extends StatelessWidget {
  final String description;
  final String info;
  const TripInfo({
    super.key,
    required this.description,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
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
          Flexible(
            child: Text(
              info,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}

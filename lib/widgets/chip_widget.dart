import 'package:flutter/material.dart';

class Chipwidget extends StatelessWidget {
  const Chipwidget({
    super.key,
    required this.chipLabel,
  });

  final String chipLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Chip(
        label: Text(chipLabel),
      ),
    );
  }
}

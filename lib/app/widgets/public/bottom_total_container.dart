import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomTotalContainer extends StatelessWidget {
  const BottomTotalContainer(
      {super.key, required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: color),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const Text(
              'Total: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Text(
              NumberFormat.currency().format(value),
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';

class ExpensesCard extends StatelessWidget {
  const ExpensesCard({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryLight,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.keyboard_double_arrow_down_rounded,
            color: Colors.red[900],
            size: 24,
          ),
          margin: EdgeInsets.only(right: 12),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expenses',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red[900],
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: primaryDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

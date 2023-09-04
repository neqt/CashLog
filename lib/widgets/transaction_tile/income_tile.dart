import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';

class IncomeTile extends StatelessWidget {
  const IncomeTile({
    super.key,
    required this.value,
    required this.note,
  });

  final int value;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: tertiaryMain,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.savings_rounded,
                  color: secondaryDark,
                ),
                margin: EdgeInsets.only(right: 12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Income',
                    style: TextStyle(
                      color: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$note',
                    style: TextStyle(
                      color: secondaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'THB',
                  style: TextStyle(
                    color: secondaryDark,
                  ),
                  children: [
                    TextSpan(
                      text: ' +$value',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

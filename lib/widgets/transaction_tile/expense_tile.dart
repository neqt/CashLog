import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.value,
    required this.note,
    required this.onDelete,
  });

  final int value;
  final String note;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete(),
            icon: Icons.delete_rounded,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: quaternaryMain,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: secondaryDark,
                  ),
                  margin: EdgeInsets.only(right: 12),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expense',
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
                        text: ' $value',
                        style: TextStyle(
                          color: primaryDark,
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
      ),
    );
  }
}

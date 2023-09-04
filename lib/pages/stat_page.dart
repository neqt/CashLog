import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  const StatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Analyze',
                  style: TextStyle(
                    color: primaryDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Last Year',
                        style: TextStyle(
                          color: primaryDark,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_month_rounded,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text('data'),
                Column(
                    // children: [BoxDecoration(color: primaryLight,)],
                    )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cashlog/models/transaction_item.dart';
import 'package:cashlog/utils/constants.dart';
import 'package:cashlog/widgets/add_transaction.dart';
import 'package:cashlog/widgets/card_summary.dart/expenses_card%20copy.dart';
import 'package:cashlog/widgets/card_summary.dart/income_card.dart';
import 'package:cashlog/widgets/transaction_tile/expense_tile.dart';
import 'package:cashlog/widgets/transaction_tile/income_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TransactionItem transactionItem = TransactionItem();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpenses = 0;

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpenses = 0;

    entireData.forEach((key, value) {
      if (value['type'] == 'Income') {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpenses += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return AddTransaction();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            backgroundColor: primaryDark,
          ).whenComplete(() {
            setState(() {});
          });
        },
        backgroundColor: primaryDark,
        child: Icon(
          Icons.add,
          size: 32,
          color: primaryLight,
        ),
      ),
      body: FutureBuilder<Map>(
        future: transactionItem.fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Unexpected Error'),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('No Values Found'),
              );
            }
            getTotalBalance(snapshot.data!);
            return ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(24),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: primaryMain,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'BALANCE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: secondaryDark,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'THB',
                                style: TextStyle(
                                  color: primaryDark,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 10),
                              ),
                              TextSpan(
                                text: '$totalBalance',
                                style: TextStyle(
                                  color: primaryDark,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IncomeCard(value: totalIncome),
                            SizedBox(width: 40),
                            ExpensesCard(value: totalExpenses),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: Text(
                    'Recent transactions',
                    style: TextStyle(
                      color: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // snapshot.data!.sort((a, b) => b['date'].compareTo(a['date']));

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map dataAtIndex = snapshot.data![index];
                    if (dataAtIndex['type'] == 'Income') {
                      return IncomeTile(
                          value: dataAtIndex['amount'],
                          note: dataAtIndex['note']);
                    } else {
                      return ExpenseTile(
                          value: dataAtIndex['amount'],
                          note: dataAtIndex['note']);
                    }
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Unexpected Error'),
            );
          }
        },
      ),
    );
  }
}

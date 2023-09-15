import 'package:cashlog/data/utlity.dart';
import 'package:cashlog/models/money_model.dart';
import 'package:cashlog/utils/constants.dart';
import 'package:cashlog/widgets/add_transaction.dart';
import 'package:cashlog/widgets/edit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box<Money_model>('money');

  var data;

  

  void _showAddForm(BuildContext context, int? itemKey) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => AddTransaction(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: primaryDark,
    );
  }

  void _showEditForm(BuildContext context, int? itemKey) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => EditTransaction(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: primaryDark,
    );
  }

  void _deleteItem(int index) {
    if (index >= 0 && index < box.length) {
      box.deleteAt(index); // Delete the item at the specified index
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.amp_stories_rounded,
                size: 26,
                color: accent,
              ),
              SizedBox(width: 8),
              Text(
                'CashLog',
                style: TextStyle(
                  color: primaryDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                size: 24,
                color: primaryDark,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () async {
        //   // Clear the Hive box before adding new data
        //   await box.clear();
        //   // Show the add transaction form
        //   _showAddForm(context, null);
        // },
        onPressed: () => _showAddForm(context, null),
        backgroundColor: primaryDark,
        child: Icon(
          Icons.add,
          size: 32,
          color: primaryLight,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
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
                              text: '${totalBalance()}',
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
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: primaryLight,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.keyboard_double_arrow_up_rounded,
                                  color: Colors.teal[900],
                                  size: 24,
                                ),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'THB',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: secondaryDark,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' ${totalIncome()}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: primaryDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: primaryLight,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: EdgeInsets.all(4),
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
                                  RichText(
                                    text: TextSpan(
                                      text: 'THB',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: secondaryDark,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' ${totalExpenses()}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: primaryDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  // data = box.values.toList()[index];
                  final reversedIndex = box.length - 1 - index;
                  data = box.values.toList()[reversedIndex];
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 24,
                      right: 24,
                    ),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (direction) {
                              _showEditForm(context, index);
                              // data.edit();
                            },
                            icon: Icons.edit,
                            backgroundColor: secondaryLight,
                          ),
                          SlidableAction(
                            onPressed: (direction) {
                              // data.delete();
                              _deleteItem(index);
                            },
                            icon: Icons.delete_rounded,
                            backgroundColor: secondaryDark,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: categoryColors[data.category],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  categoryIcons[data.category],
                                  color: secondaryDark,
                                )),
                          ),
                          title: Text(
                            data.category,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: data.note == ''
                              ? null
                              : Text(
                                  data.note,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          trailing: RichText(
                            text: TextSpan(
                              text: 'THB  ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: data.type == 'Income'
                                    ? Colors.green[700]
                                    : primaryDark,
                              ),
                              children: [
                                TextSpan(
                                  text: data.type == 'Income' ? '+' : '',
                                  style: TextStyle(fontSize: 24),
                                ),
                                TextSpan(
                                  text: data.amount == data.amount.toInt()
                                      ? '${data.amount.toInt().toString()}'
                                      : '${data.amount.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

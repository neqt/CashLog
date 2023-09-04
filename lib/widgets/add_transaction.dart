import 'package:cashlog/models/transaction_item.dart';
import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "Expense";
  String type = "Expense";
  DateTime selectedDate = DateTime.now();

  TransactionItem transactionItem = TransactionItem();
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy', 'en_US');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 12),
      lastDate: DateTime(2100, 01),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'New Transaction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: background,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: background,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'THB',
                  style: TextStyle(
                    color: primaryLight,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: 135,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: secondaryDark,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: background,
                    ),
                    onChanged: (value) {
                      try {
                        amount = int.parse(value);
                      } catch (e) {}
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text(
                    'Expense',
                    style: TextStyle(
                      color: type == 'Expense' ? primaryLight : secondaryDark,
                    ),
                  ),
                  selectedColor: accent,
                  selected: type == 'Expense' ? true : false,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        type = 'Expense';
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                ChoiceChip(
                  label: Text(
                    'Income',
                    style: TextStyle(
                      color: type == 'Income' ? primaryLight : secondaryDark,
                    ),
                  ),
                  selectedColor: accent,
                  selected: type == 'Income' ? true : false,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        type = 'Income';
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: secondaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.sticky_note_2_rounded,
                    color: secondaryDark,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Note',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: secondaryDark,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: background,
                    ),
                    onChanged: (value) {
                      note = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.edit_calendar_rounded,
                        color: secondaryDark,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      _dateFormat.format(selectedDate),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () async {
                  if (amount != null && note.isNotEmpty) {
                    await transactionItem.addData(
                        amount!, selectedDate, note, type);
                    Navigator.of(context).pop();
                  } else if (amount != null && note.isEmpty) {
                    await transactionItem.addData(
                        amount!, selectedDate, 'note', type);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: primaryDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: primaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

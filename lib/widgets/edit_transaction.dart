import 'package:cashlog/data/utlity.dart';
import 'package:cashlog/models/money_model.dart';
import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction({super.key});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final box = Hive.box<Money_model>('money');

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String? selectedType = 'Expense';
  String? selectedCategory = 'Miscellaneous';
  DateTime selectedDate = DateTime.now();

  final List<String> _category = [
    'Miscellaneous',
    'Saving',
    'Food & drinks',
    'Transportation',
    'Entertainment',
    'Lifestyle'
  ];

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
  void initState() {
    super.initState();
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
                    'Edit Transaction',
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
                    controller: amountController,
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
                      color: selectedType == 'Expense'
                          ? primaryLight
                          : secondaryDark,
                    ),
                  ),
                  selectedColor: accent,
                  selected: selectedType == 'Expense' ? true : false,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        selectedType = 'Expense';
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
                      color: selectedType == 'Income'
                          ? primaryLight
                          : secondaryDark,
                    ),
                  ),
                  selectedColor: accent,
                  selected: selectedType == 'Income' ? true : false,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        selectedType = 'Income';
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: 350,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 2,
                  color: primaryLight,
                ),
              ),
              child: DropdownButton<String>(
                value: selectedCategory,
                onChanged: ((value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                }),
                items: _category
                    .map((key) => DropdownMenuItem<String>(
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: categoryColors[key],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    categoryIcons[key],
                                    color: secondaryDark,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  key,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: primaryLight,
                                  ),
                                )
                              ],
                            ),
                          ),
                          value: key,
                        ))
                    .toList(),
                selectedItemBuilder: (BuildContext context) => _category
                    .map((key) => Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: categoryColors[selectedCategory],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                categoryIcons[selectedCategory],
                                color: secondaryDark,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              key,
                              style: TextStyle(
                                color: accent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ))
                    .toList(),
                hint: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'Name',
                    style: TextStyle(color: primaryLight),
                  ),
                ),
                dropdownColor: secondaryDark,
                isExpanded: true,
                underline: Container(),
              ),
            ),
            SizedBox(height: 20),
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
                    controller: noteController,
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
              child: GestureDetector(
                onTap: () {
                  try {
                    var trans = Money_model(
                      double.parse(amountController.text),
                      selectedType as String,
                      selectedCategory as String,
                      noteController.text,
                      selectedDate,
                    );

                    box.add(trans);
                    Navigator.of(context).pop();
                  } catch (e) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: primaryDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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

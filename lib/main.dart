import 'package:cashlog/models/money_model.dart';
import 'package:cashlog/screen.dart';
import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneymodelAdapter());
  await Hive.openBox<Money_model>('money');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashLog',
      theme: appTheme,
      home: const Screen(),
    );
  }
}

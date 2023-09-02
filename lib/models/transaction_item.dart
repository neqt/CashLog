import 'package:hive_flutter/adapters.dart';

class TransactionItem {
  late Box box;

  TransactionItem() {
    openBox();
  }

  openBox() {
    box = Hive.box('money');
  }

  Future addData(int amount, DateTime date, String note, String type) async {
    var value = {'amount': amount, 'date': date, 'note': note, 'type': type};
    box.add(value);
  }

  Future deleteData(int amount, DateTime date, String note, String type) async {
    var value = {'amount': amount, 'date': date, 'note': note, 'type': type};
    box.delete(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}

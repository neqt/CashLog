import 'package:hive/hive.dart';
part 'money_model.g.dart';

@HiveType(typeId: 1)
class Money_model extends HiveObject {
  Money_model(
    this.amount,
    this.type,
    this.category,
    this.note,
    this.dateTime,
  );

  @HiveField(0)
  double amount;
  @HiveField(1)
  String type;
  @HiveField(2)
  String category;
  @HiveField(3)
  String note;
  @HiveField(4)
  DateTime dateTime;
}

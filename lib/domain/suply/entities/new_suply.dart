class NewSuply {
  String id;
  String name;
  int price;

  /// [box,item]
  String unitType;
  int itemCount;

  /// [pengeluaran,pemasukan]
  String flow;
  String date;

  NewSuply({
    required this.id,
    required this.name,
    required this.price,
    required this.unitType,
    required this.itemCount,
    required this.flow,
    required this.date,
  });
}

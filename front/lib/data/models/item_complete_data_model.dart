class ItemCompleteDataModel {
  final int id;
  final String name;
  final String cdb;
  final double value_buy;
  final double value_sell;
  final int quantity;
  final int quantity_min;
  final String vality;

  const ItemCompleteDataModel({
    this.id = 0,
    required this.name,
    required this.cdb,
    required this.value_buy,
    required this.value_sell,
    required this.quantity,
    required this.quantity_min,
    required this.vality,
  });
}

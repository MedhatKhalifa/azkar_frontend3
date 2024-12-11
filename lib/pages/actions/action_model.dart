class FormData {
  int? id;
  String date;
  String item1;
  String item2;
  String customItem; // This is for user to add their own item

  FormData(
      {this.id,
      required this.date,
      required this.item1,
      required this.item2,
      required this.customItem});

  // Convert a FormData into a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'item1': item1,
      'item2': item2,
      'customItem': customItem,
    };
  }

  // Convert a Map into a FormData.
  factory FormData.fromMap(Map<String, dynamic> map) {
    return FormData(
      id: map['id'],
      date: map['date'],
      item1: map['item1'],
      item2: map['item2'],
      customItem: map['customItem'],
    );
  }
}

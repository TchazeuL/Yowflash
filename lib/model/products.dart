class Products {
  final int? id;
  final String? categorie, name, description;
  final double? prix;
  final DateTime? createAt;
  final bool isDone;

  Products(
      {this.id,
      this.categorie,
      this.name,
      this.description,
      this.isDone = false,
      this.prix,
      this.createAt});

  Products fromJsonMap(Map<String, dynamic> map) {
    return Products(
        id: map['id'],
        name: map['name'],
        isDone: map['isDone'] == 1,
        createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int));
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'isDone': isDone, 'createAt': createAt};
  }
}

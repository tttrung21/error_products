class ErrorProductItem {
  int? id;
  String? errorDescription;
  String? name;
  String? sku;
  String? image;
  int? color;
  String? colorName;

  ErrorProductItem({this.id, this.errorDescription, this.name, this.sku, this.image, this.color, this.colorName});

  ErrorProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    errorDescription = json['errorDescription'];
    name = json['name'];
    sku = json['sku'];
    image = json['image'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['errorDescription'] = errorDescription;
    data['name'] = name;
    data['sku'] = sku;
    data['image'] = image;
    data['color'] = color;
    return data;
  }
  ErrorProductItem copyWith({
    int? id,
    String? errorDescription,
    String? name,
    String? sku,
    String? image,
    int? color,
    String? colorName,
  }) {
    return ErrorProductItem(
      id: id ?? this.id,
      errorDescription: errorDescription ?? this.errorDescription,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      image: image ?? this.image,
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
    );
  }
}

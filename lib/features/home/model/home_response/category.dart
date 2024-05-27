import 'dart:convert';

class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  @override
  String toString() => 'Category(id: $id, name: $name, image: $image)';

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        id: data['Id'] as int?,
        name: data['Name'] as String?,
        image: data['Image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'Id': id,
        'Name': name,
        'Image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
  String toJson() => json.encode(toMap());

  Category copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }
}

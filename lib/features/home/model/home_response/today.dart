import 'dart:convert';

class Today {
  int? id;
  String? name;
  String? poster;
  String? catPoster;
  String? date;

  Today({this.id, this.name, this.poster, this.catPoster, this.date});

  @override
  String toString() {
    return 'Today(id: $id, name: $name, poster: $poster, catPoster: $catPoster, date: $date)';
  }

  factory Today.fromMap(Map<String, dynamic> data) => Today(
        id: data['Id'] as int?,
        name: data['Name'] as String?,
        poster: data['Poster'] as String?,
        catPoster: data['CategoryPoster'] as String?,
        date: data['Date'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'Id': id,
        'Name': name,
        'Poster': poster,
        'CategoryPoster': catPoster,
        'Date': date,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Today].
  factory Today.fromJson(String data) {
    return Today.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Today] to a JSON string.
  String toJson() => json.encode(toMap());

  Today copyWith({
    int? id,
    String? name,
    String? poster,
    String? catPoster,
    String? date,
  }) {
    return Today(
      id: id ?? this.id,
      name: name ?? this.name,
      poster: poster ?? this.poster,
      catPoster: catPoster ?? this.catPoster,
      date: date ?? this.date,
    );
  }
}

import 'dart:convert';

import 'category.dart';
import 'today.dart';

class HomeResponse {
  List<Today>? spotlight;
  List<Category>? category;
  List<Today>? today;

  HomeResponse({this.spotlight, this.category, this.today});

  @override
  String toString() {
    return 'HomeResponse(spotlight: $spotlight, category: $category, today: $today)';
  }

  factory HomeResponse.fromMap(Map<String, dynamic> data) => HomeResponse(
        spotlight: (data['Spotlight'] as List<dynamic>?)
            ?.map((e) => Today.fromMap(e as Map<String, dynamic>))
            .toList(),
        category: (data['Category'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        today: (data['Today'] as List<dynamic>?)
            ?.map((e) => Today.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'Spotlight': spotlight?.map((e) => e.toMap()).toList(),
        'Category': category?.map((e) => e.toMap()).toList(),
        'Today': today?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HomeResponse].
  factory HomeResponse.fromJson(String data) {
    return HomeResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HomeResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  HomeResponse copyWith({
    List<Today>? spotlight,
    List<Category>? category,
    List<Today>? today,
  }) {
    return HomeResponse(
      spotlight: spotlight ?? this.spotlight,
      category: category ?? this.category,
      today: today ?? this.today,
    );
  }
}

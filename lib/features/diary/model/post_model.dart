import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String selectedEmoji;
  final String selectedWeather;
  final String title;
  final String subtitle;
  final String diaryEntry;
  final double createAt;

  Post({
    required this.selectedEmoji,
    required this.selectedWeather,
    required this.title,
    required this.subtitle,
    required this.diaryEntry,
    required this.createAt,
  });

  Post copyWith({
    String? selectedEmoji,
    String? selectedWeather,
    String? title,
    String? subtitle,
    String? diaryEntry,
    double? createAt,
  }) {
    return Post(
      selectedEmoji: selectedEmoji ?? this.selectedEmoji,
      selectedWeather: selectedWeather ?? this.selectedWeather,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      diaryEntry: diaryEntry ?? this.diaryEntry,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedEmoji': selectedEmoji,
      'selectedWeather': selectedWeather,
      'title': title,
      'subtitle': subtitle,
      'diaryEntry': diaryEntry,
      'createAt': createAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      selectedEmoji: map['selectedEmoji'] ?? '',
      selectedWeather: map['selectedWeather'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      diaryEntry: map['diaryEntry'] ?? '',
      createAt: map['createAt']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(selectedEmoji: $selectedEmoji, selectedWeather: $selectedWeather, title: $title, subtitle: $subtitle, diaryEntry: $diaryEntry, createAt: $createAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.selectedEmoji == selectedEmoji &&
        other.selectedWeather == selectedWeather &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.diaryEntry == diaryEntry &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return selectedEmoji.hashCode ^
        selectedWeather.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        diaryEntry.hashCode ^
        createAt.hashCode;
  }
}

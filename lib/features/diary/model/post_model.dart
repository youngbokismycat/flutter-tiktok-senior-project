import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String? id; // Add this line
  final String selectedEmoji;
  final String selectedWeather;
  final String title;
  final String subtitle;
  final String diaryEntry;
  final double createAt;

  Post({
    this.id, // Add this line
    required this.selectedEmoji,
    required this.selectedWeather,
    required this.title,
    required this.subtitle,
    required this.diaryEntry,
    required this.createAt,
  });

  Post copyWith({
    String? id,
    String? selectedEmoji,
    String? selectedWeather,
    String? title,
    String? subtitle,
    String? diaryEntry,
    double? createAt,
  }) {
    return Post(
      id: id ?? this.id, // Add this line
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
      id: map['id'], // Add this line
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

  String getElapsedTime() {
    final currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
    final difference = currentTime - createAt;
    final seconds = difference / 1000;
    final minutes = seconds / 60;
    final hours = minutes / 60;
    final days = hours / 24;
    final weeks = days / 7;
    final months = days / 30;
    final years = days / 365;

    if (years >= 1) {
      return '${years.toStringAsFixed(0)}년';
    } else if (months >= 1) {
      return '${months.toStringAsFixed(0)}달';
    } else if (weeks >= 1) {
      return '${weeks.toStringAsFixed(0)}주';
    } else if (days >= 1) {
      return '${days.toStringAsFixed(0)}일';
    } else if (hours >= 1) {
      return '${hours.toStringAsFixed(0)}시간';
    } else if (minutes >= 1) {
      return '${minutes.toStringAsFixed(0)}분';
    } else {
      return '${seconds.toStringAsFixed(0)}초';
    }
  }

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

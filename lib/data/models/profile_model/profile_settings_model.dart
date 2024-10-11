import 'dart:convert';

class ProfileSettingsModel {
  final int timeInSeconds;

  const ProfileSettingsModel({
    this.timeInSeconds = 300,
  });

  ProfileSettingsModel copyWith({int? timeInSeconds}) {
    return ProfileSettingsModel(
      timeInSeconds: timeInSeconds ?? this.timeInSeconds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeInSeconds': timeInSeconds,
    };
  }

  factory ProfileSettingsModel.fromMap(Map<String, dynamic> map) {
    return ProfileSettingsModel(
      timeInSeconds: map['timeInSeconds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileSettingsModel.fromJson(String source) =>
      ProfileSettingsModel.fromMap(
        json.decode(source),
      );
}

part of 'profile_settings_bloc.dart';

abstract class ProfileSettingsState extends Equatable {
  final ProfileSettingsModel profileSettingsModel;

  const ProfileSettingsState({
    required this.profileSettingsModel,
  });

  @override
  List<Object> get props => [profileSettingsModel];
}

class ProfileSettingsUserDefinedState extends ProfileSettingsState {
  final ProfileSettingsModel profileSettingsModel;

  const ProfileSettingsUserDefinedState({
    required this.profileSettingsModel,
  }) : super(
          profileSettingsModel: const ProfileSettingsModel(
            timeInSeconds: 300,
          ),
        );
}

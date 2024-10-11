import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/profile_model/profile_settings_model.dart';
part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState>
    with HydratedMixin {
  ProfileSettingsBloc()
      : super(
          const ProfileSettingsUserDefinedState(
            profileSettingsModel: ProfileSettingsModel(
              timeInSeconds: 300,
            ),
          ),
        ) {
    hydrate();

    on<ProfileSettingsChangeEvent>(
        (event, emit) => emit(ProfileSettingsUserDefinedState(
                profileSettingsModel: state.profileSettingsModel.copyWith(
              timeInSeconds: event.profileSettingsModel.timeInSeconds,
            ))));
  }

  // @override
  // Stream<ProfileSettingsState> mapEventToState(
  //   ProfileSettingsEvent event,
  // ) async* {
  //   if (event is ProfileSettingsChangeEvent) {
  //     yield ProfileSettingsUserDefinedState(
  //       profileSettingsModel: state.profileSettingsModel.copyWith(
  //         isDarkModeEnabled: event.profileSettingsModel.isDarkModeEnabled,
  //         selectedLanguage: event.profileSettingsModel.selectedLanguage,
  //       ),
  //     );
  //   }
  // }

  @override
  ProfileSettingsState fromJson(Map<String, dynamic> json) {
    return ProfileSettingsUserDefinedState(
      profileSettingsModel: ProfileSettingsModel.fromMap(json),
    );
  }

  @override
  Map<String, dynamic> toJson(ProfileSettingsState state) {
    return state.profileSettingsModel.toMap();
  }
}

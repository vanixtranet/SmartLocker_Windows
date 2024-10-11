import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/user_models/user_model.dart';

part 'user_model_event.dart';
part 'user_model_state.dart';

class UserModelBloc extends Bloc<UserModelEvent, UserModelState>
    with HydratedMixin {
  UserModelBloc()
      : super(
          UserModelUserDefinedState(
            userModel: UserModel(),
          ),
        ) {
    hydrate();

    on<UserModelChangeEvent>(
      (event, emit) => emit(
        UserModelUserDefinedState(
          userModel: event.userModel == null
              ? UserModel()
              : UserModel(
                  companyId: event.userModel!.companyId,
                  companyCode: event.userModel!.companyCode,
                  companyName: event.userModel!.companyName,
                  userUniqueId: event.userModel!.userUniqueId,
                  jobTitle: event.userModel!.jobTitle,
                  photoId: event.userModel!.photoId,
                  isSystemAdmin: event.userModel!.isSystemAdmin,
                  legalEntityId: event.userModel!.legalEntityId,
                  legalEntityCode: event.userModel!.legalEntityCode,
                  personId: event.userModel!.personId,
                  id: event.userModel!.id,
                  userName: event.userModel!.userName,
                  email: event.userModel!.email,
                  mobileNumber: event.userModel!.mobileNumber,
                  isPasswordChanged: event.userModel!.isPasswordChanged,
                  userRoleCodes: event.userModel!.userRoleCodes,
                ),
        ),
      ),
    );
  }
  @override
  UserModelState fromJson(Map<String, dynamic> json) {
    return UserModelUserDefinedState(
      userModel: UserModel.fromJson(json),
    );
  }

  @override
  Map<String, dynamic> toJson(UserModelState state) {
    return state.userModel!.toMap();
  }
}

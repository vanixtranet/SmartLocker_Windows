part of 'user_model_bloc.dart';

abstract class UserModelState extends Equatable {
  final UserModel? userModel;

  const UserModelState({
    this.userModel,
  });

  @override
  List<Object> get props => [userModel!];
}

class UserModelUserDefinedState extends UserModelState {
  final UserModel? userModel;

  const UserModelUserDefinedState({
    this.userModel,
  });
}

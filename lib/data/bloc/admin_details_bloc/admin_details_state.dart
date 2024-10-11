part of 'admin_details_bloc.dart';

abstract class AdminDetailsState extends Equatable {
  final AdminInitalDetailModel? adminInitalDetailModel;

  const AdminDetailsState({
    this.adminInitalDetailModel,
  });

  @override
  List<Object> get props => [adminInitalDetailModel!];
}

class AdminDetailsInitial extends AdminDetailsState {
  final AdminInitalDetailModel? adminInitalDetailModel;

  const AdminDetailsInitial({
    this.adminInitalDetailModel,
  });
}

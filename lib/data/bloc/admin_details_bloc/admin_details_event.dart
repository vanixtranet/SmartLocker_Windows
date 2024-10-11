part of 'admin_details_bloc.dart';

abstract class AdminDetailsEvent extends Equatable {
  const AdminDetailsEvent();

  @override
  List<Object> get props => [];
}

class AdminDetailsChangeEvent extends AdminDetailsEvent {
  final AdminInitalDetailModel? adminInitalDetailModel;

  const AdminDetailsChangeEvent({
 this.adminInitalDetailModel,
  });
}

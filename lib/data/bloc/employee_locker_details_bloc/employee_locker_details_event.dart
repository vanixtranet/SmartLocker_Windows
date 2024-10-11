part of 'employee_locker_details_bloc.dart';

class EmployeeLockerDetailsEvent extends Equatable {
  const EmployeeLockerDetailsEvent();

  @override
  List<Object> get props => [];
}

class EmployeeLockerDetailsChangeEvent extends EmployeeLockerDetailsEvent {
  final EmployeeLockerDetailResponse? lockerDetailData;

  const EmployeeLockerDetailsChangeEvent({
    required this.lockerDetailData,
  });
}

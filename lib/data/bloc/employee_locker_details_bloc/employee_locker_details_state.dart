part of 'employee_locker_details_bloc.dart';

abstract class EmployeeLockerDetailsState extends Equatable {
  final EmployeeLockerDetailResponse? lockerDetailData;

  const EmployeeLockerDetailsState({
    this.lockerDetailData,
  });

  @override
  List<Object> get props => [lockerDetailData!];
}

class EmployeeLockerDetailsInitial extends EmployeeLockerDetailsState {
  final EmployeeLockerDetailResponse? lockerDetailData;
  
  const EmployeeLockerDetailsInitial({
    this.lockerDetailData,
  });
}

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/employee_locker_details_model/employee_locker_details_response.dart';

part 'employee_locker_details_event.dart';
part 'employee_locker_details_state.dart';

class EmployeeLockerDetailsBloc
    extends Bloc<EmployeeLockerDetailsEvent, EmployeeLockerDetailsState>
    with HydratedMixin {
  EmployeeLockerDetailsBloc()
      : super(
          EmployeeLockerDetailsInitial(
            lockerDetailData: EmployeeLockerDetailResponse(),
          ),
        ) {
    hydrate();

    on<EmployeeLockerDetailsChangeEvent>(
      (event, emit) => emit(
        EmployeeLockerDetailsInitial(
          lockerDetailData: event.lockerDetailData == null
              ? EmployeeLockerDetailResponse()
              : EmployeeLockerDetailResponse(
                  list: event.lockerDetailData?.list ?? [],
                ),
        ),
      ),
    );
  }

  @override
  // EmployeeLockerDetailsState fromJson(List json) {
  EmployeeLockerDetailsState fromJson(Map<String, dynamic> json) {
    return EmployeeLockerDetailsInitial(
      lockerDetailData: EmployeeLockerDetailResponse.fromJson(json),
    );
  }

  @override
  Map<String, dynamic> toJson(EmployeeLockerDetailsState state) {
    return state.lockerDetailData!.toMap();
  }
}

import 'locker_details_model.dart';

class LockerDetailsResponse {
  List<LockerDetailsModel>? list;
  String? error;

  LockerDetailsResponse({
    this.list,
    this.error,
  });

  LockerDetailsResponse.fromJson(List response)
      : list = response.map((e) => LockerDetailsModel.fromJson(e)).toList(),
        error = null;

  LockerDetailsResponse.withError(String? errorValue)
      : list = <LockerDetailsModel>[],
        error = errorValue;
}

import 'bay_details_model.dart';

class BayDetailsResponse {
  List<BayDetailsModel>? list;
  String? error;

  BayDetailsResponse({
    this.list,
    this.error,
  });

  BayDetailsResponse.fromJson(List response)
      : list = response.map((e) => BayDetailsModel.fromJson(e)).toList(),
        error = null;

  BayDetailsResponse.withError(String? errorValue)
      : list = <BayDetailsModel>[],
        error = errorValue;
}

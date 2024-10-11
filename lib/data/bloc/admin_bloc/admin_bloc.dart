import 'package:rxdart/rxdart.dart';

import '../../models/admin_initial_model/admin_initial_model.dart';
import '../../models/bay_details_model/bay_details_response.dart';
import '../../models/vending_stock_model/vending_stock_model.dart';
import '../../repositories/admin_repositories/abstract_admin_repositories.dart';

class AdminBloc {
  final AdminRepository _repository = AdminRepository();

  final BehaviorSubject<BayDetailsResponse?> _subjectDetails =
      BehaviorSubject<BayDetailsResponse?>();

  final BehaviorSubject<VendingStockModel?> _subjectVendingStockDetails =
      BehaviorSubject<VendingStockModel?>();

  Future<BayDetailsResponse> getAllBayList({
    Map<String, dynamic>? queryparams,
  }) async {
    _subjectDetails.sink.add(null);

    BayDetailsResponse response = await _repository.getAllBayList(
      queryparams: queryparams,
    );

    _subjectDetails.sink.add(response);
    return response;
  }

  Future<BayDetailsResponse> getReturnedBayList({
    Map<String, dynamic>? queryparams,
  }) async {
    _subjectDetails.sink.add(null);

    BayDetailsResponse response = await _repository.getReturnedBayList(
      queryparams: queryparams,
    );

    _subjectDetails.sink.add(response);
    return response;
  }

  Future<BayDetailsResponse> getVacantListUser({
    Map<String, dynamic>? queryparams,
  }) async {
    _subjectDetails.sink.add(null);

    BayDetailsResponse response = await _repository.getVacantListUser(
      queryparams: queryparams,
    );

    _subjectDetails.sink.add(response);
    return response;
  }

  Future<BayDetailsResponse> getBinUser({
    Map<String, dynamic>? queryparams,
  }) async {
    _subjectDetails.sink.add(null);

    BayDetailsResponse response = await _repository.getBinUser(
      queryparams: queryparams,
    );

    _subjectDetails.sink.add(response);

    return response;
  }

  Future<bool> deleteVendingUser({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.deleteVendingUser(
      queryparams: queryparams,
    );

    return response;
  }

  Future<bool> manageVendingUser({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.manageVendingUser(
      queryparams: queryparams,
    );

    return response;
  }

  Future<VendingStockModel> getVendingStockList({
    Map<String, dynamic>? queryparams,
  }) async {
    _subjectVendingStockDetails.sink.add(null);

    VendingStockModel response = await _repository.getVendingStockList(
      queryparams: queryparams,
    );

    _subjectVendingStockDetails.sink.add(response);

    return response;
  }

  Future<AdminInitalDetailModel> getAdminTaskList({
    Map<String, dynamic>? queryparams,
  }) async {
    _subjectVendingStockDetails.sink.add(null);

    AdminInitalDetailModel response = await _repository.getAdminTaskList(
      queryparams: queryparams,
    );

    return response;
  }

  dispose() {
    _subjectDetails.close();
    _subjectVendingStockDetails.close();
  }

  BehaviorSubject<BayDetailsResponse?> get subjectDetails => _subjectDetails;
  BehaviorSubject<VendingStockModel?> get subjectVendingStockDetails =>
      _subjectVendingStockDetails;
}

final adminBloc = AdminBloc();

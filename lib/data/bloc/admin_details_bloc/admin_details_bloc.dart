import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_locker_windows/data/models/admin_initial_model/admin_initial_model.dart';

part 'admin_details_event.dart';
part 'admin_details_state.dart';

class AdminDetailsBloc extends Bloc<AdminDetailsEvent, AdminDetailsState>
    with HydratedMixin {
  AdminDetailsBloc()
      : super(
          AdminDetailsInitial(
            adminInitalDetailModel: AdminInitalDetailModel(),
          ),
        ) {
    hydrate();

    on<AdminDetailsChangeEvent>(
      (event, emit) => emit(
        AdminDetailsInitial(
          adminInitalDetailModel: event.adminInitalDetailModel == null
              ? AdminInitalDetailModel()
              : AdminInitalDetailModel(
                  fullName: event.adminInitalDetailModel!.fullName,
                  applicationTypeId:
                      event.adminInitalDetailModel!.applicationTypeId,
                  locationTypeId: event.adminInitalDetailModel!.locationTypeId,
                  numberOfTerminals:
                      event.adminInitalDetailModel!.numberOfTerminals,
                  sizeVariationId:
                      event.adminInitalDetailModel!.sizeVariationId,
                  businessEmail: event.adminInitalDetailModel!.businessEmail,
                  organisation: event.adminInitalDetailModel!.organisation,
                  contactNumber: event.adminInitalDetailModel!.contactNumber,
                  json: event.adminInitalDetailModel!.json,
                  locationName: event.adminInitalDetailModel!.locationName,
                  locationDetail: event.adminInitalDetailModel!.locationDetail,
                  name: event.adminInitalDetailModel!.name,
                  collectionTypeId:
                      event.adminInitalDetailModel!.collectionTypeId,
                  smartLockerId: event.adminInitalDetailModel!.smartLockerId,
                  bayNumberId: event.adminInitalDetailModel!.bayNumberId,
                  bayNumber: event.adminInitalDetailModel!.bayNumber,
                  transactionType:
                      event.adminInitalDetailModel!.transactionType,
                  assetDetail: event.adminInitalDetailModel!.assetDetail,
                  assetId: event.adminInitalDetailModel!.assetId,
                  isQRcode: event.adminInitalDetailModel!.isQRcode,
                  isQrCode: event.adminInitalDetailModel!.isQrCode,
                  employeeId: event.adminInitalDetailModel!.employeeId,
                  returnAssetId: event.adminInitalDetailModel!.returnAssetId,
                  collectAssetId: event.adminInitalDetailModel!.collectAssetId,
                  returnBayNumberId:
                      event.adminInitalDetailModel!.returnBayNumberId,
                  collectBayNumberId:
                      event.adminInitalDetailModel!.collectBayNumberId,
                  code: event.adminInitalDetailModel!.code,
                  assetType: event.adminInitalDetailModel!.assetType,
                  asset: event.adminInitalDetailModel!.asset,
                  count: event.adminInitalDetailModel!.count,
                  binNumberId: event.adminInitalDetailModel!.binNumberId,
                  empName: event.adminInitalDetailModel!.empName,
                  collectedDateTime:
                      event.adminInitalDetailModel!.collectedDateTime,
                  lockerNo: event.adminInitalDetailModel!.lockerNo,
                  lockerUnit: event.adminInitalDetailModel!.lockerUnit,
                  employeeName: event.adminInitalDetailModel!.employeeName,
                  collectLockerNo:
                      event.adminInitalDetailModel!.collectLockerNo,
                  collectAssetType:
                      event.adminInitalDetailModel!.collectAssetType,
                  collectAsset: event.adminInitalDetailModel!.collectAsset,
                  collectedDate: event.adminInitalDetailModel!.collectedDate,
                  returnLockerNo: event.adminInitalDetailModel!.returnLockerNo,
                  returnAssetType:
                      event.adminInitalDetailModel!.returnAssetType,
                  returnAsset: event.adminInitalDetailModel!.returnAsset,
                  returnedDate: event.adminInitalDetailModel!.returnedDate,
                  vendingId: event.adminInitalDetailModel!.vendingId,
                  accessoryId: event.adminInitalDetailModel!.accessoryId,
                  currentQuantity:
                      event.adminInitalDetailModel!.currentQuantity,
                  safetyStock: event.adminInitalDetailModel!.safetyStock,
                  collectVendingBayNo:
                      event.adminInitalDetailModel!.collectVendingBayNo,
                  returnBinNo: event.adminInitalDetailModel!.returnBinNo,
                  collectAccessory:
                      event.adminInitalDetailModel!.collectAccessory,
                  returnAccessory:
                      event.adminInitalDetailModel!.returnAccessory,
                  vendingMachineId:
                      event.adminInitalDetailModel!.vendingMachineId,
                  collectionType: event.adminInitalDetailModel!.collectionType,
                  returnBinNumberId:
                      event.adminInitalDetailModel!.returnBinNumberId,
                  returnAccessoryId:
                      event.adminInitalDetailModel!.returnAccessoryId,
                  vendingName: event.adminInitalDetailModel!.vendingName,
                  lockerName: event.adminInitalDetailModel!.lockerName,
                  api: event.adminInitalDetailModel!.api,
                  locationId: event.adminInitalDetailModel!.locationId,
                  unitCode: event.adminInitalDetailModel!.unitCode,
                  locker: event.adminInitalDetailModel!.locker,
                  vending: event.adminInitalDetailModel!.vending,
                  bin: event.adminInitalDetailModel!.bin,
                  adminUserId: event.adminInitalDetailModel!.adminUserId,
                  userName: event.adminInitalDetailModel!.userName,
                  startTime: event.adminInitalDetailModel!.startTime,
                  endTime: event.adminInitalDetailModel!.endTime,
                  totalTime: event.adminInitalDetailModel!.totalTime,
                  id: event.adminInitalDetailModel!.id,
                  createdDate: event.adminInitalDetailModel!.createdDate,
                  createdBy: event.adminInitalDetailModel!.createdBy,
                  lastUpdatedDate:
                      event.adminInitalDetailModel!.lastUpdatedDate,
                  lastUpdatedBy: event.adminInitalDetailModel!.lastUpdatedBy,
                  isDeleted: event.adminInitalDetailModel!.isDeleted,
                  sequenceOrder: event.adminInitalDetailModel!.sequenceOrder,
                  companyId: event.adminInitalDetailModel!.companyId,
                  dataAction: event.adminInitalDetailModel!.dataAction,
                  status: event.adminInitalDetailModel!.status,
                  versionNo: event.adminInitalDetailModel!.versionNo,
                ),
        ),
      ),
    );
  }

  @override
  AdminDetailsState fromJson(Map<String, dynamic> json) {
    return AdminDetailsInitial(
      adminInitalDetailModel: AdminInitalDetailModel.fromJson(json),
    );
  }

  @override
  Map<String, dynamic> toJson(AdminDetailsState state) {
    return state.adminInitalDetailModel!.toJson();
  }
}

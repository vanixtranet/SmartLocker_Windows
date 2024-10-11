// ignore_for_file: constant_identifier_names

class APIEndpointConstants {
  /// Base URL.
  static const BASE_URL = 'https://smartlocker.aitalkx.com/webapi';

  static const AUTHENTICATE_ENDPOINT =
      '$BASE_URL/smartlocker/query/Authenticate';

  static const MANAGE_LOGS_ENDPOINT =
      '$BASE_URL/smartlocker/command/ManageLogs';

  static const LOCKER_DETAIL_ENDPOINT =
      '$BASE_URL/smartlocker/command/LockerDetail';

  static const GET_RETURN_VACANT_BAY_ENDPOINT =
      '$BASE_URL/smartlocker/command/GetReturnVacantBay';

  static const GET_RETURNED_BAY_LIST =
      '$BASE_URL/smartlocker/command/GetReturnedBayList';

  static const GET_ALL_BAY_LIST = '$BASE_URL/smartlocker/command/GetAllBayList';

  static const GET_BIN_LIST = '$BASE_URL/smartlocker/command/GetBinList';

  static const GET_VENDING_STOCK_LIST =
      '$BASE_URL/smartlocker/command/GetVendingStockList';

  static const MANAGE_VENDING_STOCK =
      '$BASE_URL/smartlocker/command/ManageVendingStock';

  static const DELETE_VENDING_STOCK =
      '$BASE_URL/smartlocker/command/DeleteVendingStock';

  static const GET_ADMIN_VACANT_BAY_LIST_STORE =
      '$BASE_URL/smartlocker/command/GetAdminVacantBayListForStore';

  static const COMPLETE_TRANSACTION =
      '$BASE_URL/smartlocker/command/CompleteTransaction';

  static const UPDATE_COLLECTED_RETURN_ITEMS =
      '$BASE_URL/smartlocker/command/UpdateCollectedReturnItems';

  static const SEND_LOCKER_NOT_CLOSED_ALERT =
      '$BASE_URL/smartlocker/command/SendLockerNotClosedAlert';

  static const SEND_UNAUTHORIZED_ACCESS_ALERT =
      '$BASE_URL/smartlocker/command/SendUnauthorizedAccessAlert';

  static const GET_BIN_DETAILS_ENDPOINT =
      '$BASE_URL/smartlocker/command/BinDetail';

  static const GET_UPDATE_COLLECTED_RETURN_ACCESSORY_ENDPOINT =
      '$BASE_URL/smartlocker/command/UpdateCollectedReturnAccessory';

  static const GET_ADMIN_TASK_LIST =
      '$BASE_URL/smartlocker/command/GetAdminTaskList';

      static const POST_LOCKER_STATUS = '$BASE_URL/smartlocker/query/UpdateBayTransactionStatus';
      //bayNo=01
      //transactionStatusCode=DOOR_OPEN
}

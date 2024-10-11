class PostResponse {
  bool? isSuccess;
  String? messages;
  dynamic data;
  dynamic error;

  PostResponse(
    this.isSuccess,
    this.messages,
    this.data,
    this.error,
  );

  PostResponse.fromJson(Map<String, dynamic> jsonResponse) {
    isSuccess = jsonResponse['IsSuccess'];

    data = jsonResponse['Data'];

    error = jsonResponse['error'];

    messages = jsonResponse['Messages'];
  }

  PostResponse.withError(String errorValue)
      : isSuccess = false,
        messages = errorValue;
}

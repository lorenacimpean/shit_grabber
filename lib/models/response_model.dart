class ResponseModel<T> {
  final ResponseState state;
  final T? data;
  final Object? error;

  ResponseModel(
    this.state,
    this.data,
    this.error,
  );

  factory ResponseModel.success(T data) {
    return ResponseModel(ResponseState.success, data, null);
  }

  factory ResponseModel.error(Object? error) {
    return ResponseModel(ResponseState.error, null, error);
  }

  factory ResponseModel.loading() {
    return ResponseModel(ResponseState.loading, null, null);
  }
}

enum ResponseState {
  success,
  loading,
  error,
}

class WanAndResponse<T> {
  int errorCode;
  String errorMsg;
  T data;

  WanAndResponse(this.errorCode, this.errorMsg, this.data);

  WanAndResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return 'WanAndResponse{errorCode: $errorCode, errorMsg: $errorMsg, data: $data}';
  }
}

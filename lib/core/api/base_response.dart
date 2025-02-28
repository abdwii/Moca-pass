class BaseResponse {
  bool? succeeded;
  String? message;
  List<String>? errors;
  dynamic data;

  BaseResponse({this.succeeded, this.message, this.errors, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['Succeeded'];
    message = json['Message'];
    // errors = json['errors'].cast<String>();
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['errors'] = errors;
    data['data'] = this.data;
    return data;
  }
}

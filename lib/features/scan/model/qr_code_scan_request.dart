import 'package:json_annotation/json_annotation.dart';

part 'qr_code_scan_request.g.dart';

@JsonSerializable()
class QrCodeScanRequest {
  @JsonKey(name: 'qrCode')
  String hashQrCode;

  QrCodeScanRequest({required this.hashQrCode});

  Map<String, dynamic> toJson() => _$QrCodeScanRequestToJson(this);
}

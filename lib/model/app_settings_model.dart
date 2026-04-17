class AppSettingsModel {
  final bool? status;
  final PaymobConfig? paymobConfig;

  AppSettingsModel({this.status, this.paymobConfig});

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final settings = data['settings'] ?? {};
    final paymob = settings['paymob_config'] ?? {};

    return AppSettingsModel(
      status: json['status'],
      paymobConfig: PaymobConfig.fromJson(paymob),
    );
  }
}

class PaymobConfig {
  final String? apiKey;
  final String? integrationId;
  final String? iframeId;

  PaymobConfig({this.apiKey, this.integrationId, this.iframeId});

  factory PaymobConfig.fromJson(Map<String, dynamic> json) {
    return PaymobConfig(
      apiKey: json['api_key']?.toString(),
      integrationId: json['integration_id']?.toString(),
      iframeId: json['iframe_id']?.toString(),
    );
  }
}

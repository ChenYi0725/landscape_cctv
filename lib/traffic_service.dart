// traffic_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// 你目前只會用到：id、cam_url
class CamItem {
  final String id;
  final String camUrl;

  const CamItem({required this.id, required this.camUrl});

  factory CamItem.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] as String?)?.trim();
    final camUrl = (json['cam_url'] as String?)?.trim();

    if (id == null || id.isEmpty) {
      throw Exception('Missing id');
    }
    if (camUrl == null || camUrl.isEmpty) {
      throw Exception('Missing cam_url for id=$id');
    }

    // return CamItem(
    //   id: "kee-000042",
    //   camUrl: 'https://cctv.klcg.gov.tw//01d5a434',
    // );
    return CamItem(id: id, camUrl: camUrl);
  }
}

class TrafficService {
  TrafficService({required String baseUrl, http.Client? client})
    : _baseUrl = baseUrl,
      _client = client ?? http.Client();

  final String _baseUrl;
  final http.Client _client;

  /// 假設後端回傳格式如圖：List<Map>，每個元素至少有 id、cam_url
  ///
  /// 例：GET /cameras
  /// 回傳：[
  ///   {"id":"t2-28k-800", "cam_url":"https:\\/\\/cctv-ss01.thb.gov.tw:443\\/T2-28K+800", ...},
  ///   ...
  /// ]
  Future<List<CamItem>> fetchCameras() async {
    final uri = Uri.parse('$_baseUrl/cameras');

    final res = await _client.get(uri).timeout(const Duration(seconds: 8));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final decoded = json.decode(res.body);

    if (decoded is! List) {
      throw Exception('Expected a JSON array');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(CamItem.fromJson)
        .toList(growable: false);
  }

  /// 若你要「用 id 找 cam_url」
  Future<CamItem> fetchCameraById(String targetId) async {
    final list = await fetchCameras();
    for (final item in list) {
      if (item.id == targetId) return item;
    }
    throw Exception('Camera not found: $targetId');
  }

  void dispose() => _client.close();
}

// traffic_detail_view.dart
import 'package:flutter/material.dart';
import 'traffic_service.dart';

class TrafficDetailView extends StatefulWidget {
  /// 上方 title
  final String title;

  /// 要顯示哪個 camera 的 id（例如 t2-28k-800）
  final String cameraId;

  /// 從外面注入
  final TrafficService service;

  const TrafficDetailView({
    super.key,
    required this.title,
    required this.cameraId,
    required this.service,
  });

  @override
  State<TrafficDetailView> createState() => _TrafficDetailViewState();
}

class _TrafficDetailViewState extends State<TrafficDetailView> {
  late Future<CamItem> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.service.fetchCameraById(widget.cameraId);
  }

  @override
  Widget build(BuildContext context) {
    // 只做右邊那張 UI：大圖 + name + 車流(先佔位)
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<CamItem>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return _ErrorView(
                error: snap.error.toString(),
                onRetry: () {
                  setState(() {
                    _future = widget.service.fetchCameraById(widget.cameraId);
                  });
                },
              );
            }
            final cam = snap.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 大圖框：顯示 cam_url 的影像
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      color: Colors.black12,
                      child: _CamImage(url: cam.camUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // name 先寫死
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),

                // 車流量現況：你目前後端沒給，先佔位
                const Row(
                  children: [
                    Text(
                      '車流：',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '~~',
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CamImage extends StatelessWidget {
  final String url;
  const _CamImage({required this.url});

  @override
  Widget build(BuildContext context) {
    // 注意：若你的 cam_url 實際不是「直接圖片檔」，而是串流/頁面，
    // Image.network 可能顯示不了；但先依你需求用 cam_url 當 image source。
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loading) {
        if (loading == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (_, __, ___) => const Center(child: Text('圖片載入失敗')),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '取得資料失敗',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(error, textAlign: TextAlign.center),
            const SizedBox(height: 14),
            ElevatedButton(onPressed: onRetry, child: const Text('重試')),
          ],
        ),
      ),
    );
  }
}

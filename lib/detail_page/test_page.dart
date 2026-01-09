// detail_page/test_page.dart
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('詳細頁')),
      body: const Center(
        child: Text(
          '這是 DetailPage',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

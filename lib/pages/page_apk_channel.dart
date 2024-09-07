import 'package:flutter/material.dart';

class PageApkChannel extends StatefulWidget {
  const PageApkChannel({super.key});

  @override
  State<PageApkChannel> createState() => _PageApkChannelState();
}

class _PageApkChannelState extends State<PageApkChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apk 渠道包制作'),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

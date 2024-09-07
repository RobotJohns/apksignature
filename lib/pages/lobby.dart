import 'package:apksignature/pages/page_apk_channel.dart';
import 'package:apksignature/pages/page_apk_sign.dart';
import 'package:flutter/material.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageApkChannel()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.settings_suggest,
                            size: 200,
                            color: Colors.deepPurple,
                          ),
                          Text(
                            '批量渠道包',
                            style: TextStyle(fontSize: 28, color: Colors.black),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  width: 88,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageApkSign()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.adb,
                            size: 200,
                            color: Colors.lightGreen,
                          ),
                          Text(
                            'APK 签名',
                            style: TextStyle(fontSize: 28, color: Colors.black),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const Positioned(
            left: 20,
            bottom: 20,
            child: Text(
              '因为APK 签名 渠道包的制作需要用到 apksigner apktool,   JAVA 环境是请必备！(已内置 apksigner, apktool_2.9.3.jar, 不适合可以到 assets目录 替换)',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const Positioned(
            left: 20,
            bottom: 50,
            child: Text(
              '作者：神父,  https://github.com/RobotJohns',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}

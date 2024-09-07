import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../utils/model.dart';
import 'dart:io';

mixin ApkSign {
  String get pathTools {
    String currentPath = Directory.current.path;
    if (kDebugMode) {
      return path.join(currentPath, 'assets/tools');
    } else {
      return path.join(currentPath, 'data/flutter_assets/assets/tools');
    }
  }

  Future<bool> doApkSign(BuildContext context, SignInfoModel info) async {
    Map map = await _do4KOperate(info);
    if (map['error'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('4k 对齐出错：${map['error']}'),
        ),
      );
      return false;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('4k 对齐处理成功'),
      ),
    );
    Map mapSign = await _doSignOperate(map['path'], info);
    if (mapSign['error'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('APK 签名成功'),
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<Map> _do4KOperate(SignInfoModel info) async {
    try {
      String currentPath = Directory.current.path;
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      String pathTools;
      if (kDebugMode) {
        pathTools = path.join(currentPath, 'assets/tools');
      } else {
        pathTools = path.join(currentPath, 'data/flutter_assets/assets/tools');
      }
      File file = File(info.dirApkIn);
      String fileName = path.basenameWithoutExtension(file.path); // 文件名（不包括扩展名）
      String fileExtension = path.extension(file.path); // 文件扩展名（包括点号）

      String file4kOut =
          path.join(appDocumentsDir.path, '${fileName}_4k_$fileExtension');

      ///4K对齐
      final result = await Process.run(
          path.join(pathTools, 'zipalign'),
          [
            '-f',
            '-v',
            '4',
            info.dirApkIn,
            file4kOut,
          ],
          workingDirectory: pathTools); // Windows 示例

      if (result.exitCode == 0) {
        print('Command executed successfully');
        return {
          'path': file4kOut,
          'error': null,
        };
      } else {
        return {
          'path': null,
          'error': 'Command failed with exit code ${result.exitCode}',
        };
      }
    } catch (e) {
      return {
        'path': null,
        'error': 'Command failed with exit code ${e.toString()}',
      };
    }
  }

  Future<Map> _doSignOperate(
    String path4K,
    SignInfoModel info,
  ) async {
    try {
      File file = File(info.dirApkIn);
      String fileName = path.basenameWithoutExtension(file.path); // 文件名（不包括扩展名）
      String fileExtension = path.extension(file.path); // 文件扩展名（包括点号）
      String outPut =
          path.join(info.dirApkOut, '${fileName}_signed$fileExtension');

      ///签名操作
      final result = await Process.run(
          'java',
          [
            '-jar',
            'apksigner.jar',
            'sign',
            '--ks',
            info.dirKeyStore,
            '--ks-key-alias',
            info.aliasName,
            '--ks-pass',
            'pass:${info.keystorePw}',
            '--key-pass',
            'pass:${info.aliasPw}',
            '--out',
            outPut,
            path4K
          ],
          workingDirectory: pathTools); // Windows 示例
      if (result.exitCode == 0) {
        return {
          'path': outPut,
          'error': null,
        };
        print('Command executed successfully');
      } else {
        return {
          'path': null,
          'error': 'Command failed with exit code ${result.exitCode}',
        };
        print('Command failed with exit code ${result.exitCode}');
      }
    } catch (e) {
      return {
        'path': null,
        'error': 'Command failed with exit code ${e.toString()}',
      };
    }
  }
}

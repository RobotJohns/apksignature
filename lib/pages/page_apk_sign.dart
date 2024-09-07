import 'dart:convert';

import 'package:apksignature/minx/apk_sign.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../utils/model.dart';
import '../utils/shared_preferences_service.dart';

class PageApkSign extends StatefulWidget {
  const PageApkSign({super.key});

  @override
  State<PageApkSign> createState() => _PageApkSignState();
}

class _PageApkSignState extends State<PageApkSign> with ApkSign {
  late SignInfoModel _model = SignInfoModel.fromJsonEmpty();
  late TextEditingController _controllerKeystorePw;
  late TextEditingController _controllerAliasName;
  late TextEditingController _controllerAliasPw;

  @override
  initState() {
    _controllerKeystorePw = TextEditingController(text: _model.keystorePw);
    _controllerAliasName = TextEditingController(text: _model.aliasName);
    _controllerAliasPw = TextEditingController(text: _model.aliasPw);

    Future.delayed(Duration.zero).then((args) async {
      String? info = await SharedPreferencesService().getData(apkSignInfo);
      // TODO: implement initState
      setState(() {
        if (info != null) {
          _model = SignInfoModel.fromJson(jsonDecode(info));
          _controllerKeystorePw =
              TextEditingController(text: _model.keystorePw);
          _controllerAliasName = TextEditingController(text: _model.aliasName);
          _controllerAliasPw = TextEditingController(text: _model.aliasPw);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apk 签名'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  2.0,
                ), // Adjust the radius to your preference
              ),
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'APK：${_model.dirApkIn.isNotEmpty ? _model.dirApkIn : '请选择'}'),
                      ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['apk'],
                            );
                            if (result != null) {
                              setState(() {
                                _model.dirApkIn =
                                    result.files.single.path ?? '';
                              });
                            }
                          },
                          child: Text('选择'))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  2.0,
                ), // Adjust the radius to your preference
              ),
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'APK输出路径：${_model.dirApkOut.isNotEmpty ? _model.dirApkOut : '请选择'}'),
                      ElevatedButton(
                        onPressed: () async {
                          String? result =
                              await FilePicker.platform.getDirectoryPath();
                          if (result != null) {
                            setState(() {
                              _model.dirApkOut = result ?? '';
                            });
                          }
                        },
                        child: const Text('选择'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  2.0,
                ), // Adjust the radius to your preference
              ),
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '证书 keystore：${_model.dirKeyStore.isNotEmpty ? _model.dirKeyStore : '请选择'}'),
                      ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['keystore'],
                            );
                            if (result != null) {
                              setState(() {
                                _model.dirKeyStore =
                                    result.files.single.path ?? '';
                              });
                            }
                          },
                          child: Text('选择'))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  2.0,
                ), // Adjust the radius to your preference
              ),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('证书密码:'),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 14),
                          height: 50,
                          child: TextField(
                            controller: _controllerKeystorePw,
                            decoration: const InputDecoration(
                              labelText: '请输入证书密码',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  2.0,
                ), // Adjust the radius to your preference
              ),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('证书 alias(别名):'),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 14),
                          height: 50,
                          child: TextField(
                            controller: _controllerAliasName,
                            decoration: const InputDecoration(
                              labelText: '请输入证书别名',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  2.0,
                ), // Adjust the radius to your preference
              ),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('alias (别名) 密码:'),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 14),
                          height: 50,
                          child: TextField(
                            controller: _controllerAliasPw,
                            decoration: const InputDecoration(
                              labelText: '请输入证书别名alias密码',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: _onSign,
                  child: const Text(
                    '开始签名',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //开始签名
  Future<void> _onSign() async {
    if (_model.dirApkIn.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请先选择要签名的APK文件'),
        ),
      );
      return;
    }
    if (_model.dirApkOut.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请先选择签名后签名APK 出入文件'),
        ),
      );
      return;
    }
    if (_model.dirKeyStore.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请先选择前面的证书文件'),
        ),
      );
      return;
    }
    if (_controllerKeystorePw.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请输入证书密码'),
        ),
      );
      return;
    }
    if (_controllerAliasName.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请输入别名'),
        ),
      );
      return;
    }
    if (_controllerAliasPw.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('请输入别名密码'),
        ),
      );
      return;
    }

    _model.keystorePw = _controllerKeystorePw.value.text;
    _model.aliasPw = _controllerAliasPw.value.text;
    _model.aliasName = _controllerAliasName.value.text;
    SharedPreferencesService().saveData(apkSignInfo, jsonEncode(_model));
    _showLoadingDialog(context);
    bool res = await doApkSign(context, _model);
    Navigator.of(context).pop();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 禁止点击对话框外部关闭
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('签名中'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('请等待...'),
            ],
          ),
        );
      },
    );
  }
}

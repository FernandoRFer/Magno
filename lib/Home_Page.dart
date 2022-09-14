import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dev_flutter/Models/mtb_model.dart';
import 'package:dev_flutter/services/AcessoApi.dart';

import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<AcessoApi> mtb = [];
  List<Retornapopupteste> images = [];
  AcessoApi api = AcessoApi();

  // ignore: prefer_typing_uninitialized_variables
  var _imgString;

  Image? ima;

  Future<String> _createFileFromString(String encodedStr) async {
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.zip");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future _getImage() async {
    var getImages = await api.getData();
    var images = getImages.mtb.retornapopupteste;
    var image = images[0];

    _imgString = image.pOPUP;

    var path = await _createFileFromString(_imgString);
    final zipFile = File(path);
    String dir = (await getApplicationDocumentsDirectory()).path;
    final destinationDir = Directory(dir);
    try {
      await ZipFile.extractToDirectory(
          zipFile: zipFile, destinationDir: destinationDir);
    } catch (e) {
      print(e);
    }
    setState(() {
      ima = Image.file(File(destinationDir.path + "/LOGO.jpg"));
    });
  }

  _popUp() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Center(
              child: ima,
            ),
            TextButton(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: TextButton(
          onPressed: () async {
            await _getImage();
            _popUp();
          },
          child: const Text(
            'Click para abrir imagem!',
            style: TextStyle(fontSize: 25),
          ),
        )),
      ),
    );
  }
}

import 'dart:convert';

import 'package:dev_flutter/Models/mtb_model.dart';
import 'package:http/http.dart' as http;

class AcessoApi {
  Future<MtbModel> getData() async {
    var headers = {'Authorization': 'Basic Q0FORElEQVRPOkRFVl9URVNURUA1ODc='};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://mtb.no-ip.org:5190/mtb/v0100/api/RetornaPopUpTeste/DEV FLUTTER'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var mapResponse = json.decode(await response.stream.bytesToString());

      return MtbModel.fromJson(mapResponse);
    } else {
      throw Exception('Failed to load login from the Internet');
    }
  }
}

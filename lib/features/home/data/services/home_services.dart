import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final homeServiceProvider = Provider<HomeServices>((ref) {
  return HomeServices();
});

class HomeServices {
  Future<Map<String, dynamic>> getDashboardCount() async {
    final url = Urls.dashBoardCount;
    Dio dio = Dio();

    var response = await dio.get(url);

    return response.data;
  }
}

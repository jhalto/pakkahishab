

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final homeServiceProvider = Provider<HomeServices>((ref) {
  return HomeServices();
});

class HomeServices {
  Future<Map<String, dynamic>> getDashboardCount(String filter,{required String schoolCode}) async {
    final url = "${Urls.baseUrl}Homepage_Dashboard/?date_filter=$filter&school_code=$schoolCode";
    final Dio dio = Dio();
    print(url);
    final response = await dio.get(url);

    return response.data;
  }
}

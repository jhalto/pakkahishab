import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/home/data/models/dashboard_count_model.dart';
import 'package:pakkahishab/features/home/data/services/home_services.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final service = ref.watch(homeServiceProvider);
  return HomeRepository(service);
});

class HomeRepository {
  final HomeServices homeServices;

  HomeRepository(this.homeServices);

  Future<DashboardResponse?> fetchDashBoard(String filter,{required String schoolCode}) async {
     
     try{
      final response =await homeServices.getDashboardCount(filter,schoolCode: schoolCode);
      return DashboardResponse.fromJson(response); 

     }catch(e){
      print(e);
      return null;
     }
    

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/home/presentation/widgets/app_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // drawerScrimColor: Colors.black12,
      drawer: AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child:Consumer(builder: (context, ref, child) {
                
                final vm = ref.read(homeViewModelProvider);
                return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 items per row
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount:vm. items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // TODO: Navigate to details for each
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${vm.items[index]} clicked")),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            vm.icons[index], // you can map different icons later
                            size: 28,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(height: 6),
                          Text(
                           vm. items[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ); 
              },) 
            ),
          ),
        ],
      ),
    );
  }
}

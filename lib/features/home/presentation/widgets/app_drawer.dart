import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor:  AppColors.primaryColor3.withAlpha(70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final vm = ref.watch(homeViewModelProvider);
              return DrawerHeader(
                // currentAccountPictureSize: Size(70, 70),
                margin: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(color: AppColors.primaryColor3),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(vm.company, style: bodyMediumWhite(context),),

                       Text(vm.name, style: bodyMediumWhite(context),)
                    ],
                  )),
                // accountName: Padding(
                //   padding: EdgeInsets.only(top: 25.0),
                //   child: Text(
                //     vm.company, // Fallback while loading
                //     style: titleLarge(context),
                //   ),
                // ),
                // accountEmail: Text(
                //   vm.name, // Fallback while loading
                //   style: TextStyle(fontSize: 16),
                // ),
                // currentAccountPicture: null,
                // // currentAccountPicture: CircleAvatar(
                // //   backgroundImage: AssetImage("lib/images/lorem.png"),
                // // ),
              );
            },
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard, color: Colors.white),
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard(),));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Our Projects",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const OurProjects(),));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.task, color: Colors.white),
                  title: const Text(
                    "Task Management",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskList(),));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.ac_unit, color: Colors.white),
                  title: const Text(
                    "Compliance Tracker",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ComplianceTracker(),));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_task, color: Colors.white),
                  title: const Text(
                    "Submission Tracker",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const SubmissionTracker(),));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.show_chart_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "ABP",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const Abp(),));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.handshake, color: Colors.white),
                  title: const Text(
                    "Decision Log",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const DecisionLog(),));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.report_gmailerrorred_sharp,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Report",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const Reports(),));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

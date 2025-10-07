import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/global_widgets/custom_back_button.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

class CustomAppbarBackWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final ValueChanged<String>? onSearchChanged;

  CustomAppbarBackWithSearch({
    super.key,
    required this.title,
    this.onSearchChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // ValueNotifier to manage search state
  final ValueNotifier<bool> isSearch = ValueNotifier(false);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSearch,
      builder: (context, value, child) {
        return AppBar(
          automaticallyImplyLeading: false,
          leading: CustomBackButton(),
          centerTitle: false,
          title: value
              ? TextField(
                  controller: _controller,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onChanged: onSearchChanged,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
          actions: [
            Visibility(
              visible: !value,
              child: SvgPicture.asset("assets/icons/filter.svg",colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),height: 18,),),
            IconButton(
              icon: Icon(
                value ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                if (value) {
                  _controller.clear();
                  onSearchChanged?.call('');
                }
                isSearch.value = !value;
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor2, AppColors.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );
      },
    );
  }
}

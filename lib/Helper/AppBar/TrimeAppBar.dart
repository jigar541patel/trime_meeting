import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';


class TrimeAppBarWithTitle {
  final BuildContext context;
  final bool isIcon;

  TrimeAppBarWithTitle(this.context, this.isIcon);

  AppBar getAppBarWithBackArrowTitle(String name, {Function()? onBack}) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        name,
        style: TextStyles.size18Medium,
      ),
      backgroundColor: Colors.transparent,
      leading:isIcon? InkWell(onTap: onBack,child: Image.asset("Assets/Image/Arrow_left.png")):SizedBox(),
    );
  }
}
import 'package:flutter/material.dart';

class Helper {
  String durationToString(int? minutes) {
    if (minutes != null) {
      var d = Duration(minutes: minutes);
      List<String> parts = d.toString().split(':');
      return '${parts[0].padLeft(1, '0')}h ${parts[1].padLeft(2, '0')}m';
    } else {
      return '0';
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

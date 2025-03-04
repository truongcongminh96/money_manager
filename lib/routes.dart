import 'package:flutter/material.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';

import 'package:money_manager/widgets/screens/login/login_screen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  return switch (settings.name) {
    LoginScreen.route => MaterialPageRoute(builder: (context) => LoginScreen()),
    ListItemScreen.route => MaterialPageRoute(builder: (context) => ListItemScreen(),),
    DetailScreen.route => MaterialPageRoute(builder: (context) => DetailScreen(),),
    AddEditScreen.route => MaterialPageRoute(builder: (context) => AddEditScreen(),),
    _ => MaterialPageRoute(builder: (context) => LoginScreen()),
  };
}

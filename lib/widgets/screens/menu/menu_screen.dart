import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/drawer_item.dart';
import 'package:money_manager/main_cubit.dart';

import '../list_item/list_item_screen.dart';

class MenuScreen extends StatelessWidget {
  static const String route = "MenuScreen";

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Page(route: route);
  }
}

class Page extends StatelessWidget {
  const Page({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              ListTile(
                title: Text("Home"),
                trailing:
                    state.selected != DrawerItem.Home
                        ? Icon(Icons.navigate_next)
                        : null,
                onTap: () {
                  context.read<MainCubit>().setSelected(DrawerItem.Home);
                  Navigator.of(
                    context,
                  ).popUntil(ModalRoute.withName(ListItemScreen.route));
                },
              ),
              ListTile(
                title: Text("Setting"),
                trailing:
                    state.selected != DrawerItem.Setting
                        ? Icon(Icons.navigate_next)
                        : null,
                onTap: () {
                  context.read<MainCubit>().setSelected(DrawerItem.Setting);
                  Navigator.of(
                    context,
                  ).popUntil(ModalRoute.withName(ListItemScreen.route));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/drawer_item.dart';
import 'package:money_manager/common/enum/load_status.dart';
import 'package:money_manager/common/enum/screen_size.dart';
import 'package:money_manager/common/utils.dart';
import 'package:money_manager/main_cubit.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';
import 'package:money_manager/widgets/screens/menu/menu_screen.dart';
import 'package:money_manager/widgets/screens/setting/setting_screen.dart';

import '../../common_widgets/notification_bar.dart';

class ListItemScreen extends StatelessWidget {
  static const String route = "ListItemScreen";

  const ListItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListItemCubit(context.read<Api>())..loadData(0),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Money Manager")),
          body: Body(),
          drawer:
              state.screenSize == ScreenSize.Large
                  ? null
                  : Drawer(child: MenuScreen()),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (contextMain, stateMain) {
        return BlocConsumer<ListItemCubit, ListItemState>(
          listener: (context, state) {
            if (state.loadStatus == LoadStatus.Error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(notificationBar("Login error", true));
            }
          },
          builder: (context, state) {
            var screenSize = calculateScreenSize(
              MediaQuery.sizeOf(context).width,
            );
            context.read<ListItemCubit>().setScreenSize(screenSize);
            return state.loadStatus == LoadStatus.Loading
                ? Center(child: CircularProgressIndicator())
                : stateMain.selected == DrawerItem.Setting &&
                    state.screenSize != ScreenSize.Large
                ? SettingScreen()
                : switch (state.screenSize) {
                  ScreenSize.Small => ListItemPage(),
                  ScreenSize.Medium => ListItemEditPage(),
                  _ => ListItemEditMenuPage(),
                };
          },
        );
      },
    );
  }
}

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        var cubit = context.read<ListItemCubit>();
        return Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(child: Text(state.total.toString())),
                  state.months.isNotEmpty &&
                          state.selectedMonth == 0 &&
                          state.selectedMonth < state.months.length
                      ? Container()
                      : IconButton(
                        onPressed: () {
                          cubit.loadData(state.selectedMonth - 1);
                        },
                        icon: Icon(Icons.navigate_before),
                      ),
                  state.months.isNotEmpty &&
                          state.selectedMonth >= 0 &&
                          state.selectedMonth < state.months.length
                      ? Text(state.months[state.selectedMonth].substring(0, 7))
                      : Container(),
                  state.months.isNotEmpty &&
                          state.selectedMonth >= 0 &&
                          state.selectedMonth == state.months.length - 1
                      ? Container()
                      : IconButton(
                        onPressed: () {
                          cubit.loadData(state.selectedMonth + 1);
                        },
                        icon: Icon(Icons.navigate_next),
                      ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var item = state.transactions[index];
                  return Card(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: ListTile(
                      leading:
                          item.amount >= 0
                              ? Icon(Icons.add, color: Colors.blue)
                              : Icon(Icons.remove, color: Colors.red),
                      title: Row(
                        children: [
                          Expanded(child: Text(item.title)),
                          Text(item.amount.toString()),
                        ],
                      ),
                      subtitle: Text(item.content),
                      trailing: IconButton(
                        onPressed: () {
                          cubit.deleteItem(item.dateTime);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
                itemCount: state.transactions.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

class ListItemEditPage extends StatelessWidget {
  const ListItemEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ListItemPage()),
        Expanded(child: DetailScreen()),
      ],
    );
  }
}

class ListItemEditMenuPage extends StatelessWidget {
  const ListItemEditMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return state.selected == DrawerItem.Home
            ? Row(
              children: [
                Expanded(child: MenuScreen()),
                Expanded(child: ListItemPage()),
                Expanded(child: DetailScreen()),
              ],
            )
            : Row(
              children: [
                Expanded(child: MenuScreen()),
                Expanded(flex: 2, child: SettingScreen()),
              ],
            );
      },
    );
  }
}

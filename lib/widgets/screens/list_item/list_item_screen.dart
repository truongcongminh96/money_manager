import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/load_status.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';

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
    return Scaffold(appBar: AppBar(title: Text("Money Manager")), body: Body());
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListItemCubit, ListItemState>(
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.Error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(notificationBar("Login error", true));
        }
      },
      builder: (context, state) {
        return state.loadStatus == LoadStatus.Loading
            ? Center(child: CircularProgressIndicator())
            : ListItemPage();
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';

class DetailScreen extends StatelessWidget {
  static const String route = "DetailScreen";

  const DetailScreen({super.key});

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
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return state.selectedIdx < 0 ||
                state.transactions.isEmpty ||
                state.selectedIdx >= state.transactions.length
            ? Container()
            : Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.transactions[state.selectedIdx].dateTime),
                  SizedBox(height: 16),
                  Text(state.transactions[state.selectedIdx].title),
                  SizedBox(height: 16),
                  Text(state.transactions[state.selectedIdx].content),
                  SizedBox(height: 16),
                  Text(state.transactions[state.selectedIdx].amount.toString()),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: () {}, child: Text("Edit")),
                ],
              ),
            );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/screen_size.dart';
import 'package:money_manager/common/utils.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';

class AddEditScreen extends StatefulWidget {
  static const String route = "AddEditScreen";
  final bool isAddMode;
  final ScreenSize oldScreenSize;

  const AddEditScreen(this.isAddMode, this.oldScreenSize, {super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  ScreenSize newScreenSize = ScreenSize.Small;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isAddMode ? "Add" : "Edit")),
      body: BlocBuilder<ListItemCubit, ListItemState>(
        builder: (context, state) {
          var title = TextEditingController(text: "");
          var content = TextEditingController(text: "");
          var amount = TextEditingController(text: "");
          var cubit = context.read<ListItemCubit>();
          if (!widget.isAddMode) {
            title.text = state.transactions[state.selectedIdx].title;
            content.text = state.transactions[state.selectedIdx].content;
            amount.text =
                state.transactions[state.selectedIdx].amount.toString();
          }
          newScreenSize = calculateScreenSize(MediaQuery.sizeOf(context).width);
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: title),
                SizedBox(height: 16),
                TextField(controller: content),
                SizedBox(height: 16),
                TextField(controller: amount),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (!widget.isAddMode) {
                      cubit.editItem(
                        Transaction(
                          dateTime:
                              state.transactions[state.selectedIdx].dateTime,
                          title: title.text,
                          content: content.text,
                          amount: double.parse(amount.text),
                        ),
                      );
                      pop(context);
                    } else {
                      cubit.addItem(
                        Transaction(
                          dateTime: DateTime.now().toString().substring(0, 19),
                          title: title.text,
                          content: content.text,
                          amount: double.parse(amount.text),
                        ),
                      );
                      pop(context);
                    }
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void pop(BuildContext context) {
    if (widget.oldScreenSize == newScreenSize) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).popUntil(ModalRoute.withName(ListItemScreen.route));
    }
  }
}

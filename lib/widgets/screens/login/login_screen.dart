import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/load_status.dart';
import 'package:money_manager/models/login.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/common_widgets/notification_bar.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';

import 'login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "LoginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<Api>()),
      child: Page(route: route),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.route});

  final String route;

  @override
  PageState createState() => PageState();
}

class PageState extends State<Page> {
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(notificationBar("Login error", true));
          } else if (state.loadStatus == LoadStatus.Done) {
            Navigator.of(context).pushNamed(ListItemScreen.route);
          }
        },
        builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                padding: EdgeInsets.all(32),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "user name"),
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "password"),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().checkLogin(
                          Login(userName: _username, password: _password),
                        );
                      },
                      child: Text("login"),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}

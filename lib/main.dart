import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/main_cubit.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/repositories/api_implement.dart';
import 'package:money_manager/repositories/log.dart';
import 'package:money_manager/repositories/log_implement.dart';
import 'package:money_manager/routes.dart';
import 'package:money_manager/widgets/screens/login/login_screen.dart';

void main() {
  runApp(
    RepositoryProvider<Log>(
      create: (context) => LogImplement(),
      child: Repository(),
    ),
  );
}

class Repository extends StatelessWidget {
  const Repository({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Api>(
      create: (context) => ApiImplement(context.read<Log>()),
      child: Provider(),
    );
  }
}

class Provider extends StatelessWidget {
  const Provider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MainCubit(), child: App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: mainRoute,
        initialRoute: LoginScreen.route,
      ),
    );
  }
}

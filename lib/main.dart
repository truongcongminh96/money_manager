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
  Log log = LogImplement();
  Bloc.observer = AppBlocObserver(log);
  runApp(RepositoryProvider<Log>.value(value: log, child: Repository()));
}

/// {@template app_bloc_observer}
/// Custom [BlocObserver] that observes all bloc and cubit state changes.
/// {@endtemplate}
class AppBlocObserver extends BlocObserver {
  final Log log;
  static const String TAG = "Bloc";

  /// {@macro app_bloc_observer}
  const AppBlocObserver(this.log);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log.infor(TAG, 'onCreate : ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.infor(TAG, 'onEvent: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log.infor(
      TAG,
      'onChange: ${bloc.runtimeType}, change: ${change.nextState}',
    );
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log.infor(
      TAG,
      'onTransition: ${bloc.runtimeType}, transition: $transition',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.infor(TAG, 'onError: ${bloc.runtimeType}, error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log.infor(TAG, 'onClose: ${bloc.runtimeType}');
  }
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
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light(),
            themeMode: state.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: mainRoute,
            initialRoute: LoginScreen.route,
          );
        },
      ),
    );
  }
}

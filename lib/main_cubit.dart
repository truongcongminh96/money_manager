import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/enum/drawer_item.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.int());

  void setSelected(DrawerItem selected) {
    emit(state.copyWith(selected: selected));
  }

  void setTheme(bool isLightTheme) {
    emit(state.copyWith(isLightTheme: isLightTheme));
  }
}

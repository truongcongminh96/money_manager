import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/load_status.dart';
import 'package:money_manager/models/transaction.dart';

import '../../../repositories/api.dart';

part 'list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  Api api;

  ListItemCubit(this.api) : super(ListItemState.init());

  Future<void> loadData(int monthIdx) async {
    emit(
      state.copyWith(loadStatus: LoadStatus.Loading, selectedMonth: monthIdx),
    );
    try {
      var months = await api.getMonths();
      emit(state.copyWith(months: months));
      var total = await api.getTotal();
      emit(state.copyWith(total: total));
      List<Transaction> transactions =
          months.isEmpty
              ? []
              : await api.getTransactions(state.months[state.selectedMonth]);
      emit(
        state.copyWith(transactions: transactions, loadStatus: LoadStatus.Done),
      );
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }

  Future<void> deleteItem(String dateTime) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    try {
      await api.deleteTransaction(dateTime);
      await loadData(state.selectedMonth);
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }
}

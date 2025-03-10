part of 'list_item_cubit.dart';

final class ListItemState {
  final List<Transaction> transactions;
  final List<String> months;
  final int selectedIdx;
  final int selectedMonth;
  final double total;
  final LoadStatus loadStatus;
  final ScreenSize screenSize;

  const ListItemState.init({
    this.transactions = const [],
    this.months = const [],
    this.selectedIdx = -1,
    this.selectedMonth = 0,
    this.total = 0,
    this.loadStatus = LoadStatus.Init,
    this.screenSize = ScreenSize.Small,
  });

  const ListItemState({
    required this.transactions,
    required this.months,
    required this.selectedIdx,
    required this.selectedMonth,
    required this.total,
    required this.loadStatus,
    required this.screenSize,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListItemState &&
          runtimeType == other.runtimeType &&
          transactions == other.transactions &&
          months == other.months &&
          selectedIdx == other.selectedIdx &&
          selectedMonth == other.selectedMonth &&
          total == other.total &&
          loadStatus == other.loadStatus &&
          screenSize == other.screenSize);

  @override
  int get hashCode =>
      transactions.hashCode ^
      months.hashCode ^
      selectedIdx.hashCode ^
      selectedMonth.hashCode ^
      total.hashCode ^
      loadStatus.hashCode ^
      screenSize.hashCode;

  @override
  String toString() {
    return 'ListItemState{' +
        ' trans length: ${transactions.length},' +
        ' months length: ${months.length},' +
        ' selectedIdx: $selectedIdx,' +
        ' selectedMonth: $selectedMonth,' +
        ' total: $total,' +
        ' loadStatus: $loadStatus,' +
        ' screenSize: $screenSize,' +
        '}';
  }

  ListItemState copyWith({
    List<Transaction>? transactions,
    List<String>? months,
    int? selectedIdx,
    int? selectedMonth,
    double? total,
    LoadStatus? loadStatus,
    ScreenSize? screenSize,
  }) {
    return ListItemState(
      transactions: transactions ?? this.transactions,
      months: months ?? this.months,
      selectedIdx: selectedIdx ?? this.selectedIdx,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      total: total ?? this.total,
      loadStatus: loadStatus ?? this.loadStatus,
      screenSize: screenSize ?? this.screenSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transactions': transactions,
      'months': months,
      'selectedIdx': selectedIdx,
      'selectedMonth': selectedMonth,
      'total': total,
      'loadStatus': loadStatus,
      'screenSize': screenSize,
    };
  }

  factory ListItemState.fromMap(Map<String, dynamic> map) {
    return ListItemState(
      transactions: map['transactions'] as List<Transaction>,
      months: map['months'] as List<String>,
      selectedIdx: map['selectedIdx'] as int,
      selectedMonth: map['selectedMonth'] as int,
      total: map['total'] as double,
      loadStatus: map['loadStatus'] as LoadStatus,
      screenSize: map['screenSize'] as ScreenSize,
    );
  }
}

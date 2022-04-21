import 'package:equatable/equatable.dart';
import 'package:stipra/domain/entities/trade_item.dart';
import 'package:stipra/domain/entities/win_item.dart';

class SearchDto extends Equatable {
  final List<TradeItem>? tradeItems;
  final List<WinItem>? winItems;

  SearchDto({
    this.tradeItems,
    this.winItems,
  });

  @override
  List<Object?> get props => [
        tradeItems,
        winItems,
      ];
}

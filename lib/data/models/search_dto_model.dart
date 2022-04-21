import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:stipra/domain/entities/search_dto.dart';
import 'package:stipra/domain/entities/trade_item.dart';
import 'package:stipra/domain/entities/win_item.dart';

import 'trade_item_model.dart';
import 'win_item_model.dart';

class SearchDtoModel extends SearchDto {
  final List<TradeItemModel>? tradeItems;
  final List<WinItemModel>? winItems;

  SearchDtoModel({
    this.tradeItems,
    this.winItems,
  }) : super(
          tradeItems: tradeItems,
          winItems: winItems,
        );

  @override
  List<Object?> get props => [
        tradeItems,
        winItems,
      ];

  fromRawJson(String value) {
    return fromJson(json.decode(value));
  }

  fromJson(List<dynamic> list) {
    //for list and if 'type' is 'trade' or 'win' convert them
    //to TradeItemModel or WinItemModel
    //and add them to the list
    List<TradeItemModel> _tradeItems = [];
    List<WinItemModel> _winItems = [];
    list.map((item) {
      if (item == '') return;
      if (item['type'] == 'perks') {
        _tradeItems.add(TradeItemModel().fromJson(item));
      } else if (item['type'] == 'products') {
        _winItems.add(WinItemModel().fromJson(item));
      }
    }).toList();
    return SearchDtoModel(
      tradeItems: _tradeItems,
      winItems: _winItems,
    );
  }
}

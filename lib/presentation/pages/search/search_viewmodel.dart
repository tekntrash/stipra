import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:dartz/dartz.dart';
import 'package:stipra/data/models/search_dto_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class SearchViewModel extends BaseViewModel {
  late bool isInited;
  late ValueNotifier<SearchDtoModel> searchDtoModel;
  late bool isLoading;
  late String requestKey;
  late bool isSearched;
  init() async {
    searchDtoModel = ValueNotifier(
      SearchDtoModel(
        winItems: [],
        tradeItems: [],
      ),
    );
    isInited = false;
    isLoading = false;
    isSearched = false;
    requestKey = '';
  }

  Future search(String text) async {
    final lastKey = UniqueKey().toString();
    requestKey = lastKey;
    isLoading = true;
    isSearched = true;
    notifyListeners();
    if (text.isEmpty) {
      isLoading = false;
      isSearched = false;
      searchDtoModel.value = SearchDtoModel(
        winItems: [],
        tradeItems: [],
      );
      notifyListeners();
      return;
    }
    final data = await locator<DataRepository>().search(
      text,
    );
    if (requestKey != lastKey) {
      return;
    }
    if (data is Right) {
      searchDtoModel.value = (data as Right).value;
    } else {
      searchDtoModel.value = SearchDtoModel(
        winItems: [],
        tradeItems: [],
      );
    }
    isLoading = false;
    notifyListeners();
  }
}

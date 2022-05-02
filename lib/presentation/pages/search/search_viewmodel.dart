import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:dartz/dartz.dart';
import 'package:stipra/data/models/search_dto_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

/// SearchViewModel uses for get search results from backend

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

  /// Search for a request
  /// If search changed the key will change too and it will effect ui
  /// The reason to have this system
  /// If user search too fast before backend reach like 'a' can have 10000 items
  /// and it can reach to user like around 5seconds
  /// In that time user can search 'apple' and that can have 5 items
  /// and request of 'apple' can reach to user in 1 second
  /// and user will see 'apple' but still there is a request is waiting for 'a' search
  /// and when that reach it can effect ui and can remove 'apple'
  /// instead of 'apple' user will see 'a' results
  /// so the key preventing this to happen.
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

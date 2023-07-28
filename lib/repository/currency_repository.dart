import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workwithapi/get_data_service.dart';
import 'package:workwithapi/models/currency_model.dart';

class CurrencyRepository {
  GetCurrencyService getCurrencyService = GetCurrencyService();
  Box<CurrencyModel>? currencyBox;
  Future<dynamic> getData() async {
    await openBox();
    if (currencyBox!.isEmpty) {
      return await getCurrency();
    } else {
      return currencyBox;
    }
  }

  Future<dynamic> getCurrency() async {
    dynamic response = await getCurrencyService.getCurrency();
    if (response is List<CurrencyModel>) {
      await openBox();
      await writeToBox(response);
      return currencyBox;
    } else {
      return response;
    }
  }

  void registerAdapters() {
    Hive.registerAdapter(CurrencyModelAdapter());
  }

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    currencyBox = await Hive.openBox<CurrencyModel>("currency");
  }

  Future<void> writeToBox(List<CurrencyModel> data) async {
    await currencyBox!.clear();
    for (CurrencyModel element in data) {
      await currencyBox!.add(element);
    }
  }

  Future<void> editElement(int indexOfElement, String newValue) async {
    CurrencyModel? currentElement = currencyBox!.getAt(indexOfElement);
    currentElement!.code = newValue;
    await currencyBox!.putAt(indexOfElement, currentElement);
  }

  Future<void> deleteElement(int index) async {
    await currencyBox!.delete(index);
  }

  putToBox(List data) async {
    for (int i = 0; i < data.length; i++) {
      await currencyBox!.add(data[i]);
    }
  }
}

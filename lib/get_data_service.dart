import 'package:dio/dio.dart';
import 'package:workwithapi/models/currency_model.dart';

class GetCurrencyService {
  Future<dynamic> getCurrency() async {
    try {
      Response response =
          await Dio().get("https://nbu.uz/uz/exchange-rates/json/");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => CurrencyModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}

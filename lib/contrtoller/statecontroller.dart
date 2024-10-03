import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class StateController extends GetxController {
  Rx<String> selectedCity = 'Bangalore'.obs;
  Rx<Map<String, dynamic>?> weatherDta = Rx<Map<String, dynamic>?>(null);
  RxBool isDataLoaded = false.obs;
  String place = "Bangalore";

  Future<Map<String, dynamic>> getWeatherData() async {
    var linkUri =
        "https://api.weatherapi.com/v1/current.json?key=dd54ad5971b44e6f92740022240210&q=$place&aqi=yes";
    isDataLoaded.value = false;
    var weatherDta = Completer<Map<String, dynamic>>();
    http.get(Uri.parse(linkUri)).then((res) {
      weatherDta.complete(convert.jsonDecode(res.body));
    });

    return weatherDta.future;
  }

  @override
  Future<void> onReady() async {
    reGenWeather();
    super.onReady();
  }

  Future<void> reGenWeather() async {
    weatherDta.value = await getWeatherData();
    if (weatherDta.value == null) {
      weatherDta.value = {"Location": null};
      isDataLoaded.value = true;
    } else {
      isDataLoaded.value = true;
    }
  }
}

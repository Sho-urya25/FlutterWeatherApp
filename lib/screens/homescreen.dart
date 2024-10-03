import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/contrtoller/statecontroller.dart';

class HoimeScreen extends StatelessWidget {
  HoimeScreen({super.key});
  final statcontroller = Get.put<StateController>(StateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
              onPressed: () async {
                var result = await showSearch<String>(
                  context: context,
                  delegate: CustomSearchDeligate(),
                );
                if (result != null && result.isNotEmpty) {
                  statcontroller.selectedCity.value = result;
                  statcontroller.place = result;
                  statcontroller.reGenWeather();
                }
              },
              icon: Icon(Icons.search_sharp))
        ],
      ),
      body: Obx(() {
        if (statcontroller.weatherDta.value?["location"] == null) {
          return Center(child: Text("Please enter proper city name"));
        }
        if (statcontroller.isDataLoaded.value) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image(
                                image: NetworkImage(
                                    'https:${statcontroller.weatherDta.value!["current"]["condition"]["icon"]}'),
                              ),
                              Text(
                                  'Location: ${statcontroller.weatherDta.value!["location"]["name"]}'),
                              Spacer(),
                              Text(
                                  'Temperature: ${statcontroller.weatherDta.value!["current"]["temp_c"].toString()}C'),
                              Spacer(),
                            ],
                          ),
                          Text(
                              'Weather: ${statcontroller.weatherDta.value!["current"]["condition"]["text"]}'),
                          Text(
                              'Region: ${statcontroller.weatherDta.value!["location"]["region"]}'),
                          Text(
                              'Country: ${statcontroller.weatherDta.value!["location"]["country"]}')
                        ],
                      ),
                    ),
                  ),
                  txtCard(
                      'WindSpeed: ${statcontroller.weatherDta.value!["current"]["wind_kph"].toString()}'),
                  txtCard(
                      'Humidity: ${statcontroller.weatherDta.value!["current"]["humidity"].toString()}'),
                  txtCard(
                      'FeelsLike: ${statcontroller.weatherDta.value!["current"]["feelslike_c"].toString()}C'),
                  txtCard(
                      'HeatIndex: ${statcontroller.weatherDta.value!["current"]["heatindex_c"].toString()}C'),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Card txtCard(String data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(data),
      ),
    );
  }
}

class CustomSearchDeligate extends SearchDelegate<String> {
  List<String> searchTerms = [
    'Bangalore',
    'Delhi',
    'Mumbai',
    'Ahmedabad',
    'Chennai'
  ];
  @override
  String get searchFieldLabel => 'Enter a city name';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = query;
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuerry = [];
    for (var city in searchTerms) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuerry.add(city);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      close(context, query);
    });
    return ListView.builder(
      itemCount: matchQuerry.length,
      itemBuilder: (context, index) {
        var result = matchQuerry[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            print(result);
            close(context, result);
          },
        );
      },
    );
  }

  // @override
  // void showResults(BuildContext context) {
  //   super.showResults(context);
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuerry = [];
    for (var city in searchTerms) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuerry.add(city);
      }
    }
    return Card(
      child: ListView.builder(
        itemCount: matchQuerry.length,
        itemBuilder: (context, index) {
          var result = matchQuerry[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              print(result);
              close(context, result);
            },
          );
        },
      ),
    );
  }
}

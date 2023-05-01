
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:viswal/model/country.dart';
import 'package:http/http.dart';

class CountriesProvider extends ChangeNotifier {
  static const apiEndpoint =
      'https://countriesnow.space/api/v0.1/countries/flag/unicode';

  bool isLoading = true;
  String error = '';
  Country country = Country(data: []);
  Country searchCountry = Country(data: []);
  String searchText = '';

  //
  getDataFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        country = countryFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
      print(error);
    }
    isLoading = false;
    updateData();
  }

  updateData() {
    searchCountry.data.clear();
    if (searchText.isEmpty) {
      searchCountry.data.addAll(country.data);
    } else {
      searchCountry.data.addAll(country.data
          .where((element) =>
          element.name.toLowerCase().startsWith(searchText))
          .toList());
    }
    notifyListeners();
  }

  search(String username) {
    searchText = username;
    updateData();
  }
//
}



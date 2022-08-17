import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/providers/country_provider.dart';
import 'countries.dart';

class CountryService {
  List<Country> getCountriesData({List<String>? countries}) {
    List jsonList = CountriesCustom.countryList;

    if (countries == null || countries.isEmpty) {
      return jsonList.map((country) => Country.fromJson(country)).toList();
    }
    List filteredList = jsonList.where((country) {
      return countries.contains(country[PropertyName]);
    }).toList();

    return filteredList.map((country) => Country.fromJson(country)).toList();
  }

  Country findCountryWithAlpha2Code(String alpha2Code) {
    List<Country> countries = getCountriesData();

    return countries.firstWhere((country) => country.alpha2Code == alpha2Code,
        orElse: () => countries[0]);
  }
}

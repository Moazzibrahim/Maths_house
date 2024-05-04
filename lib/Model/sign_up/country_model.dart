
class Country {
  final int id;
  final String name;
  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CountryList {
  final List<dynamic> countryList;

  CountryList({required this.countryList});

  factory CountryList.fromJson(Map<String, dynamic> json) =>
      CountryList(countryList: json['countries']);
}

class City {
  final int id;
  final String countryId;
  final String name;

  City({required this.id, required this.countryId, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      countryId: json['country_id'],
      name: json['city'],
    );
  }
}

class CityList {
  final List<dynamic> cityList;

  CityList({required this.cityList});

  factory CityList.fromJson(Map<String, dynamic> json) =>
      CityList(cityList: json['cities']);
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:add_2_calendar/add_2_calendar.dart';

class Country {
  final String countryCode;
  final String name;

  Country({required this.countryCode, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryCode: json['countryCode'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return '$name ($countryCode)';
  }
}

Future<List<Country>> getAvailableCountries() async {
  final response =
      await http.get(Uri.https('date.nager.at', 'api/v3/AvailableCountries'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Country.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load countries');
  }
}

class PublicHoliday {
  final String name;
  final String localName;
  final String date;

  PublicHoliday(
      {required this.name, required this.localName, required this.date});

  factory PublicHoliday.fromJson(Map<String, dynamic> json) {
    return PublicHoliday(
      name: json['name'],
      localName: json['localName'],
      date: json['date'],
    );
  }
}

Future<List<PublicHoliday>> getPublicHolidays(String countryCode) async {
  int year = DateTime.now().year;
  var url =
      Uri.https('date.nager.at', 'api/v3/PublicHolidays/$year/$countryCode');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> holidayList = jsonDecode(response.body);

    return holidayList.map((holidayJson) {
      return PublicHoliday.fromJson(holidayJson);
    }).toList();
  } else {
    throw Exception('Failed to load holidays');
  }
}

void toCalendarEvent(PublicHoliday publicHoliday) {
  DateTime eventDate = DateTime.parse(publicHoliday.date);

  Event event = Event(
    title: publicHoliday.name,
    startDate: eventDate,
    endDate: eventDate.add(Duration(hours: 24)),
    allDay: true,
  );
  Add2Calendar.addEvent2Cal(event);
}

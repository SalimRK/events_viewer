import 'package:events_viewer/model/api_model.dart';
import 'package:flutter/material.dart';

class BotttomCountryPage extends StatefulWidget {
  final String countryCode;

  const BotttomCountryPage({super.key, required this.countryCode});

  @override
  State<BotttomCountryPage> createState() => _BotttomCountryPageState();
}

class _BotttomCountryPageState extends State<BotttomCountryPage> {
  late Future<List<PublicHoliday>> futureHolidays;
  late PublicHoliday? nextHoliday;

  @override
  void initState() {
    super.initState();
    futureHolidays = getPublicHolidays(widget.countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PublicHoliday>>(
      future: futureHolidays,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No holidays found.'));
        } else {
          List<PublicHoliday> holidays = snapshot.data!;
          DateTime currentDate = DateTime.now();

          nextHoliday = _findNextHoliday(holidays, currentDate);

          return ListView.builder(
            itemCount: holidays.length,
            itemBuilder: (context, index) {
              bool isNextHoliday = holidays[index] == nextHoliday;

              return GestureDetector(
                onLongPress: () => _showAddEventDialog(holidays[index]),
                child: ListTile(
                  title: Text(
                    holidays[index].name,
                    style: TextStyle(
                      color: isNextHoliday
                          ? Colors.red
                          : Color.fromARGB(255, 0, 255, 0),
                      fontWeight:
                          isNextHoliday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    holidays[index].localName,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    holidays[index].date,
                    style: TextStyle(
                      color: isNextHoliday
                          ? Colors.red
                          : Color.fromARGB(255, 0, 255, 0),
                      fontWeight:
                          isNextHoliday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  PublicHoliday? _findNextHoliday(
      List<PublicHoliday> holidays, DateTime currentDate) {
    List<PublicHoliday> upcomingHolidays = holidays
        .map((holiday) {
          DateTime holidayDate = DateTime.parse(holiday.date);
          return MapEntry(holiday, holidayDate);
        })
        .where((entry) => entry.value.isAfter(currentDate))
        .toList()
        .map((entry) => entry.key)
        .toList();

    if (upcomingHolidays.isNotEmpty) {
      upcomingHolidays.sort((a, b) {
        DateTime dateA = DateTime.parse(a.date);
        DateTime dateB = DateTime.parse(b.date);
        return dateA.compareTo(dateB);
      });

      return upcomingHolidays.first;
    }

    return null;
  }

  void _showAddEventDialog(PublicHoliday holiday) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Event for ${holiday.name}',
          style: TextStyle(color: Color.fromARGB(255, 0, 255, 0)),
        ),
        content: Text(
          'Do you want to add an event for ${holiday.name}?',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 39, 39, 39),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              toCalendarEvent(holiday);
              Navigator.of(context).pop();
            },
            child: Text(
              'Add Event',
              style: TextStyle(color: Color.fromARGB(255, 0, 255, 0)),
            ),
          ),
        ],
      ),
    );
  }
}

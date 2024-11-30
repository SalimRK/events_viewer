import 'package:events_viewer/model/api_model.dart';
import 'package:events_viewer/screens/country_page/country_page.dart';
import 'package:flutter/material.dart';

class BottomHomePage extends StatelessWidget {
  final Future<List<Country>> resultdata;

  const BottomHomePage({super.key, required this.resultdata});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Country>>(
        future: resultdata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final country = snapshot.data![index];
                return ListTile(
                  title: Text(
                    country.name,
                    style: TextStyle(color: Color.fromARGB(255, 0, 255, 0)),
                  ),
                  subtitle: Text(
                    'Code: ${country.countryCode}',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.flag,
                    color: Color.fromARGB(255, 0, 255, 0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountryPage(country: country),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

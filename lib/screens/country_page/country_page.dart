import 'package:events_viewer/screens/country_page/bottom_country_page.dart';
import 'package:flutter/material.dart';
import 'package:events_viewer/model/api_model.dart';

class CountryPage extends StatelessWidget {
  final Country country;

  const CountryPage({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Image.asset(
            'lib/images/background_image.png',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            alignment: const Alignment(0, -1),
          ),
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: const Color.fromARGB(255, 0, 255, 0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          const snackBar = SnackBar(
                            content: Text(
                                'Long-press an event to add it to your calendar.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        color: const Color.fromARGB(255, 0, 255, 0),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Event Viewer",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 255, 0),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                country.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 400,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 39, 39, 39),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: BotttomCountryPage(countryCode: country.countryCode)),
          ),
        ],
      ),
    );
  }
}

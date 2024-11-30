import 'package:events_viewer/model/api_model.dart';
import 'package:flutter/material.dart';
import 'bottom_home_page.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late Future<List<Country>> _resultdata;

  @override
  void initState() {
    super.initState();

    _resultdata = getAvailableCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyHomePageWidget(resultdata: _resultdata),
    );
  }
}

class BodyHomePageWidget extends StatelessWidget {
  final Future<List<Country>> resultdata;
  const BodyHomePageWidget({super.key, required this.resultdata});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          height: 300,
          decoration: const BoxDecoration(
            color: Color.fromARGB(150, 0, 0, 0),
          ),
        ),
        Positioned(
          top: 75,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Event Viewer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 255, 0),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Select A Country",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
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
            child: BottomHomePage(resultdata: resultdata),
          ),
        ),
      ],
    );
  }
}

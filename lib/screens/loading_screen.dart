import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

 @override
  void initState() {
    // implement initState - Getting the Location Data Automatically on Initializing.
    super.initState();
    getLocationdata();
    
  }

  void getLocationdata() async {
    var weatherdatafromconst = await WeatherModel().getweatherdata();
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          weatherdisplay: weatherdatafromconst,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
        )
      ),
    );
  }
}

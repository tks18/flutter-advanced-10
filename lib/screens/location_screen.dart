import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.weatherdisplay});
  final weatherdisplay;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  
  WeatherModel weatherui = WeatherModel();
  String condition;
  int temperature;
  String location;
  String temptext;
  String city;

  @override
  void initState() {
    // implement initState - Getting the Location data from Loading Screen and Processing it.
    super.initState();
    uielements(widget.weatherdisplay);
  }

  void uielements(dynamic weatherdata){
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        location = 'Not Available';
        temptext = 'Check your Internet Connection or Location Permission';
        city = 'N/A';
        condition = 'Nope';
        return;
      }
      var conditionid = weatherdata['weather'][0]['id'];
      condition = weatherui.getWeatherIcon(conditionid);
      double temp = weatherdata['main']['temp'];
      temptext = weatherui.getMessage(temp.toInt());
      temperature = temp.toInt();
      location = weatherdata['name'];
      city = location;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weatherui.getweatherdata();
                      uielements(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var searchtext = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        )
                      );
                      if (searchtext != null) {
                        var weatherdata = await weatherui.getcitydata(searchtext);
                        uielements(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$temptext in $location',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

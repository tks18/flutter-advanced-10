import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';


const apikey = 'b94d18a27a29adda5e8582f65a957d7a';
const openweatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getcitydata(String cityname) async {

    Networking network = Networking(url: '$openweatherURL?q=$cityname&appid=$apikey&units=metric');
    var weatherdata = await network.getdata();
    return weatherdata;

  }

  Future<dynamic> getweatherdata() async {
    Location location = Location();
    await location.locationdata();

    Networking network = Networking(url: '$openweatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    
    var weatherdata = await network.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

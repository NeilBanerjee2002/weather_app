import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  var weathericon;
  var temperature;
  var condition;
  var cityname;
  var weatherDescription;
  var message;
  @override
  void initState() {
    UpdateUI(widget.locationweather);
    super.initState();
  }
  void UpdateUI(dynamic weatherData){
    if(weatherData == null){
      temperature = 0;
      weathericon = 'error';
      message = 'Unable to get weather data';
      cityname = '';
      return;
    }
     weatherDescription = weatherData['weather'][0]['description'];
     cityname = weatherData['name'];
     double temp = weatherData['main']['temp'];
     temperature = temp.toInt();
     condition = weatherData['weather'][0]['id'];
     weathericon = weather.getWeatherIcon(condition);
     message = weather.getMessage(temperature);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Hopetoun_falls.jpg'),
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
                  TextButton(
                    onPressed: () async{
                      var weatherdata = await weather.getLocationweather();
                      setState(() {
                        UpdateUI(weatherdata);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedname = await Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CityScreen();
                      }));
                      print(typedname);
                      if(typedname != null){
                        var weatherdata = await weather.getcityweather(typedname);
                        setState(() {
                          UpdateUI(weatherdata);
                        });
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityname!',
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

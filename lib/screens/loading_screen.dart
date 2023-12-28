import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState(){
    super.initState();
    getLocationData();
  }
  void getLocationData()async{
    WeatherModel weatherModel = WeatherModel();
    var weatherdata = await weatherModel.getLocationweather();

    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather:  weatherdata);
    })
    );
  }

  @override
  Widget build(BuildContext context) {
    SpinKitFadingCircle spinkit;
    return Scaffold(
       body: spinkit = SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.blue : Colors.orange,
        ),
      );
    },
    ),
    );
  }
}
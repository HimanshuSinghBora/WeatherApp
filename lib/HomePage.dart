import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:wheather_app/WeatherPage.dart';
import 'package:wheather_app/consts.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final WeatherFactory _wf = WeatherFactory((OPENWEATHER_API_KEY));
Weather? weather;
var cityController=TextEditingController();
var cityName="No Recent City";

readData() async {
  var prefs = await SharedPreferences.getInstance();

  var city = prefs.getString("city");
  cityName = city ?? "No Recent City";
  setState(() {

  });
}
saveData() async {
  var  prefs = await SharedPreferences.getInstance();
    prefs.setString('counter', cityName);
    setState(() {

    });

}
@override
  void initState(){
  super.initState();
  readData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children:[
                _buildSearchWidgat(),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: ElevatedButton(onPressed: () async{
                    cityName=cityController.text.toString();
                    var prefs=await SharedPreferences.getInstance();
                    prefs.setString("city", cityName);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherPage(cityName: cityName,)));

                  }, child: Text('SEARCH',style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),)
                ),
                SizedBox(
                  height: 11,
                ),
                InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherPage(cityName: cityName,)));
                      },
                    child: Text(cityName.toUpperCase()))
    ]
    ),
          ),
        )
    );
  }
  Widget _buildSearchWidgat(){
    return SearchBar(
      controller: cityController,
      hintText: "Search any location",
      onSubmitted: (value){
        _wf.currentWeatherByCityName(value).then((w) {
          setState(() {
            weather = w;
          });
        });
      },

    );

  }

}
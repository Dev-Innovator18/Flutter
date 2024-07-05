import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherApp extends StatefulWidget{
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  Future<Map<String,dynamic>> getWeather() async{
    try{
      String appId='3f95eea850912bbdefd4263769a6e987';
      String cityName='London';
      final result=await http.get(
        Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$appId'),
      );

      final data=jsonDecode(result.body);

      if(data['cod']!='200'){
        throw 'An unexpected error occurred';
      }
      //data['list'][0]['main']['temp'];

      return data;
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:const Text(
          'Weather App',
          style:TextStyle(
            fontWeight:FontWeight.w800,
            color:Colors.white,
          ),
        ),
        centerTitle:true,
        actions: [
          IconButton(
            onPressed:(){
              setState((){});
            },
            icon:const Icon(Icons.refresh),
          ),
        ],
      ),
      body:FutureBuilder(
        future:getWeather(),
        builder:(context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child:CircularProgressIndicator.adaptive()
            );
          }

          if(snapshot.hasError){
            return Center(
              child:Text(snapshot.hasError.toString()),
            );
          }

          final data=snapshot.data!;
          final currenttemp=data['list'][0]['main']['temp'];
          final currentsky=data['list'][0]['weather'][0]['main'];
          final pressure=data['list'][0]['main']['pressure'];
          final airSpeed=data['list'][0]['wind']['speed'];
          final humidity=data['list'][0]['main']['humidity'];

          return Padding( 
          padding:const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              SizedBox(
                width:double.infinity,
                child:Card(
                  //elevation:10,
                  child:Column(
                    children:[
                      const SizedBox(
                        height:20,
                      ),
                      Text(
                        '$currenttemp k',
                        style:const TextStyle(
                          fontSize:32,
                          fontWeight:FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height:20,
                      ),
                      Icon(
                        currentsky == 'Clouds' || currentsky == 'Rain'
                          ? Icons.cloud 
                          : Icons.sunny,
                        size:64,
                      ),
                      const SizedBox(
                        height:20,
                      ),
                      Text(
                        currentsky,
                        style:const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height:20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height:20,
              ),
              const Text(
                'Hourly Forecast',
                style:TextStyle(
                  fontSize:24,
                  fontWeight:FontWeight.w800,
                ),
              ),
              const SizedBox(
                height:20,
              ),

              SizedBox(
                height:130,
                child: ListView.builder(
                  itemCount:5,
                  scrollDirection:Axis.horizontal,
                  itemBuilder: (context,index){
                    final time=DateTime.parse(data['list'][index]['dt_txt']);
                    return HourlyForecastItem(
                      time: DateFormat.Hms().format(time),
                      icon: data['list'][index]['weather'][0]['main'] == 'Clouds' || data['list'][index]['weather'][0]['main'] == 'Rain' ? Icons.cloud : Icons.sunny,
                      temp: data['list'][index]['main']['temp'].toString(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height:20,
              ),
              const Text(
                'Additional Information',
                style:TextStyle(
                  fontSize:24,
                  fontWeight:FontWeight.w800,
                ),
              ),
              const SizedBox(
                height:20,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children:[
                  AdditionalInfo(
                    icon:Icons.water_drop,
                    weather: 'Humidity',
                    value:humidity.toString(),
                  ),
                  AdditionalInfo(
                    icon:Icons.air,
                    weather:'Wind Speed',
                    value:airSpeed.toString(),
                  ),
                  AdditionalInfo(
                    icon:Icons.beach_access,
                    weather:'Pressure',
                    value:pressure.toString(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
  }
}

class HourlyForecastItem extends StatelessWidget{
  final String time;
  final IconData icon;
  final String temp;

  const HourlyForecastItem ({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context){
    return Card(
      child:Container(
        width:100,
        padding: const EdgeInsets.all(10),
        child: Column(
          children:[
            Text(
              time,
              style:const TextStyle(
                fontWeight:FontWeight.w800,
                fontSize:16,
              ),
              maxLines:1,
              overflow:TextOverflow.ellipsis,
            ),
            const SizedBox(
              height:10,
            ),
            Icon(
              icon,
              size:32,
            ),
            const SizedBox(
              height:10,
            ),
            Text(
              temp,
            ),
          ],
        ),
      ),
    );
  }
}

class AdditionalInfo extends StatelessWidget{
  final IconData icon;
  final String weather;
  final String value;

  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.weather,
    required this.value,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Icon(
          icon,
          size:40,
        ),
        const SizedBox(
          height:5,
        ),
        Text(
          weather,
          style:const TextStyle(
            fontSize:15,
            fontWeight:FontWeight.w200,
          ),
        ),
        const SizedBox(
          height:5,
        ),
        Text(
          value,
          style:const TextStyle(
            fontSize:16,
            fontWeight:FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

   String location; // location for the UI
   String time=''; //the time in the location
   String flag; //url to asset flag icon
   String url;
   bool isDaytime=true;

   // location url for api endpoint
  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{

    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      //   create Datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime =  now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught Error : $e');
      time = 'Could not get time data';
    }
  }

}
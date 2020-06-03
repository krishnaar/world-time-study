import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; //Location url for api endpoint
  bool isDaytime; // true or false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
//    print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

//    print(datetime);
//    print(offset);

      DateTime now = DateTime.parse(datetime);

//    set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      now = now.add(Duration(hours: int.parse(offset)));

//    Set the time Property
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get tim e data';
    }

  }

}

import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; //Location url for api endpoint

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
      now = now.add(Duration(hours: int.parse(offset)));

//    Set the time Property
      time = now.toString();
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }

  }

}

import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; //location name for the UI
  String time; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url api endpoint

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response = await get('http://worldclockapi.com/api/json/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // Get properties from data
      String datetime = data['currentDateTime'];
      String offset;
      if (location == 'Asia') {
        offset = data['utcOffset'].substring(0, 3);
      } else {
        offset = data['utcOffset'].substring(0, 2);
      }
      // print(datetime);
      // print(offset);

      // Create dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      // Set the time property
      time = now.toString();
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}

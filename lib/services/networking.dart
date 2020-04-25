import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {

  Networking({this.url});

  final url;

  Future getdata() async {
    http.Response response = await http.get(url);
    
    if (response.statusCode == 200){
        String data = response.body;
        var jsondata = jsonDecode(data);
        
        return jsondata;
    } else {
      print(response.statusCode);
    }
  }
}
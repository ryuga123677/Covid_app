import 'dart:convert';

import 'package:covid_app/appurl.dart';
import 'package:http/http.dart' as http;
import 'worldstatemodel.dart';
class statservices
{
  Future<Worldstatemodel> fetchworldrecords()async{
    final response =await http.get(Uri.parse(appurl.worldstateapi));
    if(response.statusCode==200)
      {
        var data =jsonDecode(response.body);
        return Worldstatemodel.fromJson(data);

      }
    else
      {
        throw Exception('error');
      }
  }
  Future<List<dynamic>> fetchcountrylist()async{
    var data;
    final response =await http.get(Uri.parse(appurl.countrieslist));
    if(response.statusCode==200)
    {
       data =jsonDecode(response.body);
      return data;

    }
    else
    {
      throw Exception('error');
    }
  }
}
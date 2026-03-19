


import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march/model/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final todoRepoProvider =  Provider<ApiHelper>((ref)=> ApiHelper(ref) );


class ApiHelper{
  final Ref ref;

  ApiHelper(this.ref);


  Future<dynamic> getTodosFromHttp() async{
    try{
      final response = await http.get(Uri.parse( 'https://jsonplaceholder.typicode.com/todos' ));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }
      else{
        throw Exception("something went wrong");
      }
    }
    catch(e){
      print("error is $e");
      return Exception(e);
    }

  }


  Future<dynamic> getTodosFromDio() async{
    try{
      final Dio dio = Dio();
      final response = await dio.get('https://jsonplaceholder.typicode.com/todos');

      return response.data;
    }
    catch(e){
      print("error is $e");
      return Exception(e);
    }

  }



}
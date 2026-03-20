import 'dart:convert';

import 'package:al_nawaras/config/api_constants.dart';
import 'package:al_nawaras/model/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<ProfileModel?>fetchProfile(String token)async{
    final response=await http.get(Uri.parse(ApiConstants.profile),headers: {
      'Accept':'application/json',
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode==200){
      final jsonData=jsonDecode(response.body);
      return ProfileModel.fromJson(jsonData);
    }
    else{
      throw Exception('Failed to load profile');
    }
  }

}
import 'dart:convert';
import 'package:ar_core_intro/bots/cal.dart';
import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';

class Handle {
  calculate(var value) {
    List numbers = [];
    List nis = [];
    if (value.contains('+')) {
      numbers = value.split('+');
      for (var i = 0; i < numbers.length; i++) {
        // check if the numbers is percedded or suceeded by spaces
        nis.add(int.parse(numbers[i].trim()));
      }
      int result = Calculate().add(nis[0], nis[1]);
      return result;
    } else if (value.contains('-')) {
      numbers = value.split('-');
      for (var i = 0; i < numbers.length; i++) {
        // check if the numbers is percedded or suceeded by spaces
        nis.add(int.parse(numbers[i].trim()));
      }
      int result = Calculate().substract(nis[0], nis[1]);
      return result;
    } else if (value.contains('*')) {
      numbers = value.split('*');
      for (var i = 0; i < numbers.length; i++) {
        // check if the numbers is percedded or suceeded by spaces
        nis.add(int.parse(numbers[i].trim()));
      }
      int result = Calculate().multiply(nis[0], nis[1]);
      return result;
    } else if (value.contains('/')) {
      numbers = value.split('/');
      for (var i = 0; i < numbers.length; i++) {
        // check if the numbers is percedded or suceeded by spaces
        nis.add(int.parse(numbers[i].trim()));
      }
      var result = Calculate().divide(nis[0], nis[1]);
      return result;
    } else if (value.contains('^')) {
      numbers = value.split('^');
      for (var i = 0; i < numbers.length; i++) {
        // check if the numbers is percedded or suceeded by spaces
        nis.add(int.parse(numbers[i].trim()));
      }
      var result = Calculate().expo(nis[0], nis[1]);
      return result;
    } else {
      return "PLease enter some valid numbers";
    }
  }

  github(String value) async {
    var url = "https://api.github.com/users/$value/repos";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List repos = [];
      for (var item in data) {
        List newRepo = [item["name"], item["html_url"]];
        repos.add(newRepo);
      }
      print(repos);
      return repos;
    } else {
      throw Exception('Failed to load');
    }
  }

  movieList(var val) async {
    print("object=======");
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=e5ef35b8dd4155623b4c1a3d6bcc3dbb&language=en-US&query=$val&page=1&include_adult=false');
    var response = await http.get(url);
    //final Map<String, dynamic> parsedData = json.decode(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List movie = [];
      print("=======");
      for (var item in data['results']) {
        List movieData = [
          item["original_title"],
          item["popularity"],
        ];
        print(movieData);
        movie.add(movieData);
      }

      return movie;
    } else {
      throw Exception('Failed to load');
    }
  }

  recommendMovie(String val) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=e5ef35b8dd4155623b4c1a3d6bcc3dbb&language=en-US&page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List movie = [];
      for (var item in data['results']) {
        List movieData = [
          item["original_title"],
          item["popularity"],
        ];
        movie.add(movieData);
      }
      return movie;
    } else {
      throw Exception('Failed to load');
    }
  }

  // to get the meaning of a given word
  Future<String> getMeaning(var value) async {
    String finalValue = value.toString();
    var bool = isAlpha(finalValue);
    if (!bool) {
      Future.delayed(Duration(seconds: 1));
      return "String input only";
    }

    var url =
        "https://api.dictionaryapi.dev/api/v2/entries/en_US/" + finalValue;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data[0]["meanings"][0]["definitions"][0]["definition"];
    } else {
      throw Exception('Failed to load');
    }
  }
}

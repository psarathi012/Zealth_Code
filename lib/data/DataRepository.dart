import 'dart:convert';

import 'package:github_profile/data/models/NasaImage.dart';
import 'package:github_profile/data/models/Profile.dart';
import 'package:http/http.dart';

class DataRepository {

  String ERROR_IMAGE_URL = "https://i.pinimg.com/originals/5d/33/a1/5d33a10d3d20c73125e66a1f3cb4a974.jpg";

  Future<NasaImage> fetchUser(String date) async {
    print('this is the date in the API ${date}');
    String api = 'https://api.nasa.gov/planetary/apod?api_key=e7jFIvb6ih2hkvpuVjvAt1uOdgeAEoHh7QruIyPu&date=${date}';
    return await get(api).then((data) {
      final jsonData = json.decode(data.body);

      if (jsonData['message'] == "Not Found") {
        print("throw nf");
        throw UserNotFoundException();
      } else if (jsonData['date'] == date) {
        print("throw else ${jsonData['url']}");
        final image = NasaImage(
          date: jsonData['date'],
          explanation: jsonData['explanation'] ?? "",
          hdurl: jsonData['hdurl'],
          url: jsonData['url'],
          title: jsonData['title'],
        );
        return image;
      } else {
        final image = NasaImage(
          date: date,
          explanation: "",
          hdurl: ERROR_IMAGE_URL,
          url: ERROR_IMAGE_URL,
          title: jsonData['msg'] ?? "NASA Image could not be fetched! Retry with another date. "
        );

        return image;
      }
    }).catchError((context) {
      print("errror catch");
      throw UserNotFoundException();
    });
  }
}

class UserNotFoundException implements Exception {}

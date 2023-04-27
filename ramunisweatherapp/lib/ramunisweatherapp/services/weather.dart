import 'location.dart';
import 'network_helper.dart';
const apiKey = 'a0fff5baeda20538ce0c29c3b57c2209';//'79ab925ad5beea3f1600bb1279bca6a8'; //ключ api
/*Ссылки для работы с API*/

const apiUrl = 'http://api.openweathermap.org/data/2.5/weather';
const apiUrlHourly = 'http://api.openweathermap.org/data/2.5/forecast';

class Weather {
  /*Запрос для получения данных относительно названия города*/
  static Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$apiUrl?q=$cityName&appid=$apiKey&units=metric'
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  /*Запрос для получения данных относительно геолокации*/
  static Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);

    NetworkHelper networkHelper = NetworkHelper(
        '$apiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  /*Запрос для получения массива данных с ежечасной погодой на 3 суток вперед*/
  static Future<dynamic> getWeatherHourly(String city) async {
    //Location location = Location();
    //await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$apiUrlHourly?q=${city}&appid=$apiKey&units=metric'
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  /*Метод определения состояния погоды и выбора нужной картинки*/
  static String getWeatherPicture(int condition) {
    if (condition < 600) {
      return 'assets/light.png';
    } else if (condition == 800) {
      return 'assets/sun.png';
    } else if (condition <= 804) {
      return 'assets/cloud.png';
    } else {
      return 'assets/wind.png';
    }
  }
  /*Метод определения состояния погоды и выбора нужной подсказки*/
  static String getWeatherHint(int condition) {
    if (condition < 600) {
      return 'Strong rain';
    } else if (condition == 800) {
      return 'Sunny weather';
    } else if (condition <= 804) {
      return 'Cloudly';
    } else {
      return 'Error';
    }
  }
}


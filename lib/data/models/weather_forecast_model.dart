class WeatherForecastModel {
  final int dateTimeUnix;
  final String formattedDateTime;
  final String iconCode;
  final String weatherDescription;
  final double temperature;

  WeatherForecastModel({
    required this.dateTimeUnix,
    required this.formattedDateTime,
    required this.iconCode,
    required this.weatherDescription,
    required this.temperature,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      dateTimeUnix: json['dt'],
      formattedDateTime: json['dt_txt'],
      iconCode: json['weather'][0]['icon'],
      weatherDescription: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}
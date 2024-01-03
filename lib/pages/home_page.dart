import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_tutorial/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getWeather("Sacramento");
  }

  void _getWeather(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60), // Add space at the top
          _locationHeader(),
          const SizedBox(height: 16),
          _cityInput(),
          const SizedBox(height: 16),
          _dateTimeInfo(),
          const SizedBox(height: 6),
          _weatherIcon(),
          _currentTemp(),
          const SizedBox(height: 20),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Adjust color as needed
      ),
    );
  }

  Widget _cityInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _cityController,
        decoration: InputDecoration(
          labelText: 'Enter city name',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _getWeather(_cityController.text);
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "${DateFormat("M/d/y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cloud icon
              Icon(
                Icons.wb_cloudy,
                color: Colors.lightBlueAccent,
                size: 60.0,
              ),
              // Sun icon on top of the cloud
              Positioned(
                top: 5.0, // Adjust the position as needed
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.orangeAccent,
                  size: 60.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.fahrenheit?.toStringAsFixed(0)}° F",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      padding: const EdgeInsets.all(16.5),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _infoRow("Max", "${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C"),
          _infoRow("Min", "${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C"),
          _infoRow("Wind", "${_weather?.windSpeed?.toStringAsFixed(0)}m/s"),
          _infoRow("Humidity", "${_weather?.humidity?.toStringAsFixed(0)}%"),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
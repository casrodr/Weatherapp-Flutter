# Weather App

A simple Flutter app to display current weather information based on user-inputted city names and uses
an API to retrieve weather information from city name inputted.

## Features

- Display current weather information including temperature, wind speed, humidity, etc.
- User can input the city name to get weather details.
- Visual representation of weather conditions with icons.

## Screenshots

![WeatherAppScreen](https://github.com/casrodr/Weatherapp-Flutter/assets/102768038/7231bc69-dc54-4da2-a25e-c3e79196972c)


## API Key

This app uses the OpenWeatherMap API to fetch weather information. You'll need to obtain an API key from OpenWeatherMap to use this app.

### Getting an API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/).
2. Sign up for a free account or log in if you already have one.
3. After logging in, go to your [API keys](https://home.openweathermap.org/api_keys) page.
4. Generate a new API key by following the provided instructions.
5. Copy the generated API key.

### Using the API Key in the App

Once you have your API key:

1. Open the `consts.dart` file in the `lib` directory.
2. Replace the placeholder `OPENWEATHER_API_KEY` with your actual OpenWeatherMap API key.

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)

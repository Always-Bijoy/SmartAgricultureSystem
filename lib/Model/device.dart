class ESP32Device {
  Humidity humidity;
  Temperature temperature;
  SoilMoisture soilMoisture;

  ESP32Device({this.humidity, this.temperature, this.soilMoisture});

  ESP32Device.fromJson(Map<dynamic, dynamic> json) {
    humidity = json['Humidity'] != null
        ? new Humidity.fromJson(json['Humidity'])
        : null;
    temperature = json['Temperature'] != null
        ? new Temperature.fromJson(json['Temperature'])
        : null;
    soilMoisture = json['SoilMoisture'] != null
        ? new SoilMoisture.fromJson(json['SoilMoisture'])
        : null;
  }
}

class Humidity {
  num data;

  Humidity({this.data});

  Humidity.fromJson(Map<dynamic, dynamic> json) {
    data = json['Data'];
  }
}

class Temperature {
  num data;

  Temperature({this.data});

  Temperature.fromJson(Map<dynamic, dynamic> json) {
    data = json['Data'];
  }
}

class SoilMoisture {
  num data;

  SoilMoisture({this.data});

  SoilMoisture.fromJson(Map<dynamic, dynamic> json) {
    data = json['Data'];
  }
}

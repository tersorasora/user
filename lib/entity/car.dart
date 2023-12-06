import 'dart:convert';

class Car {
  final int? id_car;
  int? kursi, gps, bluetooth;
  double? fuel, harga;
  String? nama, merk, max_power, transmisi, max_speed, image_car;

  Car({
    this.id_car,
    this.nama,
    this.merk,
    this.max_power,
    this.fuel,
    this.transmisi,
    this.max_speed,
    this.kursi,
    this.gps,
    this.bluetooth,
    this.harga,
    this.image_car,
  });

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));
  factory Car.fromJson(Map<String, dynamic> json) {
    print('JSON data received: $json');
    return Car(
      id_car: json['id_car'],
      nama: json['nama'],
      merk: json['merk'],
      max_power: json['max_power'],
      fuel: json['fuel']?.toDouble(),
      transmisi: json['transmisi'],
      max_speed: json['max_speed'],
      kursi: json['kursi'],
      gps: json['gps'],
      bluetooth: json['bluetooth'],
      harga: json['harga']?.toDouble(),
      image_car: json['image_car'],
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_car': id_car,
        'nama': nama,
        'merk': merk,
        'max_power': max_power,
        'fuel': fuel,
        'transmisi': transmisi,
        'max_speed': max_speed,
        'kursi': kursi,
        'gps': gps,
        'bluetooth': bluetooth,
        'harga': harga,
        'image_car': image_car,
      };
}

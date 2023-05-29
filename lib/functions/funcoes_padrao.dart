import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String APIKey = "774efa6e0fdb438ea42231015230304";

Future<String> getLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) Future.value("");
  }
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) Future.value("");
  }
  locationData = await location.getLocation();

  double? latitude = locationData.latitude;
  double? longitude = locationData.longitude;

  // return "${locationData.latitude} : ${locationData.longitude}";

  Map<String, dynamic> endereco = await obterEndereco(latitude, longitude);
  // print(endereco);
  // print(latitude);
  // print(longitude);
  String pais = endereco['address']['country'];
  String estado = endereco['address']['state'];
  String cidade = endereco['address']['city'];
  String rua = endereco['address']['road'];

  // print('$pais, $estado, $cidade, $rua');

  String enderecoCompleto = '$pais, $estado, $cidade, $rua';

  // print(enderecoCompleto);

  return enderecoCompleto;
}

Future<Map<String, dynamic>> obterEndereco(
    double? latitude, double? longitude) async {
  final url =
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude';

  // print("url");
  // print(url);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final resultado = jsonDecode(response.body);
    return resultado;
  } else {
    throw Exception('Falha ao obter o endereço');
  }
}

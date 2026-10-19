import 'dart:convert';

import 'package:http/http.dart' as http;

class Tour {
  final String tourname;
  final DateTime startTime;
  final DateTime endTime;
  final int? id;

  Tour({
    required this.tourname,
    required this.startTime,
    required this.endTime,
    this.id
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id : json["id"] as int,
      tourname: json['tourname'] as String,
      startTime: DateTime.parse(json['startzeitpunkt']),
      endTime: DateTime.parse(json['endzeitpunkt']),
    );
  }

  Future<void> createTour(Tour tour) async {
    final String requestBody = jsonEncode(<String, dynamic>{
      'tourname': tour.tourname,
      'startzeitpunkt': tour.startTime.toIso8601String(),
      'endzeitpunkt': tour.endTime.toIso8601String(),
    });

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: requestBody,
    );
  }

  Future<void> removeTour(int tour_id ) async {
    final response = await http.delete(
      Uri.parse("http://127.0.0.1:8000/tours/$id"),
    );
  }
}
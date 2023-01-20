import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchData() async {
  await Future.delayed(const Duration(milliseconds: 1000));

  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('token') ?? "NA";
  final regno = prefs.getString('regno') ?? "NA";
  final enroll = prefs.getString('enroll') ?? "NA";
  final uano = prefs.getString('uano') ?? "NA";
  final hfid = prefs.getString('hfid') ?? "NA";

  // fetch image, result, info, result
}

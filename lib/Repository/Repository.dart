import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:error_products/Home/Model/ColorItem.dart';
import 'package:error_products/Home/Model/ErrorProductItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<List<ErrorProductItem>> fetchData(int skip) async {
    final itemUrl = Uri.parse('https://hiring-test.stag.tekoapis.net/api/products');
    List<ColorItem> listColor = await fetchColor();
    List<ErrorProductItem> listItem = [];
    try {
      final itemResponse = await http.get(itemUrl);
      final extractedData = jsonDecode(itemResponse.body);
      for (final data in extractedData) {
        if (data['color'] != null) {
          final colorName = listColor.firstWhere((element) => element.id == data['color']).name;
          listItem.add(ErrorProductItem.fromJson(data).copyWith(colorName: colorName));
        } else {
          listItem.add(ErrorProductItem.fromJson(data));
        }
      }
    } catch (e) {
      BotToast.showSimpleNotification(
          title: e.toString(),
          titleStyle: const TextStyle(color: CupertinoColors.white),
          duration: const Duration(seconds: 2),
          align: Alignment.bottomCenter,
          backgroundColor: Colors.red);
    }
    return listItem.skip(skip).take(10).toList();
  }

  Future<List<ColorItem>> fetchColor() async {
    final colorUrl = Uri.parse('https://hiring-test.stag.tekoapis.net/api/colors');
    List<ColorItem> listColor = [];
    try {
      final colorResponse = await http.get(colorUrl);
      final extractedColor = jsonDecode(colorResponse.body);
      for (final color in extractedColor) {
        listColor.add(ColorItem.fromJson(color));
      }
    } catch (e) {
      BotToast.showSimpleNotification(
          title: e.toString(),
          titleStyle: const TextStyle(color: CupertinoColors.white),
          duration: const Duration(seconds: 2),
          align: Alignment.bottomCenter,
          backgroundColor: Colors.red);
    }
    return listColor;
  }
}

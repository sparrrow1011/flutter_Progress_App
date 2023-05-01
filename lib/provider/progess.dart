import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viswal/model/documents.dart';


class ProgressProvider extends ChangeNotifier{
  Documents? allDocuments;
  double _progress = 0;
  double get progress => _progress;

  void nextStep(){
    print("to add 0.33");
    _progress += 0.33;
    notifyListeners();
  }
  void prevStep(){
    print("to subtract 0.33");
    _progress -= 0.33;
    notifyListeners();
  }
  void finish(){
    print("turn to 1");
    _progress = 1;
    notifyListeners();
  }


  void addDocument(String documentType, String documentValue) {
    allDocuments ??= Documents();
    switch (documentType) {
      case 'id':
        allDocuments!.id = documentValue;
        break;
      case 'number':
        allDocuments!.number = documentValue;
        break;
      case 'country':
        allDocuments!.country = documentValue;
        break;
      default:
        break;
    }
    saveDocuments();
    notifyListeners();
  }

  void saveDocuments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String documentsStr = jsonEncode(allDocuments!.toJson());
    prefs.setString('documents', documentsStr);
  }

  Future<Documents> getDocumentsInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap = {};
    final String documentsStr = prefs.getString('documents') ?? '';
    if (documentsStr.isNotEmpty) {
      userMap = jsonDecode(documentsStr) as Map<String, dynamic>;
    }
    final Documents documents = Documents.fromJson(userMap);
    allDocuments = documents;
    notifyListeners();
    print(allDocuments);
    return documents;
  }

  Future<void> clearDocuments() async {
    _progress = 0;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('documents');
    notifyListeners();
  }

}

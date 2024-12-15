import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon.codePoint,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }
}

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoryProvider() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      List<dynamic> categoriesList = json.decode(categoriesJson);
      _categories = categoriesList.map((item) => Category.fromMap(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> categoriesList = _categories.map((category) => category.toMap()).toList();
    String categoriesJson = json.encode(categoriesList);
    await prefs.setString('categories', categoriesJson);
  }

  void addCategory(Category category) {
    _categories.add(category);
    _saveCategories();
    notifyListeners();
  }

  void editCategory(int index, Category category) {
    _categories[index] = category;
    _saveCategories();
    notifyListeners();
  }

  void removeCategory(int index) {
    _categories.removeAt(index);
    _saveCategories();
    notifyListeners();
  }
}

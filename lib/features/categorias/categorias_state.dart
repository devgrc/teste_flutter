import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});

  // Converte a categoria para um mapa para armazenamento
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon.codePoint,
    };
  }

  // Cria uma categoria a partir de um mapa
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      // Usa 'fontFamily: 'MaterialIcons' para garantir que o ícone seja reconhecido
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

  // Carrega as categorias armazenadas no SharedPreferences
  Future<void> _loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      List<dynamic> categoriesList = json.decode(categoriesJson);
      _categories = categoriesList.map((item) => Category.fromMap(item)).toList();
      notifyListeners();
    }
  }

  // Salva as categorias no SharedPreferences
  Future<void> _saveCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> categoriesList = _categories.map((category) => category.toMap()).toList();
    String categoriesJson = json.encode(categoriesList);
    await prefs.setString('categories', categoriesJson);
  }

  // Adiciona uma nova categoria
  void addCategory(Category category) {
    _categories.add(category);
    _saveCategories();
    notifyListeners();
  }

  // Edita uma categoria existente
  void editCategory(int index, Category category) {
    _categories[index] = category;
    _saveCategories();
    notifyListeners();
  }

  // Remove uma categoria
  void removeCategory(int index) {
    _categories.removeAt(index);
    _saveCategories();
    notifyListeners();
  }
}

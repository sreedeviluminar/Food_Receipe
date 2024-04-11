import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RecipeProvider extends ChangeNotifier {
  List<dynamic> _recipes = [];
  List<dynamic> _filteredRecipes = [];

  List<dynamic> get recipes => _filteredRecipes.isNotEmpty ? _filteredRecipes : _recipes;

  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));
    if (response.statusCode == 200) {
      _recipes = json.decode(response.body)['recipes'];
      _filteredRecipes = _recipes; // Initialize filtered recipes with all recipes
      notifyListeners();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  void searchRecipes(String query) {
    _filteredRecipes = _recipes.where((recipe) {
      return recipe['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}

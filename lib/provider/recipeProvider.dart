import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];

  List<Recipe> get recipes => _filteredRecipes.isNotEmpty ? _filteredRecipes : _recipes;

  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));
    if (response.statusCode == 200) {
      Recepie recepie = recepieFromJson(response.body);
      _recipes = recepie.recipes ?? [];
      _filteredRecipes = _recipes; // Initialize filtered recipes with all recipes
      notifyListeners();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  void searchRecipes(String query) {
    _filteredRecipes = _recipes.where((recipe) {
      return recipe.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}

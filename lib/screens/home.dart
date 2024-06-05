import 'package:flutter/material.dart';
import 'package:foodreceipe/screens/widget/search.dart';
import 'package:foodreceipe/screens/widget/recipeGrid.dart';
import 'package:provider/provider.dart';
import '../provider/recipeProvider.dart';

class RecipeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? query = await showSearch(
                context: context,
                delegate: RecipeSearchDelegate(),
              );
              if (query != null && query.isNotEmpty) {
                recipeProvider.searchRecipes(query);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return RecipeGridView(recipeProvider.recipes, 4, constraints.maxWidth);
          } else if (constraints.maxWidth >= 400) {
            return RecipeGridView(recipeProvider.recipes, 2, constraints.maxWidth);
          } else {
            return RecipeGridView(recipeProvider.recipes, 1, constraints.maxWidth);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          recipeProvider.fetchRecipes();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

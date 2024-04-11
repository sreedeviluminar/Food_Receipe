
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../provider/recipeProvider.dart';
import 'details.dart';

class RecipeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class RecipeGridView extends StatelessWidget {
  final List<dynamic> recipes;
  final int crossAxisCount;
  final double maxWidth;

  RecipeGridView(this.recipes, this.crossAxisCount, this.maxWidth);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(recipe: recipes[index]),
              ),
            );
          },
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: maxWidth / crossAxisCount * 0.6,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                      child: Image.network(
                        recipes[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.0,
                        child: Text(
                          recipes[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Cuisine: ${recipes[index]['cuisine']}',
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Difficulty: ${recipes[index]['difficulty']}',
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

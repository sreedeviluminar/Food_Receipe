
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recipeProvider.dart';

class RecipeDetailPage extends StatelessWidget {
  final dynamic recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                recipe['ingredients'].length,
                    (index) => Text('- ${recipe['ingredients'][index]}'),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                recipe['instructions'].length,
                    (index) => Text('${index + 1}. ${recipe['instructions'][index]}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // No results page needed
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final List<dynamic> suggestions = query.isEmpty
        ? []
        : recipeProvider.recipes.where((recipe) {
      return recipe['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]['name']),
          onTap: () {
            close(context, suggestions[index]['name']);
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodreceipe/provider/recipeProvider.dart';
import 'package:foodreceipe/screens/home.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp1());
}
class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RecipeListPage(),
      ),
    );
  }
}

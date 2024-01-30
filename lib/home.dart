import 'dart:convert';

import 'package:apiwork/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<Recipies> fetchRecipes() async {
    final url = Uri.parse("https://dummyjson.com/recipes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Recipies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchRecipes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final rescipes = snapshot.data?.recipes;
              return ListView.builder(
                  itemCount: rescipes?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text(rescipes?[index].name ?? "harman"),
                    );
                  });
            }
          }),
    );
  }
}

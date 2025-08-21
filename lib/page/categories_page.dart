import 'package:flucknorris/model/jokes_respository.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final repository = JokesRespository();
  Future<List<String>>? futureCategories;

  @override
  void initState() {
    futureCategories = repository.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Oops, we found and error"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!;
            return ListView.separated(
              itemBuilder: (_, i) => ListTile(title: Text(data[i])),
              separatorBuilder: (_, i) => Divider(),
              itemCount: data.length,
            );
          }
          return Center(child: Text("Oops, we found and error"));
        },
      ),
    );
  }
}

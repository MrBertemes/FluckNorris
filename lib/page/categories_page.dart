import 'package:flucknorris/model/jokes_respository.dart';
import 'package:flucknorris/page/joke_page.dart';
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
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Hero(
            tag: 'chuck',
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/chuck.jpg"),
            ),
          ),
        ),
        title: Text(
          'FluckNorris',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(244, 255, 255, 152),
      ),
      body: FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 152, 152, 255),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("Oops, we found and error"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!;
            return ListView.separated(
              itemBuilder:
                  (_, i) => ListTile(
                    leading: Text("${i + 1}", style: TextStyle(fontSize: 22)),
                    title: Text(data[i], style: TextStyle(fontSize: 22)),
                    dense: true,
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => JokePage(cat: data[i]),
                        ),
                      );
                    },
                  ),
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

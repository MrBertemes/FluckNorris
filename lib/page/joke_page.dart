import 'package:flucknorris/model/joke_model.dart';
import 'package:flucknorris/model/jokes_respository.dart';
import 'package:flutter/material.dart';

class JokePage extends StatefulWidget {
  final String cat;
  const JokePage({super.key, required this.cat});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  bool isLoading = false;
  final repository = JokesRespository();

  Future<JokeModel>? joke;

  @override
  void initState() {
    joke = repository.getjokeByCategory(widget.cat.toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chosen categorty: ${widget.cat}'),
        backgroundColor: Color.fromARGB(244, 255, 255, 152),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 22),
            Hero(
              tag: 'chuck',
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/chuck.jpg'),
                radius: 80,
              ),
            ),
            FutureBuilder(
              future: joke,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 152, 152, 255),
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Oops, something went wrong...",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      snapshot.data!.value!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Oops, something went wrong...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 152, 152, 255),
        child: Icon(Icons.repeat, color: Colors.black),
        onPressed: () async {
          setState(() {
            joke = repository.getjokeByCategory(widget.cat.toLowerCase());
          });
        },
      ),
    );
  }
}

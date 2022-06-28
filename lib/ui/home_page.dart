import 'package:chuck_norris/bloc/bloc.dart';
import 'package:chuck_norris/core/ApiResponse.dart';
import 'package:chuck_norris/data/repository.dart';
import 'package:chuck_norris/data_source/api_source.dart';
import 'package:chuck_norris/domain/use_case.dart';
import 'package:chuck_norris/models/joke.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Joke> jokes = [];

  late Bloc _bloc;

  @override
  void initState() {
    _bloc = Bloc(UseCaseImpl(RepositoryImpl(ApiSourceImpl('https://api.chucknorris.io/jokes/random'))));
    getJokes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('JOKES'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<ApiResponse>(
          stream: _bloc.jokesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final response = snapshot.data;
              if (response?.errorMsg != '') {
                return Center(child: Text(response?.errorMsg ?? 'Error al cargar las bromas'),);
              } else {
                jokes.add(response?.data);
                  return ListView.builder(
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                      return Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Text(jokes[index].value ?? ''),
                          //Image.network(jokes[index].iconUrl ?? '')
                        ],
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        ),
      ),
    );
  }

  void getJokes() async {
    for (int i = 0; i < 20; i++) {
      await _bloc.getJokes();
    }
  }
}

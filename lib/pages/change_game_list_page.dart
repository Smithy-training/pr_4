import 'package:flutter/material.dart';
import '../models/game_model.dart';

class ChangeGameListPage extends StatefulWidget {
  @override
  _ChangeGameListPageState createState() => _ChangeGameListPageState();
}

class _ChangeGameListPageState extends State<ChangeGameListPage> {
  final List<Game> _games = List.from(games);

  void _addGame(Game newGame) {
    setState(() {
      _games.add(newGame);
    });
  }

  void _removeGame(int index) {
    setState(() {
      _games.removeAt(index);
    });
  }

  Future<void> _showAddGameDialog() async {
    String title = '';
    String description = '';
    double price = 0.0;
    String releaseDate = '';
    String developer = '';
    String imageUrl = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Game'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Title'),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Description'),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    price = double.tryParse(value) ?? 0.0;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Release Date'),
                  onChanged: (value) {
                    releaseDate = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Developer'),
                  onChanged: (value) {
                    developer = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Image URL'),
                  onChanged: (value) {
                    imageUrl = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (title.isNotEmpty && imageUrl.isNotEmpty) {
                  _addGame(Game(
                    title: title,
                    description: description,
                    price: price,
                    releaseDate: releaseDate,
                    developer: developer,
                    imageUrl: imageUrl,
                  ));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Games', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: _games.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_games[index].title, style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeGame(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGameDialog,
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

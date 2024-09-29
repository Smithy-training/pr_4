import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../components/item.dart';
import 'game_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isEditMode = false;
  List<Game> _games = [
    Game(
        title: 'Cuphead',
        description: 'A fun and challenging platformer.',
        price: 19.99,
        releaseDate: '2017-09-29',
        developer: 'Studio MDHR',
        imageUrl: 'assets/images/cuphead.png'),
    Game(title: 'elden ring', description: 'Not now', price: 999.9, releaseDate: '10.10.2010', developer: 'Indie', imageUrl: 'assets/images/elden_ring.png')
  ];

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _showAddGameDialog() {
    String title = '';
    String description = '';
    double price = 0.0;
    String releaseDate = '';
    String developer = '';
    String imageUrl = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text('Add New Game', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  onChanged: (value) => title = value,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  onChanged: (value) => description = value,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Release Date',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  onChanged: (value) => releaseDate = value,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Developer',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  onChanged: (value) => developer = value,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  onChanged: (value) => imageUrl = value,
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
                  setState(() {
                    _games.add(Game(
                      title: title,
                      description: description,
                      price: price,
                      releaseDate: releaseDate,
                      developer: developer,
                      imageUrl: imageUrl,
                    ));
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmRemoveGame(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text('Confirm Deletion', style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to delete this game?', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  _games.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _goToGameDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailPage(game: game),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Store'),
        leading: IconButton(
          icon: Icon(_isEditMode ? Icons.close : Icons.edit),
          onPressed: _toggleEditMode,
        ),
        actions: _isEditMode
            ? [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddGameDialog,
          ),
        ]
            : null,
      ),
      body: ListView.builder(
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          return GestureDetector(
            onTap: () => _goToGameDetail(game),
            child: Stack(
              children: [
                GameItem(game: game),
                if (_isEditMode)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmRemoveGame(index),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

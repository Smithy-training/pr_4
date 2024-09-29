import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameItem extends StatelessWidget {
  final Game game;

  GameItem({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        leading: Image.asset(game.imageUrl, width: 50, height: 50),
        title: Text(game.title, style: TextStyle(color: Colors.white)),
        subtitle: Text(game.description, style: TextStyle(color: Colors.white70)),
        trailing: Text('\$${game.price}', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

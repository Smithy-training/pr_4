class Game {
  final String title;
  final String description;
  final double price;
  final String releaseDate;
  final String developer;
  final String imageUrl;

  Game({
    required this.title,
    required this.description,
    required this.price,
    required this.releaseDate,
    required this.developer,
    required this.imageUrl,
  });
}


final List<Game> games = [
  Game(
    title: 'Cuphead',
    description: 'A classic run and gun action game...',
    price: 19.99,
    releaseDate: 'September 29, 2017',
    developer: 'Studio MDHR',
    imageUrl: ' cuphead.png',
  ),
];
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game Store",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const GameListScreen(),
    );
  }
}

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  _GameListScreenState createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  List<Map<String, String>> games = [
    {
      'name': 'GTA VI',
      'image': 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1jAyV3.img',
      'description': 'Артикул: GTA6-PS5-2024\n\n'
          'Добро пожаловать в мир Grand Theft Auto VI — следующую главу культовой серии игр от Rockstar Games! '
          'Вас ждет масштабный открытый мир, охватывающий не только знаменитый город Вайс-Сити, но и множество новых локаций, '
          'включая джунгли, побережья и мегаполисы. История расскажет о двух главных героях, чьи судьбы переплетаются в криминальном мире. '
          'Многослойный сюжет, продвинутая система взаимодействий с окружающим миром и ультрареалистичная графика делают GTA VI одной из самых ожидаемых игр десятилетия.\n\n'
          'Особенности игры:\n'
          'Цена: 4999 рублей\n\n'
          'Платформы: PlayStation 5, Xbox Series X|S, PC\n'
          'Дата выхода: 2024.'
    },
    {
      'name': 'Cyberpunk 2077',
      'image': 'https://i0.wp.com/mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/81a4e680815973.5cec6bcf6aa1a.jpg?ssl=1',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    },
    {
      'name': 'The Last Of Us',
      'image': 'https://mir-s3-cdn-cf.behance.net/project_modules/1400/110a6323982149.5632c1abead45.jpg',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.'
    }
  ];

  void addGame(Map<String, String> newGame) {
    setState(() {
      games.add(newGame);
    });
  }

  void deleteGame(int index) {
    setState(() {
      games.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Game Store",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white70,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: GameList(games: games, onDeleteGame: deleteGame),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGameScreen(onAddGame: addGame),
            ),
          );
        },
      ),
    );
  }
}

class GameList extends StatelessWidget {
  final List<Map<String, String>> games;
  final Function(int) onDeleteGame;

  const GameList({super.key, required this.games, required this.onDeleteGame});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            games[index]['name']!,
            style: const TextStyle(color: Colors.white, fontSize: 26),
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  games[index]['description']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              Container(
                width: 200,
                height: 150,
                margin: const EdgeInsets.only(left: 8.0),
                child: Image.network(
                  games[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              onDeleteGame(index);
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameDetail(
                  name: games[index]['name']!,
                  imageUrl: games[index]['image']!,
                  description: games[index]['description']!,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey);
      },
    );
  }
}

class GameDetail extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;

  const GameDetail({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AddGameScreen extends StatefulWidget {
  final Function(Map<String, String>) onAddGame;

  const AddGameScreen({super.key, required this.onAddGame});

  @override
  _AddGameScreenState createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _imageUrl = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Game"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Game Name'),
                onSaved: (value) {
                  _name = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the game name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (value) {
                  _imageUrl = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onAddGame({
                      'name': _name,
                      'image': _imageUrl,
                      'description': _description,
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


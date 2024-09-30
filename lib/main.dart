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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              "Game Store",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white70,
              ),
            ),
          ),
        ),
        body: GameList(),
      ),
    );
  }
}

class GameList extends StatelessWidget {
  final List<Map<String, String>> games = [
    {
      'name': 'GTA VI',
      'image': 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1jAyV3.img',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.'
    },
    {
      'name': 'Cyberpunk 2077',
      'image': 'https://i0.wp.com/mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/81a4e680815973.5cec6bcf6aa1a.jpg?ssl=1',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.'
    },
    {
      'name': 'Detroit: Become Human',
      'image': 'https://pic.rutubelist.ru/video/bc/aa/bcaa4fa6410b7dc5b3ce156ed6f29e46.jpg',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.'
    },
    {
      'name': 'The Last Of Us',
      'image': 'https://mir-s3-cdn-cf.behance.net/project_modules/1400/110a6323982149.5632c1abead45.jpg',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.'
    },
    {
      'name': 'Beyond Two Souls',
      'image': 'https://pic.rutubelist.ru/video/32/37/32372abf9e74c1aaf4b11e241728456b.jpg',
      'description': 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            games[index]['name']!,
            style: const TextStyle(color: Colors.white, fontSize: 32),
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
                width: 320,
                height: 160,
                margin: const EdgeInsets.only(left: 8.0),
                child: Image.network(
                  games[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ],
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
          Container(
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

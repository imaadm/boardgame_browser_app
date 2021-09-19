import 'package:boardgame_browser_app/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';
import 'favorites.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boardgame Browser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Boardgame Browser'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Browse'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            title: 'Browse',
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesPage(
                            title: 'Favorites',
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          //   Image(image: AssetImage('assets/appIcon.png')),

          Card(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(
                                title: 'Game',
                              )),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Text('Example Boardgame'),
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                            )),
                      ],
                    ),
                  ))),
          Card(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(
                                title: 'Game',
                              )),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Text('Example Boardgame'),
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                            )),
                      ],
                    ),
                  ))),

          Card(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(
                                title: 'Game',
                              )),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Text('Example Boardgame'),
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                            )),
                      ],
                    ),
                  ))),
          Card(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(
                                title: 'Game',
                              )),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Text('Example Boardgame'),
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                            )),
                      ],
                    ),
                  ))),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

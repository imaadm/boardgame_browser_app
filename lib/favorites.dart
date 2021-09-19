import 'package:boardgame_browser_app/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';
import 'settings.dart';
import 'main.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Favorites'),
              onTap: () {
                // Update the state of the app.
                // ...
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
                  child: const SizedBox(
                      width: 200,
                      height: 150,
                      child: Text('Example Boardgame')))),
          Card(
              child: InkWell(
                  child: const SizedBox(
                      width: 200,
                      height: 150,
                      child: Text('Example Boardgame 2')))),

          Card(
              child: InkWell(
                  child: const SizedBox(
                      width: 200,
                      height: 150,
                      child: Text('Example Boardgame')))),
          Card(
              child: InkWell(
                  child: const SizedBox(
                      width: 200,
                      height: 150,
                      child: Text('Example Boardgame')))),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

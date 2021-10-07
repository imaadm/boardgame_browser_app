import 'package:boardgame_browser_app/game_page.dart';
import 'package:flutter/material.dart';
import 'game_page.dart';
import 'settings.dart';
import 'main.dart';
import 'package:filter_list/filter_list.dart';
import 'globals.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> filterList = ["Price", "Players", "Popularity"];
  List<String>? selectedFilterList = [];
  Color _iconColor = Colors.grey;

  void _openFilterDialog() async {
    await FilterListDialog.display<String>(context,
        listData: filterList,
        selectedListData: selectedFilterList,
        height: 480,
        headlineText: "Select Count",
        searchFieldHintText: "Search Here", choiceChipLabel: (item) {
      return item;
    }, validateSelectedItem: (list, val) {
      return list!.contains(val);
    }, onItemSearch: (list, text) {
      if (list!.any(
          (element) => element.toLowerCase().contains(text.toLowerCase()))) {
        return list!
            .where(
                (element) => element.toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else {
        return [];
      }
    }, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          selectedFilterList = List.from(list);
        });
      }
      Navigator.pop(context);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      GlobalVariables.selectedIndex = index;
    });
  }

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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         label: 'FavoritesButton',
      //         icon: IconButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => FavoritesPage(
      //                           title: 'Favorites',
      //                         )),
      //               );
      //               setState(() {
      //                 _iconColor = Colors.blue;
      //               });
      //             },
      //             icon: Icon(
      //               Icons.favorite,
      //               color: _iconColor,
      //             ))),
      //     BottomNavigationBarItem(
      //         label: 'BrowseButton',
      //         icon: IconButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => HomePage(
      //                           title: 'Browse',
      //                         )),
      //               );
      //               setState(() {
      //                 _iconColor = Colors.blue;
      //               });
      //             },
      //             icon: Icon(
      //               Icons.favorite,
      //               color: _iconColor,
      //             ))),
      //     BottomNavigationBarItem(
      //         label: 'SettingsButton',
      //         icon: IconButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => GamePage(
      //                           title: 'Settings',
      //                         )),
      //               );
      //             },
      //             icon: Icon(Icons.settings))),
      //   ],
      //   fixedColor: Colors.grey,
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openFilterDialog,
        tooltip: 'Filter',
        child: Icon(Icons.sort),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/nav/first_screen.dart';
import 'package:flutter_application_1/screens/nav/profil.dart';
import 'package:flutter_application_1/screens/nav/second_secreen.dart';
import 'package:get/route_manager.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int currentPage = 0;

  List<Widget> widgets = [];

  String titre = "Home";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    widgets = [
      FirstPage(),
      SecondPage(),
      ProfilPage(),
      ProfilPage()
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget createDrawerItem({required IconData icon, required String titre}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          titre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/image.jpg")
                  )
                ),
              )
            ),
            createDrawerItem(
              icon: Icons.settings,
              titre: "Parametres hsjsjsjskkskslslslsllslsllslslsllslsllslslsl"
            ),
            createDrawerItem(
              icon: Icons.lan, 
              titre: "Langue"
            ),
            Divider()
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(titre),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {

        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          clipBehavior: Clip.antiAlias,

        child: Container(
          color: Colors.orange,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: "News"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Compte"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock),
                label: "Profil"
              )
            ]
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentPage,
          children: widgets,
        )
      )
    );
  }
}
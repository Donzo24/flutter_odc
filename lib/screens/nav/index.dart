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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titre),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                            Colors.yellow,
                            Colors.yellow,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
          child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            currentPage = index;

            switch (index) {
              case 0:
                titre = "Home";
                break;
              case 1:
                titre = "News";
                break;
              case 2:
                titre = "Profil";
              default:
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "News"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: "Profil"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: "Profil"
          )
        ]
      ),
        ),
      ),
      body: IndexedStack(
        index: currentPage,
        children: widgets,
      )
    );
  }
}
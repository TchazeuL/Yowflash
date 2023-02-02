import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:yowflash/Firebase/auth._services.dart';
import 'package:yowflash/screen/Acceuil/home_screen.dart';
import 'package:yowflash/screen/Authentification/Login/login_screen.dart';
import 'package:yowflash/screen/Categories/categories_screen.dart';
import 'package:yowflash/screen/Flash/flash_screen.dart';
import 'package:yowflash/screen/Flasher/components/button_add.dart';
import 'package:yowflash/screen/Flasher/flasher_screen.dart';
import 'package:yowflash/screen/Setting/setting_screen.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  List<String> get title =>
      ["Categories", "Flash", "Acceuil", "Flasher", "FlashBack"];

  @override
  State<StatefulWidget> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _currentTabIndex = 2;
  final user = FirebaseAuth.instance.currentUser;
  List<Widget?> list = [];
  final users = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final kTabPages = <Widget>[
      const Scaffold(body: ListCategories()),
      Scaffold(body: PostFlashScreen()),
      const Center(child: HomeScreen()),
      Scaffold(
          body: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: const [ListFlash()],
          ))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FlasherScreen()));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Vous n'etes pas connecte"),
                          content: const Text(
                              "Connecte vous a votre compte avant de publier un produit"),
                          actions: [
                            TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, "Cancel"),
                                child: const Text("Cancel",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 4, 112, 185)))),
                            TextButton(
                                onPressed: () => Navigator.pop(context, "Ok"),
                                child: const Text("Ok",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 4, 112, 185)))),
                          ],
                        )).then((value) {
                  if (value == "Ok") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  }
                });
              }
            },
            elevation: 10.0,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30.0,
            ),
          )),
      Center(
          child: SingleChildScrollView(
              child: Text(user == null ? "Flashback" : users!.uid)))
    ];
    final kBottomMenuItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.category), label: "Categories"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.data_saver_off), label: "Flash"),
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Acceuil"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_to_photos), label: "Flasher"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.history), label: "Flashback")
    ];
    assert(kTabPages.length == kBottomMenuItems.length);
    final bottomMenu = BottomNavigationBar(
      items: kBottomMenuItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 80.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.title[_currentTabIndex],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            titlePadding: const EdgeInsets.fromLTRB(16, 15, 15, 15),
            centerTitle: true,
          ),
          leading: const Icon(Icons.shopping_cart),
          scrolledUnderElevation: 2.0,
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == "Signin") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                } else if (value == "Signout") {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Deconexion"),
                            content: const Text(
                                "Etes vous sur de vouloir vous deconnecter ?"),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "Annuler"),
                                  child: const Text("Annuler",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 4, 112, 185)))),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, "Ok"),
                                  child: const Text("Ok",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 4, 112, 185)))),
                            ],
                          )).then((value) {
                    if (value == "Ok") {
                      Authentication().deconnexion().then((value) =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomMenu())));
                    }
                  });
                } else {
                  if (value == "Parametres") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingScreen()));
                  }
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      PopupMenuItem(
                        value: user == null ? "Signin" : "Signout",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(user == null ? Icons.login : Icons.logout,
                                color: const Color.fromARGB(255, 4, 112, 185)),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              user == null ? "Connexion" : "Deconnexion",
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      PopupMenuItem(
                        value: "notifications",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(Icons.notifications,
                                color: Color.fromARGB(255, 4, 112, 185)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Notifications",
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      PopupMenuItem(
                        value: "Parametres",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(Icons.settings,
                                color: Color.fromARGB(255, 4, 112, 185)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Parametres",
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
                ];
              },
              child: const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Color(0xffE6E6E6),
                    radius: 18.0,
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 84, 139, 146),
                    ),
                  )),
            ),
            const SizedBox(width: 15.0)
          ],
        ),
        SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: kTabPages[_currentTabIndex]))
      ]),
      bottomNavigationBar: bottomMenu,
    );
  }
}

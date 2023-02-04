import "dart:io";

import "package:adaptive_theme/adaptive_theme.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:yowflash/database/database.dart";
import "package:yowflash/screen/main_app_screen.dart";
import "package:yowflash/widget/const.dart";
import "package:yowflash/widget/functions.dart";
import "package:intl/intl.dart";

class FormUpdate extends StatefulWidget {
  const FormUpdate({
    super.key,
    required this.docId,
    required this.time,
    required this.name,
    required this.prix,
    required this.description,
  });
  final String docId, name, prix, description;
  final DateTime time;
  @override
  State<StatefulWidget> createState() => _FormUpdate();
}

class _FormUpdate extends State<FormUpdate> {
  DateTime date = DateTime(2023);
  File? _imageFile;
  final _picker = ImagePicker();
  final formkey = GlobalKey<FormState>();
  User? users = FirebaseAuth.instance.currentUser;
  String? name, description, price;
  dynamic savedTheme;
  bool darkmode = false;

  final dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
    dbHelper.asyncInit();
  }

  Future getCurrentTheme() async {
    savedTheme = await AdaptiveTheme.getThemeMode();
    if (savedTheme.toString() == "AdaptiveThemeMode.dark") {
      setState(() {
        darkmode = true;
      });
    } else {
      setState(() {
        darkmode = false;
      });
    }
  }

  String? categorie;
  bool nameValid = true,
      prixValid = true,
      dateValid = true,
      descValid = true,
      loading = false;
  static const list = <String>[
    "Telephone",
    "Livre",
    "Ordinateur",
    "Chaussure",
    "Montre",
    "Ecouteur",
    "Television",
    "Refrigerateur"
  ];

  Future<void> updateProducts() async {
    final Map<String, dynamic> produits = {
      "uid": users?.uid,
      "name": name,
      "categorie": categorie,
      "date": date.millisecondsSinceEpoch,
      "prix": price,
      "email": users?.email,
      "create": DateTime.now().millisecondsSinceEpoch,
      "description": description
    };
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      loading = true;
      setState(() {});
      CollectionReference db =
          FirebaseFirestore.instance.collection("Produits");
      CollectionReference post =
          FirebaseFirestore.instance.collection("Publications");

      post.doc(widget.docId).update({
        "categorie": produits["categorie"],
        "name": produits["name"],
        "prix": produits["prix"],
        "description": produits["description"],
        "date": produits["date"],
        "email": produits["email"],
        "uid": produits["uid"]
      });
      db.doc(widget.docId).update({
        "categorie": produits["categorie"],
        "name": produits["name"],
        "prix": produits["prix"],
        "description": produits["description"],
        "date": produits["date"],
        "create": produits["create"],
        "user_id": produits["uid"],
      }).then((value) {
        void insertion() async {
          Map<String, dynamic> row = {
            DbHelper.columnId: produits["id"],
            DbHelper.columnName: produits["name"],
          };
          final id = await dbHelper.insertProduit(row);
          debugPrint("Ajout reussi: $id");
        }

        insertion;
        loading = false;
        setState(() {});
        done("Produit ajoute a l'instant");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BottomMenu()));
      }).catchError((e) {
        loading = false;
        setState(() {});
        error("Erreur de publication");
      });
    }
    formkey.currentState!.reset();
  }

  Future<void> _pickImageFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() => _imageFile = File(pickedFile!.path));
  }

  Future<void> _pickImageFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() => _imageFile = File(pickedFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    Widget select() {
      if (date.month < DateTime.now().month ||
          date.compareTo(DateTime.now()) < 0) {
        return const Text("Date limite du post");
      } else {
        return Text(DateFormat.yMMMd().format(date));
      }
    }

    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            key: formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      child: const Text("Prendre une photo"),
                      onPressed: () => {
                            showDialog(
                                context: context,
                                builder: ((context) => SimpleDialog(
                                        title: const Text(
                                          "Choisir",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 34, 156, 255)),
                                        ),
                                        children: [
                                          ListTile(
                                            leading: const Icon(
                                                Icons.photo_camera,
                                                color: Color.fromARGB(
                                                    255, 4, 112, 185)),
                                            title: const Text("Appareil photo"),
                                            onTap: () => Navigator.pop(
                                                context, "appareil"),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.photo,
                                                color: Color.fromARGB(
                                                    255, 4, 112, 185)),
                                            title: const Text("Galerie"),
                                            onTap: () => Navigator.pop(
                                                context, "galerie"),
                                          )
                                        ]))).then((value) {
                              if (value == "appareil") {
                                _pickImageFromCamera();
                              }
                              if (value == "galerie") {
                                _pickImageFromGallery();
                              }
                            })
                          }),
                  const SizedBox(height: 10.0),
                  if (_imageFile == null)
                    Container(
                        width: 350.0,
                        height: 200.0,
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                            color: darkmode == true
                                ? const Color.fromARGB(255, 47, 46, 46)
                                : Colors.white,
                            border:
                                Border.all(width: 1.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Placeholder(
                            fallbackHeight: 250.0,
                            fallbackWidth: 350.0,
                            strokeWidth: 0.0,
                            color: darkmode == true
                                ? const Color.fromARGB(255, 47, 46, 46)
                                : Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Inserez l'image de votre produit",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            )))
                  else
                    Image.file(_imageFile!),
                  DropdownButton(
                      icon: Icon(
                        Icons.category,
                        color: darkmode == true
                            ? kPrimaryColor
                            : kPrimaryLightColor,
                      ),
                      value: categorie,
                      onChanged: (String? newValue) {
                        setState(() {
                          categorie = newValue;
                        });
                      },
                      hint: const Text(
                        "Categories",
                        textAlign: TextAlign.center,
                      ),
                      elevation: 10,
                      items: list
                          .map((String value) => DropdownMenuItem(
                              value: value, child: Text(value)))
                          .toList(),
                      borderRadius: BorderRadius.circular(10.0),
                      alignment: AlignmentDirectional.center),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    initialValue: widget.name,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    onSaved: ((val) => name = val!),
                    cursorColor:
                        darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                    enabled: true,
                    onChanged: (value) {
                      if (value.isNotEmpty || name!.isNotEmpty) {
                        setState(() => nameValid = true);
                      }
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                            color: darkmode == true
                                ? kPrimaryColor
                                : kPrimaryLightColor,
                            style: BorderStyle.solid,
                          )),
                      filled: true,
                      prefixIcon: const Icon(Icons.breakfast_dining_rounded),
                      label: const Text("Nom du produit"),
                      hintText: "Entrer le nom de votre produit",
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    initialValue: widget.prix,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.number,
                    onSaved: ((val) => price = val!),
                    cursorColor:
                        darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                    enabled: true,
                    onChanged: (value) {
                      if (value.contains(RegExp(r"[0-9]"))) {
                        setState(() => prixValid == true);
                      }
                    },
                    decoration: InputDecoration(
                      errorText: prixValid ? null : "Format de prix non valide",
                      border: UnderlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(
                            color: darkmode == true
                                ? kPrimaryColor
                                : kPrimaryLightColor,
                            style: BorderStyle.solid,
                          )),
                      filled: true,
                      prefixIcon: const Icon(Icons.attach_money),
                      label: const Text("Prix"),
                      suffixText: "XAF",
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(3000),
                      ).then((value) {
                        value = widget.time;
                        if (value.compareTo(DateTime.now()) < 0) {
                          setState(() => date = value!);
                        }
                      });
                    },
                    child: select(),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: widget.description,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.multiline,
                    onSaved: ((val) => description = val!),
                    cursorColor:
                        darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                    enabled: true,
                    onChanged: (value) {
                      if (value.isNotEmpty || description!.isNotEmpty) {
                        setState(() => descValid = true);
                      }
                    },
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(
                              color: darkmode == true
                                  ? kPrimaryColor
                                  : kPrimaryLightColor,
                              style: BorderStyle.solid,
                            )),
                        filled: true,
                        prefixIcon: const Icon(Icons.description),
                        label: const Text("Description"),
                        hintText:
                            "Decrivez votre produit en donnant ses caracteristiques"),
                    maxLines: 4,
                    maxLength: 150,
                  ),
                  const SizedBox(height: 18.0),
                  SizedBox(
                      width: 50.0,
                      child: ElevatedButton(
                        onPressed: (name!.isEmpty ||
                                prix.isEmpty ||
                                description!.isEmpty ||
                                categorie!.isEmpty ||
                                date.day.isNaN ||
                                loading == true)
                            ? null
                            : updateProducts,
                        child: loading
                            ? const CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 215, 215, 215),
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : const Text("Publier"),
                      ))
                ])));
  }
}

import "package:flutter/material.dart";
import "package:intl_phone_field/intl_phone_field.dart";
import "package:yowflash/screen/Flasher/components/form_screen.dart";
import "package:yowflash/widget/const.dart";

class FormNumber extends StatefulWidget {
  const FormNumber({super.key});

  @override
  State<StatefulWidget> createState() => _FormNumber();
}

class _FormNumber extends State<FormNumber> {
  final TextEditingController phone = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool darkmode = false;
  bool phoneValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
          ),
          title: const Text(
            "Numero",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Form(
              key: formkey,
              child: Column(children: [
                IntlPhoneField(
                  controller: phone,
                  initialCountryCode: "CM",
                  invalidNumberMessage: "Numero de telephone invalide",
                  searchText: "Rechercher votre pays",
                  keyboardType: TextInputType.phone,
                  cursorColor:
                      darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                  enabled: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => phoneValid = true);
                    } else {
                      setState(() => phoneValid = false);
                    }
                  },
                  decoration: InputDecoration(
                    errorText: phoneValid
                        ? null
                        : "Le numero de telephone n'est pas valide",
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
                    prefixIcon: const Icon(Icons.phone),
                    label: const Text("Telephone"),
                    hintText: "Entrer votre numero de telephone",
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormFlasherScreen()));
                    },
                    child: const Text("Valider"))
              ])),
        ));
  }
}

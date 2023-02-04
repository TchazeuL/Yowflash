import "package:adaptive_theme/adaptive_theme.dart";
import "package:flutter/material.dart";
import "package:intl_phone_field/intl_phone_field.dart";
import "package:yowflash/screen/Flasher/flasher_screen.dart";
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
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    var savedTheme = await AdaptiveTheme.getThemeMode();
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

  void sendNumber() {
    if (formkey.currentState!.validate()) {
      loading = true;
      setState(() {});
      formkey.currentState!.save();
      if (phoneValid == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FlasherScreen(phone: phone.text)));
        loading = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(children: [
          IntlPhoneField(
            controller: phone,
            initialCountryCode: "CM",
            invalidNumberMessage: "Numero de telephone invalide",
            searchText: "Rechercher votre pays",
            keyboardType: TextInputType.phone,
            cursorColor: darkmode == true ? kPrimaryColor : kPrimaryLightColor,
            enabled: true,
            onChanged: (value) {
              if (value != null) {
                setState(() => phoneValid = true);
              } else {
                setState(() => phoneValid = false);
              }
            },
            decoration: InputDecoration(
              errorText:
                  phoneValid ? null : "Le numero de telephone n'est pas valide",
              border: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(
                    color:
                        darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                    style: BorderStyle.solid,
                  )),
              filled: true,
              prefixIcon: const Icon(Icons.phone),
              label: const Text("Telephone"),
              hintText: "Entrer votre numero de telephone",
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed:
                  (loading == false || phoneValid == false) ? sendNumber : null,
              child: loading == true
                  ? const CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(255, 215, 215, 215),
                      valueColor: AlwaysStoppedAnimation(Colors.blue))
                  : const Text("Valider"))
        ]));
  }
}

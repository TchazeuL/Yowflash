import "package:adaptive_theme/adaptive_theme.dart";
import "package:flutter/material.dart";
import "package:yowflash/Firebase/auth._services.dart";
import "package:yowflash/model/user.dart";
import "package:yowflash/screen/main_app_screen.dart";
import "package:yowflash/widget/const.dart";
import "package:yowflash/widget/functions.dart";

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<StatefulWidget> createState() => _SignInForm();
}

class _SignInForm extends State<SignInForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool checkbox = false, _obscure = true, loading = false, darkmode = false;
  dynamic savedTheme;

  void submit() {
    loading = true;
    setState(() {});
    final user = Users(email: email.text, password: password.text);
    Authentication().signIn(user).then((value) {
      if (value == true) {
        done("Connecte");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const BottomMenu()));
      } else {
        loading = false;
        setState(() {});
        error("Adresse email ou mot de passe incorrecte");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24.0),
            TextFormField(
              controller: email,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.emailAddress,
              cursorColor:
                  darkmode == true ? kPrimaryColor : kPrimaryLightColor,
              enabled: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                      color:
                          darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                      style: BorderStyle.solid,
                    )),
                filled: true,
                prefixIcon: const Icon(Icons.mail),
                label: const Text("Email"),
                hintText: "Entrer votre adresse email",
              ),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: password,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              cursorColor:
                  darkmode == true ? kPrimaryColor : kPrimaryLightColor,
              obscureText: _obscure,
              enabled: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                      color:
                          darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                      style: BorderStyle.solid,
                    )),
                filled: true,
                prefixIcon: const Icon(Icons.vpn_key),
                suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    _obscure = !_obscure;
                  }),
                  child: _obscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                label: const Text("Mot de passe"),
              ),
            ),
            const SizedBox(height: 30.0),
            Row(children: [
              Checkbox(
                  value: checkbox,
                  activeColor:
                      darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                  splashRadius: 2.0,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => checkbox = value);
                    }
                  }),
              const SizedBox(height: 5.0),
              const Text("Je confirme les informations ci-dessus ")
            ]),
            const SizedBox(height: 30.0),
            SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: checkbox == false ||
                            loading == true ||
                            email.text.isEmpty ||
                            password.text.isEmpty
                        ? null
                        : submit,
                    child: loading == true
                        ? const CircularProgressIndicator(
                            backgroundColor: Color.fromARGB(255, 215, 215, 215),
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          )
                        : const Text("Valider")))
          ],
        ));
  }
}

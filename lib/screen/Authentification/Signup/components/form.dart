import "package:adaptive_theme/adaptive_theme.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yowflash/Firebase/auth._services.dart";
import "package:yowflash/model/user.dart";
import 'package:yowflash/screen/Authentification/Otp/otp_form.dart';
import "package:yowflash/widget/const.dart";
import "package:yowflash/widget/functions.dart";
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  bool nameValid = true,
      phoneValid = true,
      emailValid = true,
      passwordValid = true,
      passwordConfirmValid = true,
      checkbox = false,
      loading = false,
      _obscure = true,
      _obscure1 = true,
      signup = true,
      darkmode = false;

  final formkey = GlobalKey<FormState>();
  dynamic savedTheme;

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

  void sentOtp() {
    final user = <String, dynamic>{
      "name": name.text,
      "email": email.text,
      "phone": "+237${phone.text}",
      "password": password.text,
    };
    final users = Users(email: email.text, password: password.text);
    if (formkey.currentState!.validate()) {
      debugPrint(name.text);
      formkey.currentState!.save();
      loading = true;
      setState(() {});
      Authentication().signUp(users).then((value) {
        if (value == true) {
          final u = FirebaseAuth.instance.currentUser;
          u?.delete();
          Authentication().verifier(user["phone"],
              onCodeSend: (verificationId, resendToken) {
            loading = false;
            setState(() {});
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpForm(
                      verificationId: verificationId,
                      name: user["name"],
                      phone: user["phone"],
                      email: user["email"],
                      password: user["password"],
                    )));
          }, onAutoVerify: (val) {
            Authentication().auth.signInWithCredential(val);
          }, onFailed: (e) {
            loading = false;
            setState(() {});
            error("Probleme de connexion");
          }, autoRetrievial: (val) {
            formkey.currentState!.reset();
          });
        } else {
          loading = false;
          setState(() {});
          error("Cette adresse email est deja utilise");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: name,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  cursorColor:
                      darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                  enabled: true,
                  onChanged: (value) {
                    if (value.contains(RegExp(r"A-Za-z")) && value.isNotEmpty) {
                      setState(() => nameValid == true);
                    }
                  },
                  decoration: InputDecoration(
                    errorText: nameValid
                        ? null
                        : "Le nom d'utilisateur ne contient pas de chiffre",
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
                    prefixIcon: const Icon(Icons.person),
                    label: const Text("Nom"),
                    hintText: "Entrer votre nom complet",
                  ),
                ),
                const SizedBox(height: 24.0),
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
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: email,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor:
                      darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                  enabled: true,
                  onChanged: (value) {
                    if (value.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")) &&
                        value.isNotEmpty) {
                      setState(() => emailValid = true);
                    } else {
                      setState(() => emailValid = false);
                    }
                  },
                  decoration: InputDecoration(
                    errorText:
                        emailValid ? null : "L'adresse email n'est pas valide",
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
                  onChanged: (value) {
                    if (value.length < 8 || value.isEmpty) {
                      setState(() => passwordValid = false);
                    } else {
                      setState(() => passwordValid = true);
                    }
                  },
                  decoration: InputDecoration(
                    errorText: passwordValid == true
                        ? null
                        : "Le mot de passe doit contenir au moins 8 caracteres",
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
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: passwordConfirm,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  cursorColor:
                      darkmode == true ? kPrimaryColor : kPrimaryLightColor,
                  obscureText: _obscure1,
                  enabled: password.text.isEmpty || passwordValid == false
                      ? false
                      : true,
                  onChanged: (value) {
                    if (value == password.text && value.isNotEmpty) {
                      setState(() => passwordConfirmValid = true);
                    } else {
                      setState(() => passwordConfirmValid = false);
                    }
                  },
                  decoration: InputDecoration(
                    errorText: passwordConfirmValid == true
                        ? null
                        : "Les mots de passe ne sont pas identiques",
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
                    prefixIcon: const Icon(Icons.vpn_key),
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() {
                        _obscure1 = !_obscure1;
                      }),
                      child: _obscure1
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    label: const Text("Confirmer le Mot de passe"),
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
                  const Text("Je confirme les informations ci-dessus")
                ]),
                const SizedBox(height: 30.0),
                SizedBox(
                    width: 50,
                    child: ElevatedButton(
                        onPressed: nameValid == true &&
                                emailValid == true &&
                                phoneValid == true &&
                                passwordValid == true &&
                                passwordConfirmValid == true &&
                                checkbox == true &&
                                name.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                phone.text.isNotEmpty &&
                                password.text.isNotEmpty &&
                                passwordConfirm.text.isNotEmpty &&
                                loading == false
                            ? sentOtp
                            : null,
                        child: loading
                            ? const CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 215, 215, 215),
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : const Text("Valider")))
              ],
            )));
  }
}

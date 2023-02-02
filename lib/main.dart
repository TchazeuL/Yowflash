import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yowflash/database/database.dart';
import 'package:yowflash/firebase_options.dart';
import 'package:yowflash/screen/wrapper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yowflash/widget/const.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: kPrimaryLightColor,
          splashColor: Colors.white,
          textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context)
              .textTheme
              .apply(bodyColor: const Color.fromARGB(255, 28, 27, 27))),
          dropdownMenuTheme: const DropdownMenuThemeData(
              menuStyle: MenuStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              textStyle: TextStyle(
                color: Color.fromARGB(255, 34, 32, 32),
              )),
          popupMenuTheme: const PopupMenuThemeData(
              color: Colors.white,
              textStyle: TextStyle(
                  fontFamily: "Ubuntu",
                  color: Color.fromARGB(255, 34, 32, 32),
                  fontSize: 15.0)),
          iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(backgroundColor: kPrimaryLightColor)),
          iconTheme: const IconThemeData(color: kPrimaryLightColor),
          inputDecorationTheme: const InputDecorationTheme(
              focusColor: kPrimaryLightColor,
              floatingLabelStyle: TextStyle(color: kPrimaryLightColor),
              iconColor: kPrimaryLightColor,
              prefixIconColor: kPrimaryLightColor,
              suffixIconColor: kPrimaryLightColor),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: kPrimaryLightColor,
            foregroundColor: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
              foregroundColor: kPrimaryLightColor,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
            elevation: 4.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            fixedSize: Size(MediaQuery.of(context).size.width, 60),
          )),
          cardColor: Colors.white,
          cardTheme: const CardTheme(elevation: 2.0, color: Colors.white),
          appBarTheme: const AppBarTheme(
              backgroundColor: kPrimaryLightColor,
              foregroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.white,
              )),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: kPrimaryLightColor,
              unselectedItemColor: Color.fromARGB(255, 4, 126, 171)),
          dividerColor: const Color.fromARGB(255, 102, 102, 102),
        ),
        dark: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.green,
            splashColor: blackColor,
            textTheme: GoogleFonts.ubuntuTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: const Color.fromARGB(255, 211, 206, 206),
                  ),
            ),
            dropdownMenuTheme: const DropdownMenuThemeData(
                menuStyle: MenuStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0))),
                textStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold)),
            popupMenuTheme: const PopupMenuThemeData(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontFamily: "Ubuntu",
                ),
                color: Color.fromARGB(255, 28, 27, 27)),
            iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(backgroundColor: kPrimaryColor)),
            iconTheme: const IconThemeData(color: kPrimaryColor),
            inputDecorationTheme: const InputDecorationTheme(
                focusColor: kPrimaryColor,
                floatingLabelStyle: TextStyle(color: kPrimaryLightColor),
                iconColor: kPrimaryColor,
                prefixIconColor: kPrimaryColor,
                suffixIconColor: kPrimaryColor),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: blackColor,
                foregroundColor: kPrimaryColor,
              ),
            ),
            elevatedButtonTheme:
                ElevatedButtonThemeData(style: buttonStyleDark),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              elevation: 4.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              fixedSize: Size(MediaQuery.of(context).size.width, 60),
            )),
            cardColor: cardcolor,
            cardTheme: const CardTheme(elevation: 2.0, color: cardcolor),
            appBarTheme: const AppBarTheme(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Colors.white,
                )),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: kPrimaryColor,
                unselectedItemColor: Colors.white),
            dividerColor: const Color.fromARGB(255, 240, 237, 237)),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darktheme) => MaterialApp(
              title: 'YowFlash',
              theme: theme,
              darkTheme: darktheme,
              home: Wrapper(),
              debugShowCheckedModeBanner: false,
            ));
  }
}

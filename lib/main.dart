import 'package:flutter/material.dart';

import 'src/main_view.dart';

void main() {
  // LicenseRegistry.addLicense(() async* {
  // yield LicenseEntryWithLineBreaks(['google_fonts'],
  //     await rootBundle.loadString('google_fonts/OFL_fred_the_great.txt'));
  // yield LicenseEntryWithLineBreaks(['google_fonts'],
  //     await rootBundle.loadString('google_fonts/OFL_unica_one.txt'));
  // });

  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialFreecell());
}

class MaterialFreecell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material Freecell',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue.shade800,
            primaryColorLight: Colors.red,
            primaryColorDark: Colors.red,
            accentColor: Colors.blue.shade900,
            canvasColor: Colors.blue.shade50,
            shadowColor: Colors.grey.shade900,
            highlightColor: Colors.red,
            bottomAppBarColor: Colors.blue.shade800,
            cardColor: Colors.lime.shade50,
            iconTheme: IconThemeData(color: Colors.blue.shade50),
            textTheme: TextTheme(
              headline5: TextStyle(
                  color: Colors.blue.shade100,
                  fontSize: 44,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
            )),
        home: View());
  }
}

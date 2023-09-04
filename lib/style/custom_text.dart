import 'package:pdf/widgets.dart' as pw;

class Customtext {
  static double sizeTheme = 14;
  static double sizeTitle = 12;
  static double sizeSubTitle = 10;
  static double sizeSubTitle2 = 8;
  static double sizeIconDefault = 16;

  static pw.TextStyle h1 =
      pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);

  static pw.TextStyle h2 =
      pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.normal);

  static pw.TextStyle h3 =
      pw.TextStyle(fontSize: sizeTheme, fontWeight: pw.FontWeight.normal);

  static pw.TextStyle h4 =
      pw.TextStyle(fontSize: sizeTitle, fontWeight: pw.FontWeight.normal);

  static pw.TextStyle h5 =
      pw.TextStyle(fontSize: sizeSubTitle, fontWeight: pw.FontWeight.normal);

  static pw.TextStyle h6 =
      pw.TextStyle(fontSize: sizeSubTitle2, fontWeight: pw.FontWeight.normal);
}

import 'package:material_ui/material_ui.dart';

ThemeData careerTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff2563eb),
      brightness: brightness,
    ),
    scaffoldBackgroundColor: dark
        ? const Color(0xff0f172a)
        : const Color(0xfff8fafc),
    cardTheme: CardThemeData(
      elevation: 0,
      color: dark ? const Color(0xff1e293b) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    visualDensity: VisualDensity.standard,
  );
}

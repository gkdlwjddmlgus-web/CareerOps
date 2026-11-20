import 'package:material_ui/material_ui.dart';

ThemeData careerTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: const Color(0xff2563eb),
          brightness: brightness,
        ).copyWith(
          primary: dark ? const Color(0xff93c5fd) : const Color(0xff2563eb),
          surface: dark ? const Color(0xff1e293b) : Colors.white,
          onSurface: dark ? const Color(0xfff8fafc) : const Color(0xff0f172a),
          onSurfaceVariant: dark
              ? const Color(0xffcbd5e1)
              : const Color(0xff64748b),
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

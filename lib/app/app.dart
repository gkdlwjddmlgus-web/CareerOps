import 'package:material_ui/material_ui.dart';

import 'router.dart';
import 'theme.dart';

class CareerOpsApp extends StatelessWidget {
  const CareerOpsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'CareerOps',
    debugShowCheckedModeBanner: false,
    theme: careerTheme(Brightness.light),
    darkTheme: careerTheme(Brightness.dark),
    locale: const Locale('ko'),
    supportedLocales: const [Locale('ko')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    routerConfig: appRouter,
  );
}

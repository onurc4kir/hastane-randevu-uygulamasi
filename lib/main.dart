import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:randevu_al/core/theme/app_theme.dart';
import 'package:randevu_al/root_binding.dart';
import 'package:randevu_al/routes/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://fdwiockshyoscsiqyalj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZkd2lvY2tzaHlvc2NzaXF5YWxqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE4NDUwMTEsImV4cCI6MTk5NzQyMTAxMX0.Jgmyhdo8oUTgfyc03fgZaqTFE5LsIFLm9Q-JZUldNHM",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        theme: appThemeData,
        debugShowCheckedModeBanner: true,
        getPages: GetPages.pages,
        unknownRoute: GetPage(
          name: '/notfound',
          page: () => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        ),
        initialRoute: GetPages.initialRoute,
        initialBinding: RootBinding(),
        locale: const Locale('en'),
        supportedLocales: const [
          Locale('en'),
        ],
      ),
    );
  }
}

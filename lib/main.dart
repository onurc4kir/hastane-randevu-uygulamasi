import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:randevu_al/core/theme/app_theme.dart';
import 'package:randevu_al/root_binding.dart';
import 'package:randevu_al/routes/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
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

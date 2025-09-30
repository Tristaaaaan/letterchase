import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/config/app_config.dart';
import 'package:letterchase/config/app_environments.dart';
import 'package:letterchase/core/appthemes/app_themes.dart';
import 'package:letterchase/core/appthemes/approutes/app_routes.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.development);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    final theme = isDarkMode ? ThemeNotifier.darkMode : ThemeNotifier.lightMode;

    return MaterialApp.router(
      theme: theme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

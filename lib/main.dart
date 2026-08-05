import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';
import 'package:panorama_360_test_app/widgets/cupertino_tab_bar_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final brightness = MediaQuery.platformBrightnessOf(context);
        final isDark = brightness == Brightness.dark;

        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            brightness: brightness,
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.bg(isDark),
            barBackgroundColor: AppColors.card(isDark),
          ),
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: const MainScreen(),
        );
      },
    );
  }
}

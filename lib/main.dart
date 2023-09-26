import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:tfg_v3/firebase_options.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/features/authentication/screens/splash/splash_screen.dart';
import 'package:tfg_v3/src/providers/chats_provider.dart';
import 'package:tfg_v3/src/providers/models_provider.dart';
import 'package:tfg_v3/src/services/local_storage.dart';
import 'package:tfg_v3/src/utils/theme/theme.dart';

// TODO: canviar per mantenir dark o light theme (amb shared_preferences)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    isLightTheme.add(iconBool);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return StreamBuilder<bool>(
      stream: isLightTheme.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator.adaptive(backgroundColor: tVividSkyBlue);
        }

        iconBool = snapshot.data!;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ModelsProvider()),
            ChangeNotifierProvider(create: (_) => ChatProvider()),
          ],
          child: GetMaterialApp(
            title: "Brainy",
            debugShowCheckedModeBanner: false,
            theme: snapshot.data! ? lightTheme : darkTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:tfg_v3/src/app/chat_generator/providers/chats_provider.dart';
import 'package:tfg_v3/src/app/chat_generator/providers/memory_provider.dart';
import 'package:tfg_v3/src/app/splash/pages/splash_screen.dart';

import 'package:tfg_v3/src/core/services/firebase_options.dart';
import 'package:tfg_v3/src/core/services/local_storage.dart';

import 'src/core/presentation/utils/constants/colors.dart';
import 'src/core/presentation/utils/constants/text_strings.dart';
import 'src/core/presentation/theme/theme.dart';

// TODO: Mantenir Mode (Light Mode i Dark Mode)
// TODO: Afegir forma de pagament
// TODO: Notifications
// TODO: Pujar App al Play Store
// TODO: Afegir Facebook Authentification

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env
  await dotenv.load(fileName: '.env');

  // LOCAL STORAGE
  await LocalStorage.configurePrefs();

  // FIREBASE
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run App
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
          return const CircularProgressIndicator.adaptive(backgroundColor: YColors.primary);
        }

        iconBool = snapshot.data!;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MemoryProvider()),
            ChangeNotifierProvider(create: (_) => ChatProvider()),
          ],
          child: GetMaterialApp(
            title: YTexts.brainy,
            debugShowCheckedModeBanner: false,
            theme: snapshot.data! ? lightTheme : darkTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

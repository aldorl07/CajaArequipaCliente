import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'ui/theme/app_theme.dart';
import 'navigation/app_navigation.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'viewmodel/home_viewmodel.dart';
import 'viewmodel/viewmodel_provider.dart';

void main() async {
  // Aseguramos que la vinculación de widgets esté inicializada
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed in Cliente App: $e');
  }

  // Instanciamos los ViewModels que mantendrán el estado de la aplicación
  final authViewModel = AuthViewModel();
  final homeViewModel = HomeViewModel();

  // Reiniciamos la base de datos de créditos para empezar de 0 en la demostración
  await homeViewModel.resetCreditDatabase();

  runApp(
    ViewModelProvider<AuthViewModel>(
      viewModel: authViewModel,
      child: ViewModelProvider<HomeViewModel>(
        viewModel: homeViewModel,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caja Arequipa - App Cliente',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppNavigation.initialRoute,
      onGenerateRoute: AppNavigation.onGenerateRoute,
    );
  }
}

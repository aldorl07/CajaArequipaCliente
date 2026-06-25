import 'package:flutter/material.dart';
import 'ui/theme/app_theme.dart';
import 'navigation/app_navigation.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'viewmodel/home_viewmodel.dart';
import 'viewmodel/viewmodel_provider.dart';

void main() {
  // Aseguramos que la vinculación de widgets esté inicializada
  WidgetsFlutterBinding.ensureInitialized();

  // Instanciamos los ViewModels que mantendrán el estado de la aplicación
  final authViewModel = AuthViewModel();
  final homeViewModel = HomeViewModel();

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../ui/theme/app_colors.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../viewmodel/viewmodel_provider.dart';
import '../../navigation/app_navigation.dart';
import '../widgets/caja_arequipa_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _passController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _dniController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(AuthViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    // Ocultar teclado
    FocusScope.of(context).unfocus();

    final success = await viewModel.login(
      _dniController.text,
      _passController.text,
    );

    if (mounted) {
      if (success) {
        // Navegar al Dashboard y limpiar la pila de pantallas
        Navigator.of(context).pushReplacementNamed(AppNavigation.dashboard);
      } else {
        // Mostrar Snackbar de error con el color corporativo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.rojoCoral,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    viewModel.errorMessage ?? 'Credenciales incorrectas',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModelProvider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.fondoInterfaz,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Cabecera superior curvada con degradado corporativo
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.azulMarino, Color(0xFF003b80)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CajaArequipaLogo(size: 110),
                      const SizedBox(height: 16),
                      const Text(
                        'Caja Arequipa',
                        style: TextStyle(
                          color: AppColors.blancoPuro,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        'Banca por Internet',
                        style: TextStyle(
                          color: AppColors.turquesaBrillante.withValues(alpha: 0.9),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Contenedor del formulario
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 6,
                  shadowColor: AppColors.azulMarino.withValues(alpha: 0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: _formKey, // Usando la clave global del formulario
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.azulMarino,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Input DNI
                          const Text(
                            'Número de DNI',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.azulMarino,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _dniController,
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textoOscuro),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: 'Ingrese su DNI de 8 dígitos',
                              prefixIcon: Icon(Icons.badge_outlined, color: AppColors.azulMarino),
                            ),
                            onChanged: (_) => viewModel.clearError(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ingrese su DNI';
                              }
                              if (value.length != 8) {
                                return 'El DNI debe tener 8 dígitos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Input Contraseña
                          const Text(
                            'Clave Internet',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.azulMarino,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passController,
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textoOscuro),
                            decoration: InputDecoration(
                              hintText: 'Ingrese su clave de 6 dígitos',
                              prefixIcon: const Icon(Icons.lock_outlined, color: AppColors.azulMarino),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                  color: AppColors.azulMarino,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            onChanged: (_) => viewModel.clearError(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ingrese su clave';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),

                          // Botón Ingresar
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: viewModel.isLoading ? null : () => _handleLogin(viewModel),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.turquesaBrillante,
                                disabledBackgroundColor: AppColors.turquesaBrillante.withValues(alpha: 0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: viewModel.isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: AppColors.azulMarino,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Ingresar',
                                      style: TextStyle(
                                        color: AppColors.azulMarino,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Enlace de ayuda o seguridad
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.security, size: 16, color: AppColors.textoGris),
                  const SizedBox(width: 8),
                  Text(
                    'Operación 100% Segura',
                    style: TextStyle(
                      color: AppColors.textoGris.withValues(alpha: 0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../viewmodel/viewmodel_provider.dart';
import '../../navigation/app_navigation.dart';
import '../../viewmodel/home_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = ViewModelProvider.of<AuthViewModel>(context);
    final user = authViewModel.user;
    final String userName = user?.fullName ?? 'Cliente';
    final String userDni = user?.dni ?? '--------';
    final String userEmail = user?.email ?? 'sin correo';

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          // Cabecera con avatar
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.azulMarino,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
            child: Column(
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.turquesaBrillante.withValues(alpha: 0.2),
                    border: Border.all(
                      color: AppColors.turquesaBrillante,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'C',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.turquesaBrillante,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  userName,
                  style: const TextStyle(
                    color: AppColors.blancoPuro,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'DNI: $userDni',
                  style: TextStyle(
                    color: AppColors.blancoPuro.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: AppColors.turquesaBrillante.withValues(alpha: 0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Sección: Información Personal
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  _buildProfileTile(Icons.person_outline, 'Nombre Completo', userName),
                  _buildDivider(),
                  _buildProfileTile(Icons.badge_outlined, 'DNI', userDni),
                  _buildDivider(),
                  _buildProfileTile(Icons.email_outlined, 'Correo', userEmail),
                  _buildDivider(),
                  _buildProfileTile(Icons.phone_outlined, 'Teléfono', '+51 987 654 321'),
                  _buildDivider(),
                  _buildProfileTile(Icons.location_on_outlined, 'Dirección', 'Arequipa, Perú'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Sección: Configuración
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  _buildMenuTile(
                    context,
                    Icons.notifications_outlined,
                    'Notificaciones',
                    'Gestionar alertas y avisos',
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    context,
                    Icons.lock_outlined,
                    'Seguridad',
                    'Cambiar clave y opciones de acceso',
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    context,
                    Icons.help_outline,
                    'Centro de Ayuda',
                    'Preguntas frecuentes y soporte',
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    context,
                    Icons.description_outlined,
                    'Términos y Condiciones',
                    'Documentos legales',
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    context,
                    Icons.refresh,
                    'Reiniciar Créditos (Demo)',
                    'Borrar solicitudes y volver a empezar',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Reiniciar Datos'),
                            content: const Text(
                              '¿Desea borrar las solicitudes de crédito creadas y restablecer el saldo del préstamo a S/ 0 para iniciar una nueva demostración?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(color: AppColors.textoGris),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(ctx).pop();
                                  final homeViewModel = ViewModelProvider.of<HomeViewModel>(context);
                                  
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppColors.azulMarino,
                                      content: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Text('Restableciendo base de datos...'),
                                        ],
                                      ),
                                    ),
                                  );

                                  await homeViewModel.resetCreditDatabase();

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppColors.turquesaOscuro,
                                      content: Text('Base de datos restablecida correctamente.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.turquesaBrillante,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Confirmar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Botón Cerrar Sesión
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('Cerrar Sesión'),
                        content: const Text('¿Está seguro de que desea salir de su cuenta?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancelar', style: TextStyle(color: AppColors.textoGris)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              authViewModel.logout();
                              Navigator.of(context).pushReplacementNamed(AppNavigation.login);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.rojoCoral,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Salir'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout, color: AppColors.rojoCoral),
                label: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: AppColors.rojoCoral,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.rojoCoral),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Versión de la app
          Text(
            'Caja Arequipa v1.0.0 (S9)',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textoGris.withValues(alpha: 0.6),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.turquesaBrillante.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.turquesaOscuro, size: 22),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textoGris,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.azulMarino,
        ),
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.azulMarino.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.azulMarino, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.azulMarino,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textoGris,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textoGris),
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.azulMarino,
            content: Text('Sección "$title" disponible próximamente.'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 72);
  }
}

import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../../viewmodel/viewmodel_provider.dart';
import '../../navigation/app_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Cargar los datos ficticios al inicializar la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeViewModel = ViewModelProvider.of<HomeViewModel>(context);
      homeViewModel.fetchDashboardData();
    });
  }

  void _handleLogout(AuthViewModel authViewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Está seguro de que desea salir de su cuenta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: AppColors.textoGris)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
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
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ViewModelProvider.of<AuthViewModel>(context);
    final homeViewModel = ViewModelProvider.of<HomeViewModel>(context);

    final String clientName = authViewModel.user?.fullName ?? 'Cliente';

    return Scaffold(
      backgroundColor: AppColors.fondoInterfaz,
      appBar: AppBar(
        title: const Text(
          'Caja Arequipa',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.blancoPuro),
            tooltip: 'Cerrar Sesión',
            onPressed: () => _handleLogout(authViewModel),
          ),
        ],
      ),
      body: homeViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.turquesaBrillante,
              ),
            )
          : RefreshIndicator(
              onRefresh: () => homeViewModel.fetchDashboardData(),
              color: AppColors.turquesaBrillante,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner de Bienvenida
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.azulMarino,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(28),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola,',
                            style: TextStyle(
                              color: AppColors.blancoPuro.withValues(alpha: 0.7),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            clientName,
                            style: const TextStyle(
                              color: AppColors.blancoPuro,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.turquesaBrillante.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.turquesaBrillante.withValues(alpha: 0.5)),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.security, color: AppColors.turquesaBrillante, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Token Digital Activo',
                                      style: TextStyle(
                                        color: AppColors.turquesaBrillante,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Sección: Mis Cuentas
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Cuentas de Ahorros',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulMarino,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tarjeta Ahorros
                    if (homeViewModel.savingsAccount != null)
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        elevation: 3,
                        shadowColor: AppColors.azulMarino.withValues(alpha: 0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Colors.white, AppColors.fondoInterfaz.withValues(alpha: 0.3)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.turquesaBrillante.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.account_balance_wallet_outlined,
                                          color: AppColors.turquesaOscuro,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ahorro Corriente',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.azulMarino,
                                            ),
                                          ),
                                          Text(
                                            'Caja Arequipa',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textoGris,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textoGris),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'N° ${homeViewModel.savingsAccount!.accountNumber}',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 14,
                                  color: AppColors.textoGris,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    'Saldo Disponible',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textoGris.withValues(alpha: 0.8),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${homeViewModel.savingsAccount!.currency} ${homeViewModel.savingsAccount!.balance.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.azulMarino,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Sección: Mis Créditos
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Créditos Activos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulMarino,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tarjeta Crédito
                    if (homeViewModel.creditProduct != null)
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        elevation: 3,
                        shadowColor: AppColors.azulMarino.withValues(alpha: 0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.amarilloMostaza.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.amarilloMostaza.withValues(alpha: 0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.assignment_outlined,
                                          color: AppColors.naranjaOcre,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeViewModel.creditProduct!.productName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.azulMarino,
                                            ),
                                          ),
                                          Text(
                                            'Contrato: ${homeViewModel.creditProduct!.contractNumber}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textoGris,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textoGris),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Divider(color: AppColors.grisBorde.withValues(alpha: 0.5)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Próxima Cuota',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textoOscuro,
                                    ),
                                  ),
                                  Text(
                                    '${homeViewModel.creditProduct!.currency} ${homeViewModel.creditProduct!.pendingInstallment.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.rojoCoral,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vence el:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textoGris.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  Text(
                                    homeViewModel.creditProduct!.dueDate,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textoOscuro,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Sección: Movimientos Recientes
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Movimientos Recientes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulMarino,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Lista de transacciones
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeViewModel.transactions.length,
                      itemBuilder: (context, index) {
                        final tx = homeViewModel.transactions[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          elevation: 1,
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: tx.isIncome
                                    ? AppColors.verdeCesped.withValues(alpha: 0.12)
                                    : AppColors.rojoCoral.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                tx.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                                color: tx.isIncome ? AppColors.verdeCesped : AppColors.rojoCoral,
                                size: 18,
                              ),
                            ),
                            title: Text(
                              tx.description,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textoOscuro,
                              ),
                            ),
                            subtitle: Text(
                              tx.date,
                              style: const TextStyle(fontSize: 12, color: AppColors.textoGris),
                            ),
                            trailing: Text(
                              '${tx.isIncome ? "+" : "-"} S/ ${tx.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: tx.isIncome ? AppColors.verdeCesped : AppColors.textoOscuro,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
          if (index != 0) {
            // Mostrar snackbar que indica que por rúbrica de S9 solo funciona la pestaña Inicio
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.azulMarino,
                content: Text(
                  'El Tab ${index == 1 ? "Cuentas" : index == 2 ? "Créditos" : "Perfil"} está deshabilitado temporalmente en la entrega S9.',
                  style: const TextStyle(color: AppColors.blancoPuro),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.blancoPuro,
        selectedItemColor: AppColors.amarilloMostaza, // Pestañas activas y resaltados en Amarillo/Mostaza
        unselectedItemColor: AppColors.textoGris,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Cuentas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Créditos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

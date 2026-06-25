import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../../viewmodel/viewmodel_provider.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ViewModelProvider.of<HomeViewModel>(context);
    final account = homeViewModel.savingsAccount;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mis Cuentas',
                  style: TextStyle(
                    color: AppColors.blancoPuro,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Gestiona tus cuentas de ahorro',
                  style: TextStyle(
                    color: AppColors.turquesaBrillante,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tarjeta principal de cuenta
          if (account != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.azulMarino, Color(0xFF003b80)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.azulMarino.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ahorro Corriente',
                          style: TextStyle(
                            color: AppColors.blancoPuro,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.verdeCesped.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Activa',
                            style: TextStyle(
                              color: AppColors.verdeCesped,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Saldo Disponible',
                      style: TextStyle(
                        color: AppColors.turquesaBrillante,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${account.currency} ${account.balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.blancoPuro,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow('N° Cuenta', account.accountNumber),
                          const SizedBox(height: 8),
                          _buildInfoRow('CCI', account.cci),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Acciones rápidas
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Acciones Rápidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildQuickAction(context, Icons.send, 'Transferir', AppColors.turquesaBrillante),
                  const SizedBox(width: 12),
                  _buildQuickAction(context, Icons.qr_code_scanner, 'Pagar QR', AppColors.amarilloMostaza),
                  const SizedBox(width: 12),
                  _buildQuickAction(context, Icons.receipt_long, 'Historial', AppColors.verdeCesped),
                  const SizedBox(width: 12),
                  _buildQuickAction(context, Icons.share, 'Compartir', AppColors.turquesaOscuro),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Detalle de la cuenta
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Detalle de Cuenta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildDetailRow('Tipo de Cuenta', 'Ahorro Corriente'),
                    const Divider(height: 24),
                    _buildDetailRow('Moneda', 'Soles (PEN)'),
                    const Divider(height: 24),
                    _buildDetailRow('Estado', 'Activa'),
                    const Divider(height: 24),
                    _buildDetailRow('Tasa de Interés', '2.5% TEA'),
                    const Divider(height: 24),
                    _buildDetailRow('Fecha de Apertura', '15 Ene 2024'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.blancoPuro.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.blancoPuro,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.azulMarino,
              content: Text('Función "$label" disponible próximamente.'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textoGris,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.azulMarino,
          ),
        ),
      ],
    );
  }
}

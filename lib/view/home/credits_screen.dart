import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../../viewmodel/viewmodel_provider.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ViewModelProvider.of<HomeViewModel>(context);
    final credit = homeViewModel.creditProduct;

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
                  'Mis Créditos',
                  style: TextStyle(
                    color: AppColors.blancoPuro,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Administra tus préstamos activos',
                  style: TextStyle(
                    color: AppColors.amarilloMostaza,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          if (credit != null) ...[
            // Resumen de deuda total
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.amarilloMostaza.withValues(alpha: 0.15),
                      AppColors.naranjaOcre.withValues(alpha: 0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.amarilloMostaza.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.naranjaOcre, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Resumen de Deuda',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.naranjaOcre,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${credit.currency} ${credit.totalDebt.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulMarino,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Deuda total pendiente',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textoGris,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tarjeta del crédito activo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Crédito Activo',
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
              elevation: 3,
              shadowColor: AppColors.azulMarino.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.amarilloMostaza.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.assignment_outlined,
                            color: AppColors.naranjaOcre,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                credit.productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.azulMarino,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Contrato: ${credit.contractNumber}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textoGris,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.verdeCesped.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Al día',
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
                    const Divider(),
                    const SizedBox(height: 12),

                    // Información del crédito
                    _buildCreditRow('Deuda Total', '${credit.currency} ${credit.totalDebt.toStringAsFixed(2)}'),
                    const SizedBox(height: 12),
                    _buildCreditRow('Próxima Cuota', '${credit.currency} ${credit.pendingInstallment.toStringAsFixed(2)}', valueColor: AppColors.rojoCoral),
                    const SizedBox(height: 12),
                    _buildCreditRow('Fecha de Vencimiento', credit.dueDate),
                    const SizedBox(height: 12),
                    _buildCreditRow('Tasa de Interés', '18.5% TEA'),
                    const SizedBox(height: 12),
                    _buildCreditRow('Plazo', '24 meses'),
                    const SizedBox(height: 12),
                    _buildCreditRow('Cuotas Pagadas', '8 de 24'),

                    const SizedBox(height: 20),

                    // Barra de progreso del crédito
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Progreso de pago',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textoOscuro,
                              ),
                            ),
                            Text(
                              '33%',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.turquesaBrillante,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: 0.33,
                            minHeight: 10,
                            backgroundColor: AppColors.grisBorde,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.turquesaBrillante),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Botón pagar cuota
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.azulMarino,
                              content: Text('Función de pago disponible próximamente.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.payment),
                        label: const Text('Pagar Cuota'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.turquesaBrillante,
                          foregroundColor: AppColors.azulMarino,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Cronograma de pagos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Próximos Pagos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                ),
              ),
            ),
            const SizedBox(height: 12),

            _buildPaymentItem(context, 'Cuota 9', '10 Jul 2026', '${credit.currency} 520.40', false),
            _buildPaymentItem(context, 'Cuota 10', '10 Ago 2026', '${credit.currency} 520.40', false),
            _buildPaymentItem(context, 'Cuota 11', '10 Sep 2026', '${credit.currency} 520.40', false),

            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }

  Widget _buildCreditRow(String label, String value, {Color? valueColor}) {
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.azulMarino,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentItem(BuildContext context, String cuota, String fecha, String monto, bool isPaid) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      elevation: 1,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isPaid
                ? AppColors.verdeCesped.withValues(alpha: 0.12)
                : AppColors.amarilloMostaza.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isPaid ? Icons.check_circle : Icons.schedule,
            color: isPaid ? AppColors.verdeCesped : AppColors.amarilloMostaza,
            size: 20,
          ),
        ),
        title: Text(
          cuota,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textoOscuro,
          ),
        ),
        subtitle: Text(
          'Vence: $fecha',
          style: const TextStyle(fontSize: 12, color: AppColors.textoGris),
        ),
        trailing: Text(
          monto,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.azulMarino,
          ),
        ),
      ),
    );
  }
}

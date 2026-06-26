import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Encuentra el crédito ideal para ti',
                  style: TextStyle(
                    color: AppColors.amarilloMostaza,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Estado vacío - Sin créditos activos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.blancoPuro,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grisBorde),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.turquesaBrillante.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.verdeCesped,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '¡Estás libre de deudas!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.azulMarino,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'No tienes créditos activos en este momento.\nExplora nuestras opciones de financiamiento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textoGris,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Sección: Solicitar Crédito
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Solicitar un Crédito',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.azulMarino,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Elige el tipo de crédito que necesitas',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textoGris,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tarjeta: Crédito Personal
          _buildCreditOption(
            context,
            icon: Icons.person_outline,
            title: 'Crédito Personal',
            description: 'Para cubrir gastos personales, viajes, educación y más.',
            tasaDesde: '14.5% TEA',
            montoMax: 'S/ 50,000',
            color: AppColors.turquesaBrillante,
          ),

          // Tarjeta: Crédito MYPE
          _buildCreditOption(
            context,
            icon: Icons.store_outlined,
            title: 'Crédito MYPE Emprendedor',
            description: 'Capital de trabajo o activos fijos para tu negocio.',
            tasaDesde: '18.5% TEA',
            montoMax: 'S/ 100,000',
            color: AppColors.amarilloMostaza,
          ),

          // Tarjeta: Crédito Hipotecario
          _buildCreditOption(
            context,
            icon: Icons.home_outlined,
            title: 'Crédito Hipotecario',
            description: 'Adquiere la casa o departamento de tus sueños.',
            tasaDesde: '8.9% TEA',
            montoMax: 'S/ 500,000',
            color: AppColors.verdeCesped,
          ),

          // Tarjeta: Crédito Vehicular
          _buildCreditOption(
            context,
            icon: Icons.directions_car_outlined,
            title: 'Crédito Vehicular',
            description: 'Financia tu auto nuevo o seminuevo con las mejores tasas.',
            tasaDesde: '12.0% TEA',
            montoMax: 'S/ 120,000',
            color: AppColors.naranjaOcre,
          ),

          const SizedBox(height: 24),

          // Simulador de crédito
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.azulMarino, Color(0xFF003b80)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.calculate_outlined, color: AppColors.amarilloMostaza, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Simulador de Crédito',
                        style: TextStyle(
                          color: AppColors.blancoPuro,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Calcula tus cuotas mensuales antes de solicitar tu crédito.',
                    style: TextStyle(
                      color: AppColors.blancoPuro.withValues(alpha: 0.8),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.azulMarino,
                            content: Text('Simulador de crédito disponible próximamente.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amarilloMostaza,
                        foregroundColor: AppColors.azulMarino,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Simular Crédito',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCreditOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String tasaDesde,
    required String montoMax,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      elevation: 2,
      shadowColor: AppColors.azulMarino.withValues(alpha: 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.azulMarino,
              content: Text('Solicitud de "$title" disponible próximamente.'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulMarino,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textoGris,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildTag('Desde $tasaDesde', color),
                        const SizedBox(width: 8),
                        _buildTag('Hasta $montoMax', AppColors.azulMarino),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textoGris),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

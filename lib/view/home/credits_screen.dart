import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../../viewmodel/viewmodel_provider.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ViewModelProvider.of<HomeViewModel>(context);
    final authViewModel = ViewModelProvider.of<AuthViewModel>(context);
    final clientName = authViewModel.user?.fullName ?? 'Aldo Alexandre Requena Lavi';
    final credit = homeViewModel.creditProduct;
    final pendingRequests = homeViewModel.pendingRequests;

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

          // Lógica de Crédito Activo
          if (credit != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.azulMarino, Color(0xFF1E3A8A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.azulMarino.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          credit.productName,
                          style: const TextStyle(
                            color: AppColors.amarilloMostaza,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.credit_score, color: AppColors.blancoPuro),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'N° de Contrato: ${credit.contractNumber}',
                      style: TextStyle(
                        color: AppColors.blancoPuro.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                    const Divider(color: AppColors.blancoPuro, height: 24, thickness: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deuda Total',
                              style: TextStyle(
                                color: AppColors.blancoPuro.withValues(alpha: 0.7),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${credit.currency} ${credit.totalDebt.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.blancoPuro,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Próxima Cuota',
                              style: TextStyle(
                                color: AppColors.blancoPuro.withValues(alpha: 0.7),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${credit.currency} ${credit.pendingInstallment.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.blancoPuro,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fecha de Vencimiento: ${credit.dueDate}',
                      style: const TextStyle(
                        color: AppColors.amarilloMostaza,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
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

          // Lógica de Solicitudes Pendientes / En Curso
          if (pendingRequests.isNotEmpty) ...[
            const SizedBox(height: 28),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Solicitudes en Proceso',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...pendingRequests.map((req) {
              final String id = req['id'] ?? '';
              final String type = req['credit_type'] ?? 'Crédito';
              final double amount = (req['amount'] as num?)?.toDouble() ?? 0.0;
              final int term = req['term_months'] ?? 12;
              final String status = req['status'] ?? 'Pendiente';

              Color statusColor = AppColors.amarilloMostaza;
              if (status == 'Aprobado') statusColor = AppColors.verdeCesped;
              if (status == 'Rechazado') statusColor = AppColors.rojoCoral;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.azulMarino,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Monto Solicitado', style: TextStyle(color: AppColors.textoGris, fontSize: 12)),
                              const SizedBox(height: 2),
                              Text('S/ ${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Plazo', style: TextStyle(color: AppColors.textoGris, fontSize: 12)),
                              const SizedBox(height: 2),
                              Text('$term meses', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      if (status == 'Pendiente') ...[
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => homeViewModel.cancelarSolicitud(id),
                              icon: const Icon(Icons.cancel_outlined, size: 16, color: AppColors.rojoCoral),
                              label: const Text(
                                'Cancelar Solicitud',
                                style: TextStyle(color: AppColors.rojoCoral, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],

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

          // Opciones de Crédito
          _buildCreditOption(
            context,
            homeViewModel,
            clientName,
            icon: Icons.person_outline,
            title: 'Crédito Personal',
            description: 'Para cubrir gastos personales, viajes, educación y más.',
            tasaDesde: '14.5% TEA',
            maxAmount: 10000.0,
            color: AppColors.turquesaBrillante,
          ),

          _buildCreditOption(
            context,
            homeViewModel,
            clientName,
            icon: Icons.store_outlined,
            title: 'Crédito MYPE Emprendedor',
            description: 'Capital de trabajo o activos fijos para tu negocio.',
            tasaDesde: '18.5% TEA',
            maxAmount: 100000.0,
            color: AppColors.amarilloMostaza,
          ),

          _buildCreditOption(
            context,
            homeViewModel,
            clientName,
            icon: Icons.home_outlined,
            title: 'Crédito Hipotecario',
            description: 'Adquiere la casa o departamento de tus sueños.',
            tasaDesde: '8.9% TEA',
            maxAmount: 500000.0,
            color: AppColors.verdeCesped,
          ),

          _buildCreditOption(
            context,
            homeViewModel,
            clientName,
            icon: Icons.directions_car_outlined,
            title: 'Crédito Vehicular',
            description: 'Financia tu auto nuevo o seminuevo con las mejores tasas.',
            tasaDesde: '12.0% TEA',
            maxAmount: 120000.0,
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

  void _showRequestDialog(
    BuildContext context,
    HomeViewModel homeViewModel,
    String clientName,
    String creditType,
    double maxAmount,
  ) {
    final authViewModel = ViewModelProvider.of<AuthViewModel>(context);
    final formKey = GlobalKey<FormState>();
    final amountController = TextEditingController();
    final dniController = TextEditingController();
    final passwordController = TextEditingController();

    final double minAmount;
    final List<int> termOptions;
    final int defaultTerm;

    if (creditType.contains('Personal')) {
      minAmount = 500.0;
      termOptions = [6, 12, 18, 24];
      defaultTerm = 12;
    } else if (creditType.contains('MYPE')) {
      minAmount = 1000.0;
      termOptions = [12, 24, 36, 48, 60];
      defaultTerm = 24;
    } else if (creditType.contains('Hipotecario')) {
      minAmount = 20000.0;
      termOptions = [60, 120, 180, 240];
      defaultTerm = 120;
    } else if (creditType.contains('Vehicular')) {
      minAmount = 5000.0;
      termOptions = [12, 24, 36, 48, 60, 72];
      defaultTerm = 36;
    } else {
      minAmount = 500.0;
      termOptions = [6, 12, 24, 36];
      defaultTerm = 12;
    }

    int selectedTerm = defaultTerm;
    String? authError;
    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Solicitar $creditType',
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.azulMarino, fontSize: 18),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rango: S/ ${minAmount.toStringAsFixed(0)} - S/ ${maxAmount.toStringAsFixed(0)}',
                        style: const TextStyle(color: AppColors.textoGris, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Monto a solicitar (S/)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.monetization_on_outlined, color: AppColors.azulMarino),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un monto.';
                          }
                          final amount = double.tryParse(value);
                          if (amount == null) {
                            return 'Ingrese un número válido.';
                          }
                          if (amount < minAmount) {
                            return 'El monto mínimo es S/ ${minAmount.toStringAsFixed(0)}.';
                          }
                          if (amount > maxAmount) {
                            return 'El monto excede el límite permitido.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        initialValue: selectedTerm,
                        decoration: InputDecoration(
                          labelText: 'Plazo de pago',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.calendar_month, color: AppColors.azulMarino),
                        ),
                        items: termOptions.map((term) {
                          final years = term ~/ 12;
                          final label = term >= 12
                              ? '$term meses ($years ${years == 1 ? "año" : "años"})'
                              : '$term meses';
                          return DropdownMenuItem<int>(
                            value: term,
                            child: Text(label),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedTerm = val;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Icon(Icons.security, color: AppColors.amarilloMostaza, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Confirmación de Seguridad',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.azulMarino,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ingrese su DNI y contraseña del aplicativo para confirmar.',
                        style: TextStyle(fontSize: 11, color: AppColors.textoGris),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: dniController,
                        keyboardType: TextInputType.number,
                        maxLength: 8,
                        decoration: InputDecoration(
                          labelText: 'DNI de confirmación',
                          counterText: '',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.azulMarino),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su DNI.';
                          }
                          if (value.length != 8 || double.tryParse(value) == null) {
                            return 'El DNI debe tener 8 dígitos.';
                          }
                          if (value != authViewModel.user?.dni) {
                            return 'El DNI no coincide con su usuario.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña de la App',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.azulMarino),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.azulMarino,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su contraseña.';
                          }
                          return null;
                        },
                      ),
                      if (authError != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.rojoCoral.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.rojoCoral.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            authError!,
                            style: const TextStyle(
                              color: AppColors.rojoCoral,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar', style: TextStyle(color: AppColors.textoGris, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      authError = null;
                    });

                    if (formKey.currentState!.validate()) {
                      final double amount = double.parse(amountController.text);
                      final dni = dniController.text.trim();
                      final password = passwordController.text;

                      if (!authViewModel.validateCredentials(dni, password)) {
                        setState(() {
                          authError = 'DNI o contraseña del aplicativo incorrectos.';
                        });
                        return;
                      }

                      Navigator.of(context).pop();

                      final expedienteId = await homeViewModel.solicitarCredito(
                        clientName: clientName,
                        creditType: creditType,
                        amount: amount,
                        termMonths: selectedTerm,
                      );

                      if (expedienteId != null && context.mounted) {
                        _showSuccessDialog(context, expedienteId);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.azulMarino,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Solicitar', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String expedienteId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: const Color(0xFFF9FAFB),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.verdeCesped,
                    size: 26,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Solicitud Enviada',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.azulMarino,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Su solicitud ha sido registrada correctamente.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textoGris,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Número de Expediente:',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textoGris,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                expedienteId,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulMarino,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Un asesor de negocios se pondrá en contacto pronto para realizar la visita en campo.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textoGris,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'ENTENDIDO',
                    style: TextStyle(
                      color: AppColors.azulMarino,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCreditOption(
    BuildContext context,
    HomeViewModel homeViewModel,
    String clientName, {
    required IconData icon,
    required String title,
    required String description,
    required String tasaDesde,
    required double maxAmount,
    required Color color,
  }) {
    final String formattedMax = 'S/ ${maxAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      elevation: 2,
      shadowColor: AppColors.azulMarino.withValues(alpha: 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showRequestDialog(context, homeViewModel, clientName, title, maxAmount),
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
                        _buildTag('Hasta $formattedMax', AppColors.azulMarino),
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

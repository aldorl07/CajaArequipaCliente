import 'package:flutter/material.dart';
import '../../ui/theme/app_colors.dart';

class CajaArequipaLogo extends StatelessWidget {
  final double size;

  const CajaArequipaLogo({super.key, this.size = 120.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CajaArequipaPainter(),
      ),
    );
  }
}

class _CajaArequipaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 1. Dibujar el fondo: un círculo suave color azul marino corporativo
    final paintFondo = Paint()
      ..color = AppColors.azulMarino
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        Radius.circular(w * 0.28),
      ),
      paintFondo,
    );

    // 2. Dibujar el isotipo (los 5 trazos de colores institucionales en la base)
    final List<Color> coloresIsotipo = [
      AppColors.rojoCoral,
      AppColors.naranjaOcre,
      AppColors.amarilloMostaza,
      AppColors.verdeCesped,
      AppColors.turquesaOscuro,
    ];

    final double cx = w * 0.5;
    final double cy = h * 0.55;

    for (int i = 0; i < coloresIsotipo.length; i++) {
      // Trazar pétalos circulares sobrepuestos y estilizados que representan el isologo de Caja Arequipa
      final double dx = cx + (w * 0.16) * (i - 2) * 0.65;
      final double dy = cy - (h * 0.18) - (i == 2 ? h * 0.05 : 0);
      
      canvas.drawCircle(
        Offset(dx, dy),
        w * 0.1,
        Paint()
          ..color = coloresIsotipo[i].withValues(alpha: 0.9)
          ..style = PaintingStyle.fill,
      );
    }

    // 3. Dibujar la letra "a" estilizada en blanco al centro
    final paintA = Paint()
      ..color = AppColors.blancoPuro
      ..style = PaintingStyle.fill;

    // Cuerpo de la 'a' (óvalo/círculo central)
    canvas.drawCircle(
      Offset(cx, cy + (h * 0.1)),
      w * 0.16,
      paintA,
    );
    // Agujero interno de la 'a' (para que parezca un aro)
    final paintHueco = Paint()
      ..color = AppColors.azulMarino
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(cx, cy + (h * 0.1)),
      w * 0.09,
      paintHueco,
    );

    // Tallo vertical derecho de la 'a'
    final rectTallo = Rect.fromLTWH(
      cx + (w * 0.11), 
      cy - (h * 0.06), 
      w * 0.07, 
      h * 0.28,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rectTallo, Radius.circular(w * 0.035)),
      paintA,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

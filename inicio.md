# Prompt para el Desarrollo del Aplicativo Móvil de Caja Arequipa (Home Banking)

## Objetivo del Prompt
Actúa como un **ingeniero de prompts** especializado en desarrollo de software. Tu tarea es generar un conjunto de instrucciones detalladas y estructuradas que permitan a un equipo de desarrollo (o a un asistente de IA) construir la primera versión de un aplicativo móvil de home banking para **Caja Arequipa**, utilizando **Flutter** y **Firebase**. El prompt debe ser claro, accionable y escalable, permitiendo añadir funcionalidades en el futuro.

---

## 1. Contexto del Proyecto
**Caja Arequipa** es una entidad financiera peruana que busca ofrecer a sus clientes una experiencia digital moderna, segura y confiable. El aplicativo móvil será el canal principal para que los clientes gestionen sus finanzas desde sus dispositivos.

**Alcance Inicial (MVP)**:
- Registro e inicio de sesión de usuarios (clientes existentes y nuevos).
- Dashboard con saldo consolidado y últimos movimientos.
- Módulo de ahorros (consultar saldo, realizar depósitos simulados, ver estado de cuenta).
- Módulo de créditos (visualizar préstamos activos y cronograma de pagos).
- Transferencias y pagos (entre cuentas propias y a terceros).
- Perfil de usuario (datos personales, configuración de seguridad).

**Futuras expansiones** (no incluidas en este prompt, pero se deben considerar en la arquitectura):
- Notificaciones push, biometría, escaneo de cheques, chat con asesor, etc.

---

## 2. Identidad Visual y Branding
La aplicación debe reflejar la identidad de Caja Arequipa utilizando la siguiente paleta de colores y elementos:

| Uso | Color | Hex |
|-----|-------|-----|
| Color principal (texto y fondo web) | Azul Marino Corporativo | `#002454` |
| Color de acento digital y botones | Turquesa Brillante | `#00C4D3` |
| Pestañas activas y resaltados | Amarillo/Mostaza | `#FF9E1B` |
| Isotipo (Verde Césped) | Verde Césped | `#1FA02F` |
| Isotipo (Turquesa Oscuro/Azul Claro) | Turquesa Oscuro | `#008EA7` |
| Isotipo (Naranja/Ocre) | Naranja/Ocre | `#C67A43` |
| Isotipo (Verde Oliva/Seco) | Verde Oliva | `#7B8C47` |
| Isotipo (Rojo Coral/Carmín) | Rojo Coral | `#D93D41` |
| Fondo de interfaz | Gris Claro | `#F0F4F8` |
| Fondos de tarjetas y textos claros | Blanco Puro | `#FFFFFF` |

**Lineamientos**:
- Utilizar el logo oficial de Caja Arequipa (proporcionado por el cliente) en la pantalla de inicio y en el header.
- Tipografía: usar una fuente sans-serif legible (ej. **Roboto** o **Inter**).
- Los botones primarios deben usar `#00C4D3` con texto blanco. Los botones secundarios pueden ser outline con borde `#002454`.
- Los elementos interactivos (tabs, switches) deben resaltar con `#FF9E1B` cuando estén activos.

---

## 3. Requerimientos Funcionales Detallados

### 3.1. Autenticación
- **Registro**: 
  - Permitir registro con correo electrónico y contraseña (Firebase Auth).
  - Solicitar datos básicos: nombre completo, DNI (documento de identidad peruano), fecha de nacimiento, teléfono.
  - Validar DNI (formato de 8 dígitos) y correo electrónico.
  - Enviar correo de verificación.
- **Inicio de sesión**:
  - Login con email y contraseña.
  - Opción de "Recordarme" (mantener sesión).
  - Recuperación de contraseña (enlace de restablecimiento).
- **Seguridad**: 
  - Implementar Firebase Authentication con reglas de seguridad básicas.
  - Cerrar sesión desde el perfil.

### 3.2. Dashboard
- Mostrar **saldo total** de todas las cuentas (ahorros, corriente, etc.) en un card destacado.
- Lista de **últimos 10 movimientos** con fecha, descripción, monto (positivo/negativo) y saldo después del movimiento.
- Acceso rápido a las funcionalidades principales: "Transferir", "Pagar", "Ver Ahorros", "Mis Créditos".
- El dashboard debe refrescarse al entrar (pull-to-refresh) y cada cierto tiempo (ej. 30 seg).

### 3.3. Módulo Ahorros
- Mostrar lista de cuentas de ahorro (al menos una por defecto).
- Al seleccionar una cuenta: mostrar **saldo disponible**, **número de cuenta**, y un gráfico simple de evolución (opcional).
- Botón **"Depositar"**: simulación de depósito (no integración real con pasarela de pago en MVP; solo registrar un depósito en la base de datos con monto y fecha).
- Botón **"Estado de Cuenta"**: mostrar un historial de movimientos de esa cuenta (filtrados por fecha, con opción de rango).
- Posibilidad de exportar estado de cuenta como PDF (generar con librería, ej. pdf).

### 3.4. Módulo Créditos
- Listar todos los préstamos activos (número de préstamo, monto original, saldo pendiente, tasa de interés, cuota mensual).
- Al seleccionar un préstamo: mostrar **cronograma de pagos** (fechas de vencimiento, monto de cuota, estado: pagado/pendiente).
- Indicar la próxima cuota a pagar con fecha y monto.
- Opción de **"Pagar cuota"** (simulado: registrar pago en Firebase).

### 3.5. Transferencias y Pagos
- **Transferencias entre cuentas propias**: seleccionar cuenta origen y destino, ingresar monto, concepto (opcional), confirmar.
- **Transferencias a terceros**: 
  - Registrar destinatario (nombre, número de cuenta, banco, tipo de documento).
  - Realizar transferencia con confirmación.
- **Pago de servicios**: 
  - Lista de servicios predefinidos (luz, agua, internet, teléfono, etc.).
  - Ingresar código de cliente y monto; confirmar pago.
- Todas las operaciones deben registrar un movimiento en la base de datos y actualizar saldos.

### 3.6. Perfil de Usuario
- Mostrar foto de perfil (subida desde galería o cámara, almacenar en Firebase Storage).
- Datos personales: nombre, DNI, correo, teléfono, dirección (editable).
- Configuración de seguridad: cambio de contraseña, habilitar/deshabilitar biometría (preparar para futuro).
- Historial de sesiones activas (opcional).
- Cerrar sesión y eliminar cuenta (con confirmación).

---

## 4. Requerimientos No Funcionales
- **Rendimiento**: Tiempo de carga de pantallas < 2 segundos en conexión 4G.
- **Seguridad**: 
  - Todas las comunicaciones con Firebase deben ser encriptadas (HTTPS).
  - Reglas de Firestore restrictivas: solo lectura/escritura para usuarios autenticados y solo a sus propios datos.
  - No almacenar información sensible en el dispositivo (preferir Firebase Auth).
- **Usabilidad**: 
  - Diseño responsive para diferentes tamaños de pantalla (teléfonos y tablets).
  - Mensajes de error claros y amigables.
  - Indicadores de carga (spinners) en operaciones asíncronas.
- **Escalabilidad**: 
  - Estructura modular para agregar nuevos módulos sin afectar los existentes.
  - Uso de patrones de diseño (ej. Repository, BLoC o Riverpod para gestión de estado).
- **Compatibilidad**: iOS 12+ y Android 6+ (API 23+).

---

## 5. Stack Tecnológico
- **Frontend**: **Flutter** (versión estable 3.x) con Dart.
  - Gestión de estado: **Riverpod** o **Provider** (elegir uno consistente).
  - Navegación: **GoRouter** o **AutoRoute** para rutas declarativas.
  - Almacenamiento local: **SharedPreferences** para configuraciones ligeras, **Hive** para caché offline (opcional).
  - Peticiones HTTP: **Dio** para futuras integraciones con APIs externas (si Firebase no cubre todo).
- **Backend y servicios**: **Firebase**.
  - **Firebase Authentication**: registro, login, recuperación, verificación.
  - **Cloud Firestore**: base de datos NoSQL para usuarios, cuentas, movimientos, préstamos, transferencias, pagos.
  - **Firebase Storage**: almacenamiento de fotos de perfil.
  - **Firebase Cloud Functions** (opcional para MVP, pero recomendado para lógica de negocio compleja como actualización de saldos).
- **Herramientas**: 
  - **Firebase CLI** para despliegue de reglas, funciones y configuración del proyecto.
  - **FlutterFire CLI** para configurar Firebase en el proyecto Flutter.
- **Pruebas**: 
  - Unit tests con `test` y widget tests con `flutter_test`.
  - Firebase Emulator Suite para pruebas locales.

---

## 6. Estructura de Datos en Firestore (Propuesta Inicial)
```plaintext
users/{userId}:
  - nombre: string
  - dni: string
  - email: string
  - telefono: string
  - fechaNacimiento: timestamp
  - fotoUrl: string (Storage URL)
  - cuentas: [ referencia a cuentas ]

accounts/{accountId}:
  - tipo: "ahorro" | "corriente" | "credito"
  - numero: string
  - saldo: number
  - moneda: "PEN"
  - titular: referencia a user
  - fechaApertura: timestamp

movements/{movementId}:
  - accountId: referencia
  - tipo: "deposito" | "retiro" | "transferencia" | "pago" | "interes"
  - monto: number
  - descripcion: string
  - fecha: timestamp
  - saldoPosterior: number
  - destinatario (si aplica): { nombre, cuenta, banco }

loans/{loanId}:
  - userId: referencia
  - numero: string
  - montoOriginal: number
  - saldoPendiente: number
  - tasaInteres: number
  - cuotaMensual: number
  - fechaInicio: timestamp
  - plazoMeses: int
  - cronograma: [ { fechaVencimiento, montoCuota, estado: "pendiente"|"pagado" } ]

transfers/{transferId}:
  - origen: referencia a account
  - destino: { tipo: "propia"|"tercero", cuenta: string, banco: string, nombre: string }
  - monto: number
  - concepto: string
  - fecha: timestamp
  - estado: "completado" | "fallido"

bills/{billId}:
  - userId: referencia
  - servicio: string
  - codigoCliente: string
  - monto: number
  - fechaPago: timestamp
  - estado: "pagado" | "pendiente"
```

---

## 7. Configuración del Proyecto con Firebase CLI
1. Crear proyecto en Firebase Console.
2. Habilitar Authentication (email/password).
3. Configurar Firestore en modo nativo.
4. Instalar Firebase CLI y FlutterFire CLI.
5. Ejecutar `flutterfire configure` para vincular el proyecto Flutter.
6. Configurar reglas de seguridad:
   - Autenticación requerida.
   - Solo lectura/escritura de documentos donde el `userId` coincida con `request.auth.uid`.
7. Desplegar reglas con `firebase deploy --only firestore:rules`.
8. Configurar Storage y sus reglas (solo archivos de perfil, permitir subida solo para el usuario autenticado).

---

## 8. Flujo de Desarrollo Sugerido
1. **Configuración inicial**: proyecto Flutter, Firebase, dependencias.
2. **Capa de datos**: modelos, repositorios y servicios (Firebase).
3. **Autenticación**: pantallas de login/registro, gestión de sesión.
4. **Dashboard**: vista principal, obtención de saldos y movimientos.
5. **Módulo de ahorros**: listado y detalle.
6. **Módulo de créditos**: listado y cronograma.
7. **Transferencias y pagos**: flujo completo.
8. **Perfil**: datos y configuración.
9. **Pruebas**, refinamiento de UI/UX y despliegue.

---

## 9. Entregables Esperados
- Código fuente completo en un repositorio (Git) con commits claros.
- Documentación básica: README con instrucciones de instalación y ejecución (usando Firebase Emulator o proyecto real).
- Archivo `firebase.json` y reglas de Firestore/Storage.
- APK (para Android) y IPA (para iOS) generados en modo release.
- Un video demo (máx 3 minutos) mostrando el flujo completo.

---

## 10. Consideraciones Adicionales para el Equipo de Desarrollo
- Utilizar el **patrón de diseño BLoC** o **Riverpod** para separar lógica de UI, facilitando pruebas y mantenimiento.
- Manejar errores de conexión y mostrar mensajes intuitivos.
- Implementar **internacionalización** básica (español por defecto).
- Asegurar que los **números** y **fechas** se formateen según la región peruana.
- Incluir **logs** y **analytics** (Firebase Analytics) para tracking de uso (opcional).
- Preparar la app para **modo oscuro** (futuro), aunque no se requiera ahora, usar tema adaptable.

---

## 11. Instrucciones para el Asistente de IA (si se usa)
- Genera el código siguiendo las mejores prácticas de Flutter y Firebase.
- Proporciona explicaciones detalladas de cada parte del código.
- Sugiere mejoras y alternativas cuando sea apropiado.
- Asegura que el código sea limpio, comentado y bien estructurado.
- Al finalizar cada módulo, compila y prueba la app (simulada) y reporta cualquier error.

---

## 12. Notas Finales
- Este prompt es la base del proyecto. A medida que avance, se irán agregando nuevos requerimientos (notificaciones, biometría, integración con APIs bancarias, etc.). Por ello, la arquitectura debe ser flexible y modular.
- La seguridad es primordial: nunca exponer claves API ni información sensible en el código fuente.
- El equipo debe coordinar con el área de diseño de Caja Arequipa para obtener los assets (logo, iconos) y validar la UI final.

---

**Fin del Prompt**
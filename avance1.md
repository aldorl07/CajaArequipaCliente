# Reporte de Avance 1: Implementación de Historias de Usuario (S9)
## App Cliente — Caja Arequipa

Este documento detalla la especificación técnica, el diseño visual y la implementación de código correspondiente a las dos primeras historias de usuario obligatorias del entregable S9.

---

## HU-C01 — Login

> **Como** cliente registrado  
> **Quiero** ingresar con mi usuario y contraseña  
> **Para** acceder a mis cuentas de forma segura  

### 1. Criterios de Aceptación Cumplidos
- **Campos de entrada**: Implementación de DNI (limitado a 8 caracteres numéricos mediante `FilteringTextInputFormatter.digitsOnly`) y contraseña (con visibilidad alternable dinámicamente).
- **Logotipo y Nombre**: Visualización del nombre de la entidad "Caja Arequipa" y su logotipo oficial vectorizado en alta resolución mediante [caja_arequipa_logo.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/view/widgets/caja_arequipa_logo.dart).
- **Colores y Branding**: Uso exclusivo de los colores institucionales (Fondo superior en Azul Marino `#002454`, botón en Turquesa `#00C4D3`, bordes en gris claro).
- **Navegación al Dashboard**: El botón de ingreso realiza validación local y, tras un retardo simulado de red, navega hacia el Dashboard limpiando el histórico de rutas.
- **Credenciales en ViewModel**: Validación controlada en el ViewModel. Credenciales válidas: DNI `12345678` y Clave `123456`.

### 2. Estructura de Clases e Implementación
- **Vista**: [login_screen.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/view/auth/login_screen.dart)
- **ViewModel**: [auth_viewmodel.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/viewmodel/auth_viewmodel.dart)
  - Administra el estado mediante un enum `AuthState` con valores: `initial`, `loading`, `success`, `error`.
  - Notifica a la vista usando `notifyListeners()` nativo de Flutter.

```dart
// Fragmento de validación en AuthViewModel
Future<bool> login(String dni, String password) async {
  _state = AuthState.loading;
  _errorMessage = null;
  notifyListeners();

  await Future.delayed(const Duration(milliseconds: 1500)); // Simulación de Red

  if (dni == '12345678' && password == '123456') {
    _user = UserModel(
      dni: '12345678',
      fullName: 'Aldo Rojas',
      email: 'aldo.rojas@cajaarequipa.pe',
      token: 'mock_jwt_token',
    );
    _state = AuthState.success;
    notifyListeners();
    return true;
  } else {
    _state = AuthState.error;
    _errorMessage = 'DNI o contraseña incorrectos. Intente de nuevo.';
    notifyListeners();
    return false;
  }
}
```

---

## HU-C02 — Dashboard Principal

> **Como** cliente autenticado  
> **Quiero** ver un resumen de mis productos financieros  
> **Para** tener una visión rápida de mi situación financiera  

### 1. Criterios de Aceptación Cumplidos
- **Saludo Personalizado**: Cabecera dinámica que muestra el nombre del cliente recuperado desde el [user_model.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/model/user_model.dart) posterior al login exitoso (ej. *"Hola, Aldo Rojas"*).
- **Tarjeta de Ahorros**: Muestra el número de cuenta (`191-482910-0-28`), código CCI y saldo disponible formateado en soles (`S/ 4,850.75`).
- **Tarjeta de Crédito Activo**: Muestra el nombre del producto ("Crédito MYPE Emprendedor"), contrato, cuota pendiente de pago (`S/ 520.40`) y fecha de vencimiento (`10 de Julio, 2026`).
- **Barra de Navegación Inferior**: 4 pestañas visibles: Inicio, Cuentas, Créditos y Perfil. En cumplimiento de la rúbrica S9, las pestañas inactivas muestran un mensaje informando que están temporalmente deshabilitadas.
- **Cierre de Sesión**: Botón en la AppBar superior derecha. Al presionarlo, solicita confirmación mediante un diálogo nativo, limpia la sesión del `AuthViewModel` y redirige al Login.

### 2. Estructura de Clases e Implementación
- **Vista**: [dashboard_screen.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/view/home/dashboard_screen.dart)
- **ViewModel**: [home_viewmodel.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/viewmodel/home_viewmodel.dart)
  - Expone datos estructurados a través de clases en [product_model.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/model/product_model.dart).
  - Incluye un método `fetchDashboardData` que simula la latencia de carga remota.

```dart
// Fragmento de carga en HomeViewModel
Future<void> fetchDashboardData() async {
  _isLoading = true;
  notifyListeners();

  await Future.delayed(const Duration(milliseconds: 1000)); // Carga asíncrona

  _savingsAccount = SavingsAccount(
    accountNumber: '191-482910-0-28',
    cci: '002-191-00482910028-54',
    balance: 4850.75,
  );

  _creditProduct = CreditProduct(
    productName: 'Crédito MYPE Emprendedor',
    contractNumber: 'CRE-2026-9081',
    totalDebt: 12500.00,
    pendingInstallment: 520.40,
    dueDate: '10 de Julio, 2026',
  );

  _isLoading = false;
  notifyListeners();
}
```

---

## 3. Estado de la Integración de Datos
- **Fase Actual (S9)**: Los datos se generan en el constructor de los ViewModels como datos hardcodeados/mock. No hay conexión HTTP activa a servicios externos.
- **Preparación de Base de Datos**: Se ha creado un proyecto de Firebase con ID `caja-arequipa-cliente-aldor` en Google Cloud y se han estructurado localmente los archivos de reglas y mapeo de Firestore para su consumo inmediato en la entrega S10.
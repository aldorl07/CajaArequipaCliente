# Documentación de Inicio - App Cliente (Caja Arequipa)
## Primer Avance de Aplicaciones Móviles (Entrega S9)

Este archivo sirve como punto de partida y documentación oficial de la aplicación de Banca Móvil (**App Cliente**) para **Caja Arequipa**, desarrollada con el framework Flutter siguiendo de manera estricta la arquitectura **MVVM (Model-View-ViewModel)** y la paleta de colores y branding institucional especificado.

---

## 1. Arquitectura del Proyecto (MVVM)

La aplicación implementa el patrón de diseño de arquitectura **MVVM**, separando las responsabilidades de la siguiente manera:
1. **Model (Modelos de datos)**: Clases puras de Dart que representan las estructuras de datos de negocio sin lógica de presentación.
2. **View (Vistas)**: Widgets de Flutter encargados exclusivamente de pintar la UI en base al estado expuesto por los ViewModels.
3. **ViewModel (Modelos de Vista)**: Clases que heredan de `ChangeNotifier`, contienen la lógica de presentación y el estado. Se comunican con la vista reactivamente.

### Inyección de Dependencias Nativa
Para enlazar las Vistas con los ViewModels de forma eficiente sin instalar paquetes externos de terceros, se ha implementado un gestor de estado basado en la clase nativa `InheritedNotifier`. Esto asegura que los widgets se reconstruyan automáticamente sólo cuando el ViewModel notifica cambios:
- Ver implementación en [viewmodel_provider.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/viewmodel/viewmodel_provider.dart).

---

## 2. Estructura de Carpetas

A continuación se detalla la estructura física del proyecto en la carpeta `lib/` de acuerdo con la rúbrica del curso:

```text
lib/
├── model/              # Clases de datos puros
│   ├── product_model.dart
│   └── user_model.dart
├── viewmodel/          # Gestión de estado y lógica de presentación
│   ├── auth_viewmodel.dart
│   ├── home_viewmodel.dart
│   └── viewmodel_provider.dart
├── view/               # Pantallas e interfaces gráficas
│   ├── auth/
│   │   └── login_screen.dart
│   ├── home/
│   │   └── dashboard_screen.dart
│   └── widgets/
│       └── caja_arequipa_logo.dart
├── navigation/         # Grafo y transiciones de navegación
│   └── app_navigation.dart
├── ui/theme/           # Definiciones visuales y de estilo
│   ├── app_colors.dart
│   └── app_theme.dart
└── main.dart           # Punto de entrada de la aplicación
```

---

## 3. Detalle de Archivos Implementados

### A. Capa de Modelos (Model)
- [user_model.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/model/user_model.dart): Modela las propiedades básicas del usuario autenticado (`dni`, `fullName`, `email`, `token`).
- [product_model.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/model/product_model.dart): Modela las clases para las cuentas de ahorro (`SavingsAccount`), créditos (`CreditProduct`) y los movimientos bancarios (`BankTransaction`).

### B. Capa de ViewModels (ViewModel)
- [auth_viewmodel.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/viewmodel/auth_viewmodel.dart): Expone estados de inicio de sesión (`initial`, `loading`, `success`, `error`). Posee las credenciales de simulación hardcodeadas requeridas por la rúbrica:
  - **DNI válido**: `12345678`
  - **Clave válida**: `123456`
- [home_viewmodel.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/viewmodel/home_viewmodel.dart): Administra y expone los datos ficticios pero realistas de Caja Arequipa (Cuentas de ahorros con saldo, crédito activo del oficial y la lista de transacciones recientes).

### C. Capa de Vistas (View)
- [login_screen.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/view/auth/login_screen.dart): Interfaz de Login premium. Cuenta con campos para DNI y Clave de internet, validaciones visuales instantáneas en formulario, efectos de carga reactivos vinculados al `AuthViewModel` y manejo de avisos de error.
- [dashboard_screen.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/view/home/dashboard_screen.dart): Panel principal de la cuenta del cliente. Saluda formalmente al usuario utilizando el nombre proveniente de la autenticación. Muestra el saldo disponible de ahorros, la cuota pendiente del crédito activo y una lista detallada de movimientos. Adicionalmente, incluye la barra inferior (BottomNavigationBar) donde las pestañas no principales informan sobre su deshabilitación parcial según la directiva S9, y un botón de cierre de sesión seguro.
- [caja_arequipa_logo.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/view/widgets/caja_arequipa_logo.dart): Isologo institucional vectorizado dinámicamente usando `CustomPainter`. Muestra la letra "a" en blanco estilizado y las pinceladas multicolores de Caja Arequipa sin necesidad de cargar assets pesados, garantizando una visualización nítida a cualquier escala.

### D. Navegación (Navigation)
- [app_navigation.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/navigation/app_navigation.dart): Centraliza el mapa de rutas (`/login` y `/dashboard`). Implementa una transición deslizante vertical premium para emular el comportamiento de las aplicaciones de banca móvil nativas al abrir el panel de control.

### E. Diseño Visual y Temas (Theme)
- [app_colors.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/ui/theme/app_colors.dart): Almacena las variables constantes del branding asignado para Caja Arequipa:
  - **Color Principal**: Azul Marino Corporativo (`#002454`)
  - **Acento y Botones**: Turquesa Brillante (`#00C4D3`)
  - **Pestañas Activas y Resaltado**: Amarillo/Mostaza (`#FF9E1B`)
  - **Isotipo (Paleta Multicolor)**: Verde Césped (`#1FA02F`), Turquesa Oscuro (`#008EA7`), Naranja/Ocre (`#C67A43`), Verde Oliva (`#7B8C47`), Rojo Coral (`#D93D41`)
  - **Fondo de Interfaz**: Gris Claro (`#F0F4F8`)
  - **Fondo de Tarjetas**: Blanco Puro (`#FFFFFF`)
- [app_theme.dart](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/lib/ui/theme/app_theme.dart): Configura el `ThemeData` del sistema aplicando los colores en botones, tarjetas (`CardThemeData`), barra de navegación superior, inputs de texto redondeados y tipografía general.

---

## 4. Instrucciones de Ejecución y Validación

Sigue los siguientes comandos en tu terminal para compilar o validar el proyecto:

1. **Obtener dependencias**:
   ```bash
   flutter pub get
   ```

2. **Analizar la calidad de código (Linter)**:
   ```bash
   flutter analyze
   ```
   *(Este comando debería completarse con "No issues found!", ya que el código ha sido limpiado de advertencias y tipos incorrectos).*

3. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```

---

## 5. Tabla de Cumplimiento (Evaluación S9)

| Criterio de Rúbrica | Estado | Implementación Técnica |
| :--- | :---: | :--- |
| **Estructura de carpetas MVVM** (4 pts) | **Listo** | Distribución física exacta en `lib/` con carpetas diferenciadas para `model/`, `viewmodel/`, `view/`, `navigation/` y `ui/theme/`. |
| **2 Pantallas navegables** (4 pts) | **Listo** | Pantallas funcionales `LoginScreen` y `DashboardScreen` con navegación fluida de ida y vuelta (Login $\rightarrow$ Dashboard $\rightarrow$ Login). |
| **ViewModel con datos hardcodeados** (4 pts) | **Listo** | `AuthViewModel` valida DNI (`12345678`) y clave (`123456`) y maneja estados. `HomeViewModel` expone saldos de ahorros y préstamos mockeados. |
| **Branding de la entidad** (4 pts) | **Listo** | Aplicación rigurosa de los colores corporativos oficiales en botones, textos y fondos. Logo institucional vectorizado dinámicamente con `CustomPainter`. |
| **Repositorio Git y Commits** (4 pts) | **Listo** | Historial de git local inicializado y commiteado ordenadamente para la entrega. |

---

## 6. Integración de Firebase y Base de Datos (Firestore)

Para habilitar la persistencia de datos en la entrega S10, hemos adelantado la configuración del backend utilizando la interfaz de comandos oficial (**Firebase CLI**).

### A. Proyecto Firebase Creado en la Nube
El proyecto ha sido registrado bajo el identificador único global:
- **Project ID**: `caja-arequipa-cliente-aldor`
- **Project Name**: `Caja Arequipa Cliente App`
- **Consola del Proyecto**: [Acceso a Firebase Console](https://console.firebase.google.com/project/caja-arequipa-cliente-aldor/overview)

### B. Archivos Locales de Firebase
Se han inicializado en la raíz del proyecto los siguientes archivos de configuración:
1. [.firebaserc](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/.firebaserc): Enlaza el repositorio local de desarrollo al proyecto `caja-arequipa-cliente-aldor` por defecto.
2. [firebase.json](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/firebase.json): Configura las rutas locales del módulo de base de datos Firestore.
3. [firestore.rules](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/firestore.rules): Define las reglas de seguridad. Se ha configurado en modo desarrollo (lecturas y escrituras permitidas sin autenticación) para facilitar las pruebas del avance.
4. [firestore.indexes.json](file:///D:/Desarrollo%20de%20aplicaciones%20m%C3%B3viles/app%20movil/App%20Cliente/firestore.indexes.json): Configura la lista de índices compuestos (inicializada vacía).

### C. Activación e Inicialización de Firestore
Por políticas de seguridad y cuotas de Google Cloud, antes de poder aprovisionar la base de datos Firestore en un proyecto nuevo, se debe habilitar su API.

1. **Habilitación de la API**:
   Haz clic en el siguiente enlace para activar la API en tu proyecto:
   - [Habilitar API de Cloud Firestore](https://console.developers.google.com/apis/api/firestore.googleapis.com/overview?project=caja-arequipa-cliente-aldor)

2. **Creación de la Base de Datos**:
   Una vez habilitada la API, puedes crear la base de datos ejecutando en tu terminal:
   ```bash
   firebase firestore:databases:create "(default)" --location nam5
   ```
   *(También puedes hacerlo directamente en la consola web haciendo clic en "Crear base de datos" en la pestaña Firestore de Firebase Console).*


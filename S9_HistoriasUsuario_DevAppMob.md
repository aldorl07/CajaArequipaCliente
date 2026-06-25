S9_HU_apps_moviles_1.md 

2026-05-14 

## S9 — Historias de Usuario: Primer Avance Apps Moviles 

**Curso:** Desarrollo de Aplicaciones Moviles | Ciclo 2026 **Entrega S9:** Arquitectura MVVM montada + 2 pantallas navegables| Flutter **Repos:** Dos repos separados — uno por app 

## Contexto general 

Tiene como banco seleccionado a Caja Arequipa (https://www.cajaarequipa.pe/). Debe crear dos aplicaciones independientes: 

- **App Clientes** — home banking para el cliente final 

- **App Fuerza de Ventas** — herramienta para el oficial de credito en campo 

En S9 el objetivo es tener la arquitectura MVVM correctamente estructurada y exactamente **2 pantallas** creadas, navegables y con datos hardcodeados en el ViewModel. Sin conexion a backend. 

## Nomenclatura de repos 

```
appbanco_[entidad]_cliente      <- App para clientes
appbanco_[entidad]_ventas       <- App para fuerza de ventas
```

Ejemplo para CMAC Cusco: 

```
appbanco_cmaccusco_cliente
appbanco_cmaccusco_ventas
```

## Estructura MVVM requerida (aplica a los tres stacks) 

```
app/
├── model/          <- Clases de datos
├── viewmodel/      <- Un ViewModel por pantalla
├── view/           <- Pantallas / Screens / Pages
│   ├── auth/
│   └── home/
├── navigation/     <- Grafo de navegacion
└── ui/theme/       <- Colores y tipografia de la entidad
```

APP 1 — Clientes (Home Banking) 

1 / 4 

S9_HU_apps_moviles_1.md 

2026-05-14 

## HU-C01 — Login 

**Como** cliente registrado **Quiero** ingresar con mi usuario y contrasena **Para** acceder a mis cuentas de forma segura 

## **Criterios de aceptacion:** 

- Campos: usuario/DNI y contrasena 

- Logo y nombre de la entidad financiera asignada visible 

- Colores y branding de la entidad (color primario, secundario) 

- Boton "Ingresar" navega al Dashboard (sin validacion real en S9) 

- Credenciales correctas hardcodeadas en el ViewModel 

**Pantalla:** `LoginScreen` **ViewModel:** `AuthViewModel` con estado `loading` , `success` , `error` 

## HU-C02 — Dashboard principal 

**Como** cliente autenticado **Quiero** ver un resumen de mis productos financieros **Para** tener una vision rapida de mi situacion financiera 

## **Criterios de aceptacion:** 

- Saludo con nombre del cliente (dato hardcodeado en ViewModel) 

- Tarjeta de saldo de cuenta de ahorros 

- Tarjeta de credito activo con monto pendiente 

- Barra de navegacion inferior con tabs visibles: Inicio, Cuentas, Creditos, Perfil (los tabs solo Inicio funciona en S9) 

- Boton o icono de cerrar sesion que regresa al Login 

**Pantalla:** `DashboardScreen` **ViewModel:** `HomeViewModel` con datos ficticios de cuenta y credito 

## APP 2 — Fuerza de Ventas (Oficial de Credito) 

## HU-V01 — Login del oficial 

**Como** oficial de credito **Quiero** autenticarme con mis credenciales institucionales **Para** acceder a mi cartera de forma segura 

## **Criterios de aceptacion:** 

Logo y nombre de la entidad con texto "Portal Oficial de Credito" 

- Campos: codigo de empleado y contrasena 

- Credenciales hardcodeadas en ViewModel navegan al home 

- Identidad visual diferenciada del app de clientes (mismo branding, distinto rol — por ejemplo fondo oscuro vs claro) 

**Pantalla:** `LoginOficialScreen` **ViewModel:** `AuthOficialViewModel` con estado `loading` , `success` , `error` 

HU-V02 — Cartera diaria 

2 / 4 

S9_HU_apps_moviles_1.md 

2026-05-14 

**Como** oficial de credito **Quiero** ver la lista de clientes asignados para el dia **Para** planificar mis visitas antes de salir a campo 

## **Criterios de aceptacion:** 

Lista de al menos 5 clientes hardcodeados en ViewModel 

- Cada item muestra: nombre del cliente, tipo de gestion (renovacion / nuevo / cobranza) y estado (pendiente / visitado) 

- Indicador del total de visitas del dia 

Boton o icono de cerrar sesion que regresa al Login 

## **Pantalla:** `CarteraDiariaScreen` **ViewModel:** `CarteraViewModel` con lista hardcodeada 

## Resumen de pantallas por app 

App Clientes — 2 pantallas 

|**Pantalla**|**ViewModel**|
|---|---|
|LoginScreen|AuthViewModel|
|DashboardScreen|HomeViewModel|



App Fuerza de Ventas — 2 pantallas 

|**Pantalla**|**ViewModel**|
|---|---|
|LoginOficialScreen|AuthOficialViewModel|
|CarteraDiariaScreen|CarteraViewModel|



## Criterios de evaluacion S9 

|Criterios de evaluacion S9||
|---|---|
|**Criterio**|**Puntaje**|
|Estructura de carpetas MVVM correcta|4 pts|
|2 pantallas creadas y navegables (login → home → login)|4 pts|
|ViewModel por pantalla con datos hardcodeados|4 pts|
|Branding de la entidad asignada (colores, logo, nombre)|4 pts|
|Repos en GitHub con nombre correcto y commits|4 pts|
|**Total**|**20 pts**|



## Lo que NO se evalua en S9 

- Conexion a Supabase o cualquier backend Validaciones de formularios 

3 / 4 

S9_HU_apps_moviles_1.md 

2026-05-14 

Persistencia de datos 

Logica de negocio 

Todo eso entra en S10 en adelante. 

## Equivalencia MVVM por stack 

|**Concepto**|**Kotlin/Compose**|**Flutter**|**.NET MAUI**|
|---|---|---|---|
|ViewModel|`ViewModel`+`StateFlow`|`ChangeNotifier`/`Riverpod`|`ObservableObject`|
|Estado|sealed class`UiState`|`state`/`provider`|`ObservableProperty`|
|Navegacion|`NavHost`+`NavController`|`GoRouter`/`Navigator`|`Shell`+`AppShell.xaml`|
|Vista|`@Composable`|`Widget`|`ContentPage`XAML|



La estructura de carpetas y la separacion de responsabilidades es identica en los tres stacks. 

4 / 4 


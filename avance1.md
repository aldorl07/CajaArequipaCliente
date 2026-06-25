## HU-C01 — Login

Como cliente registrado Quiero ingresar con mi usuario y contrasena para acceder a mis cuentas de forma segura

## *Criterios de aceptacion:*

- Campos: usuario/DNI y contrasena
- Logo y nombre de la entidad financiera asignada visible
- Colores y branding de la entidad (color primario, secundario)
- Boton "Ingresar" navega al Dashboard (sin validacion real en S9)
- Credenciales correctas hardcodeadas en el ViewModel

*Pantalla:* LoginScreen *ViewModel:* AuthViewModel con estado loading , success , error

## HU-C02 — Dashboard principal

Como cliente autenticado Quiero ver un resumen de mis productos financieros para tener una vision rapida de mi situacion financiera

## *Criterios de aceptacion:*

- Saludo con nombre del cliente (dato hardcodeado en ViewModel)
- Tarjeta de saldo de cuenta de ahorros
- Tarjeta de credito activo con monto pendiente
- Barra de navegacion inferior con tabs visibles: Inicio, Cuentas, Creditos, Perfil (los tabs solo Inicio funciona en S9)
- Boton o icono de cerrar sesion que regresa al Login

*Pantalla:* DashboardScreen *ViewModel:* HomeViewModel con datos ficticios de cuenta y credito
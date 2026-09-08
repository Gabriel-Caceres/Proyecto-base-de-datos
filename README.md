# BDY1103 - Base de Datos

Proyecto desarrollado para la asignatura **BDY1103 - Taller de Base de Datos**.

La base de datos representa el funcionamiento de un local de comida rápida, permitiendo almacenar información relacionada con trabajadores, roles, productos, ventas, métodos de pago, cajas y ventas sugestivas.

## Estructura del repositorio

```text
BDY1103/
│
├── README.md
│
├── 01_BD/
│   └── Base_de_Datos.sql
│
└── 02_DATOS/
    ├── Datos_Base.sql
    └── Datos_Ventas.sql
```

## Archivos

### 01_BD/Base_de_Datos.sql

Contiene la creación de las tablas de la base de datos junto con sus claves primarias, claves foráneas y restricciones.

Las tablas utilizadas son:

* ROLES
* TRABAJADORES
* CAJAS
* TURNOS
* CATEGORIAS
* PRODUCTOS
* METODOS_PAGO
* VENTAS
* DETALLE_VENTA
* TIPOS_SUGESTIVA
* SUGESTIVAS_VENTA

### 02_DATOS/Datos_Base.sql

Contiene los datos principales necesarios para utilizar la base de datos.

Incluye:

* Roles
* Trabajadores
* Cajas
* Turnos
* Categorías
* Productos
* Métodos de pago
* Tipos de venta sugestiva

### 02_DATOS/Datos_Ventas.sql

Contiene la generación de datos relacionados con las ventas.

Se utiliza `DBMS_RANDOM` para generar diferentes ventas y datos asociados, permitiendo disponer de información suficiente para realizar consultas y pruebas sobre la base de datos.

## Orden de ejecución

Los scripts deben ejecutarse en el siguiente orden:

1. `01_BD/Base_de_Datos.sql`
2. `02_DATOS/Datos_Base.sql`
3. `02_DATOS/Datos_Ventas.sql`

## Tecnologías utilizadas

* Oracle Database Free
* Oracle SQL Developer
* SQL
* PL/SQL

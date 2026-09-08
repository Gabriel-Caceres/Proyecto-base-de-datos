# BDY1103 - Base de Datos

Proyecto desarrollado para la asignatura **BDY1103 - Taller de Base de Datos**.

La base de datos representa el funcionamiento de un local de comida rápida, permitiendo almacenar información relacionada con trabajadores, roles, productos, ventas, métodos de pago, cajas y ventas sugestivas.

Además, el proyecto incorpora diferentes elementos de programación PL/SQL, incluyendo tipos de datos compuestos, cursores explícitos parametrizados, manejo de excepciones, procedimientos almacenados, funciones, packages y triggers.

## Estructura del repositorio

```text
BDY1103/
│
├── README.md
│
├── 01_BD/
│   └── Base_de_Datos.sql
│
├── 02_DATOS/
│   ├── Datos_Base.sql
│   └── Datos_Ventas.sql
│
└── 03_PLSQL/
    ├── 01_Record_Varray.sql
    ├── 02_Cursores.sql
    ├── 03_Excepciones.sql
    ├── 04_Procedimiento.sql
    ├── 05_Funcion.sql
    ├── 06_Package.sql
    └── 07_Trigger.sql
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

### 03_PLSQL/01_Record_Varray.sql

Contiene un bloque PL/SQL que utiliza un `RECORD` para almacenar información de una venta y un `VARRAY` para almacenar hasta cinco productos asociados.

### 03_PLSQL/02_Cursores.sql

Contiene cursores explícitos parametrizados y ciclos anidados para recorrer trabajadores, ventas y productos asociados a cada venta.

### 03_PLSQL/03_Excepciones.sql

Contiene ejemplos de manejo de excepciones utilizando:

* `NO_DATA_FOUND`
* Excepción definida por el usuario
* `WHEN OTHERS`

### 03_PLSQL/04_Procedimiento.sql

Contiene el procedimiento:

```sql
sp_resumen_ventas_trabajador
```

Permite obtener el nombre del trabajador, la cantidad de ventas realizadas y el total vendido.

### 03_PLSQL/05_Funcion.sql

Contiene la función:

```sql
fn_porcentaje_sugestiva
```

Permite calcular el porcentaje de ventas de un trabajador que contienen una acción de venta sugestiva.

### 03_PLSQL/06_Package.sql

Contiene el package:

```sql
pkg_reportes_ventas
```

Agrupa las funcionalidades relacionadas con los reportes de ventas.

Incluye:

* `resumen_ventas_trabajador`
* `porcentaje_sugestiva`

### 03_PLSQL/07_Trigger.sql

Contiene el trigger:

```sql
trg_validar_trabajador_venta
```

Este trigger valida que un trabajador se encuentre en estado `ACTIVO` antes de insertar o actualizar una venta.

## Orden de ejecución

Los scripts deben ejecutarse en el siguiente orden:

1. `01_BD/Base_de_Datos.sql`
2. `02_DATOS/Datos_Base.sql`
3. `02_DATOS/Datos_Ventas.sql`
4. `03_PLSQL/01_Record_Varray.sql`
5. `03_PLSQL/02_Cursores.sql`
6. `03_PLSQL/03_Excepciones.sql`
7. `03_PLSQL/04_Procedimiento.sql`
8. `03_PLSQL/05_Funcion.sql`
9. `03_PLSQL/06_Package.sql`
10. `03_PLSQL/07_Trigger.sql`

## Tecnologías utilizadas

* Oracle Database Free
* Oracle SQL Developer
* SQL
* PL/SQL

## Contenido desarrollado

El proyecto implementa diferentes elementos solicitados en la evaluación de Taller de Base de Datos:

* Tipos de datos compuestos `RECORD` y `VARRAY`
* Cursores explícitos parametrizados
* Ciclos anidados
* Manejo de excepciones
* Procedimientos almacenados
* Funciones
* Packages
* Triggers

Estas herramientas permiten procesar información, realizar cálculos, controlar errores y aplicar reglas de negocio directamente dentro de la base de datos.

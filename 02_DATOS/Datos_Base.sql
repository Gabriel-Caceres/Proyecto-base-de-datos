```sql
--------------------------------------------------
-- ROLES
--------------------------------------------------

INSERT INTO ROLES (
    ID_ROL,
    NOMBRE,
    NIVEL_JERARQUIA,
    DESCRIPCION
) VALUES (
    1,
    'Jefe de Local',
    1,
    'Responsable principal del local'
);

INSERT INTO ROLES VALUES (
    2,
    'Subgerente',
    2,
    'Apoya la gestion general del local'
);

INSERT INTO ROLES VALUES (
    3,
    'Gerente',
    3,
    'Encargado de supervisar la operacion'
);

INSERT INTO ROLES VALUES (
    4,
    'Entrenador',
    4,
    'Responsable de capacitar a los trabajadores'
);

INSERT INTO ROLES VALUES (
    5,
    'Crew',
    5,
    'Trabajador operativo del local'
);


--------------------------------------------------
-- TRABAJADORES
--------------------------------------------------

INSERT INTO TRABAJADORES (
    ID_TRABAJADOR,
    RUT,
    NOMBRE,
    APELLIDO,
    FECHA_CONTRATACION,
    ID_ROL,
    ESTADO
) VALUES (
    1,
    '12.345.678-9',
    'Carlos',
    'Muñoz',
    TO_DATE('15/03/2023', 'DD/MM/YYYY'),
    1,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    2,
    '13.456.789-0',
    'Daniela',
    'Rojas',
    TO_DATE('10/08/2023', 'DD/MM/YYYY'),
    2,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    3,
    '14.567.890-1',
    'Felipe',
    'Soto',
    TO_DATE('22/01/2024', 'DD/MM/YYYY'),
    3,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    4,
    '15.678.901-2',
    'Camila',
    'Vargas',
    TO_DATE('06/05/2024', 'DD/MM/YYYY'),
    4,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    5,
    '16.789.012-3',
    'Matias',
    'Perez',
    TO_DATE('15/07/2024', 'DD/MM/YYYY'),
    5,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    6,
    '17.890.123-4',
    'Sofia',
    'Gonzalez',
    TO_DATE('02/09/2024', 'DD/MM/YYYY'),
    5,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    7,
    '18.901.234-5',
    'Diego',
    'Contreras',
    TO_DATE('13/01/2025', 'DD/MM/YYYY'),
    5,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    8,
    '19.012.345-6',
    'Valentina',
    'Silva',
    TO_DATE('17/02/2025', 'DD/MM/YYYY'),
    5,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    9,
    '20.123.456-7',
    'Joaquin',
    'Martinez',
    TO_DATE('21/04/2025', 'DD/MM/YYYY'),
    5,
    'ACTIVO'
);

INSERT INTO TRABAJADORES VALUES (
    10,
    '21.234.567-8',
    'Antonia',
    'Ramirez',
    TO_DATE('09/06/2025', 'DD/MM/YYYY'),
    5,
    'ACTIVO'
);


--------------------------------------------------
-- CAJAS
--------------------------------------------------

INSERT INTO CAJAS VALUES (
    1,
    1,
    'Caja 1',
    'NORMAL',
    'ACTIVA'
);

INSERT INTO CAJAS VALUES (
    2,
    2,
    'Caja 2',
    'NORMAL',
    'ACTIVA'
);

INSERT INTO CAJAS VALUES (
    3,
    3,
    'Caja 3',
    'NORMAL',
    'ACTIVA'
);

INSERT INTO CAJAS VALUES (
    4,
    4,
    'Caja Delivery',
    'DELIVERY',
    'ACTIVA'
);


--------------------------------------------------
-- TURNOS
--------------------------------------------------

INSERT INTO TURNOS VALUES (
    1,
    'Apertura'
);

INSERT INTO TURNOS VALUES (
    2,
    'Medio'
);

INSERT INTO TURNOS VALUES (
    3,
    'Cierre'
);

INSERT INTO TURNOS VALUES (
    4,
    'Extraordinario'
);


--------------------------------------------------
-- CATEGORIAS
--------------------------------------------------

INSERT INTO CATEGORIAS VALUES (
    1,
    'Hamburguesas',
    'Hamburguesas individuales'
);

INSERT INTO CATEGORIAS VALUES (
    2,
    'Combos',
    'Combos de hamburguesa'
);

INSERT INTO CATEGORIAS VALUES (
    3,
    'Acompanamientos',
    'Papas y acompanamientos'
);

INSERT INTO CATEGORIAS VALUES (
    4,
    'Bebidas',
    'Bebidas y agua'
);

INSERT INTO CATEGORIAS VALUES (
    5,
    'Postres',
    'Postres y helados'
);

INSERT INTO CATEGORIAS VALUES (
    6,
    'Extras',
    'Extras y salsas'
);


--------------------------------------------------
-- PRODUCTOS
--------------------------------------------------

INSERT INTO PRODUCTOS VALUES (
    1,
    'Famous Star',
    NULL,
    4990,
    1,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    2,
    'Big Carl',
    NULL,
    5990,
    1,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    3,
    'Western Bacon Cheeseburger',
    NULL,
    6490,
    1,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    4,
    'California Classic',
    NULL,
    4490,
    1,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    5,
    'Jalapeno Burger',
    NULL,
    5790,
    1,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    6,
    'Combo Famous Star',
    NULL,
    6990,
    2,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    7,
    'Combo Big Carl',
    NULL,
    7990,
    2,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    8,
    'Combo Western Bacon',
    NULL,
    8490,
    2,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    9,
    'Combo California Classic',
    NULL,
    6490,
    2,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    10,
    'Combo Jalapeno Burger',
    NULL,
    7790,
    2,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    11,
    'Papas Pequenas',
    NULL,
    1990,
    3,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    12,
    'Papas Medianas',
    NULL,
    2490,
    3,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    13,
    'Papas Grandes',
    NULL,
    2990,
    3,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    14,
    'Aros de Cebolla',
    NULL,
    2990,
    3,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    15,
    'Coca Cola',
    NULL,
    1990,
    4,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    16,
    'Coca Cola Zero',
    NULL,
    1990,
    4,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    17,
    'Sprite',
    NULL,
    1990,
    4,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    18,
    'Fanta',
    NULL,
    1990,
    4,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    19,
    'Agua Mineral',
    NULL,
    1490,
    4,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    20,
    'Sundae',
    NULL,
    2490,
    5,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    21,
    'Brownie',
    NULL,
    2290,
    5,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    22,
    'Milkshake',
    NULL,
    3490,
    5,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    23,
    'Extra Queso',
    NULL,
    700,
    6,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    24,
    'Extra Tocino',
    NULL,
    1000,
    6,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    25,
    'Jalapenos',
    NULL,
    500,
    6,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    26,
    'Salsa BBQ',
    NULL,
    500,
    6,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    27,
    'Salsa Ranch',
    NULL,
    500,
    6,
    'DISPONIBLE'
);

INSERT INTO PRODUCTOS VALUES (
    28,
    'Salsa Buffalo',
    NULL,
    500,
    6,
    'DISPONIBLE'
);


--------------------------------------------------
-- METODOS DE PAGO
--------------------------------------------------

INSERT INTO METODOS_PAGO VALUES (
    1,
    'Efectivo',
    'ACTIVO'
);

INSERT INTO METODOS_PAGO VALUES (
    2,
    'Tarjeta Debito',
    'ACTIVO'
);

INSERT INTO METODOS_PAGO VALUES (
    3,
    'Tarjeta Credito',
    'ACTIVO'
);

INSERT INTO METODOS_PAGO VALUES (
    4,
    'Pago App',
    'ACTIVO'
);


--------------------------------------------------
-- TIPOS DE SUGESTIVA
--------------------------------------------------

INSERT INTO TIPOS_SUGESTIVA VALUES (
    1,
    'Cambio de acompanamiento',
    'Cambio del acompanamiento original por otro producto',
    'ACTIVO'
);

INSERT INTO TIPOS_SUGESTIVA VALUES (
    2,
    'Salsa adicional',
    'Venta de una salsa adicional',
    'ACTIVO'
);

INSERT INTO TIPOS_SUGESTIVA VALUES (
    3,
    'Upgrade de bebida',
    'Cambio o mejora de la bebida seleccionada',
    'ACTIVO'
);

INSERT INTO TIPOS_SUGESTIVA VALUES (
    4,
    'Producto adicional',
    'Producto adicional ofrecido por el cajero',
    'ACTIVO'
);

INSERT INTO TIPOS_SUGESTIVA VALUES (
    5,
    'Otro',
    'Otro tipo de venta sugestiva',
    'ACTIVO'
);


--------------------------------------------------
-- CONFIRMAR DATOS
--------------------------------------------------

COMMIT;
```

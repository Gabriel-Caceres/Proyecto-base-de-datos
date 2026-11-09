SET SERVEROUTPUT ON;

/*
   Demostracion de tipos compuestos:
   - RECORD: agrupa los atributos principales de una venta.
   - VARRAY: almacena hasta cinco nombres de productos de esa venta.
*/
DECLARE
    TYPE t_venta_record IS RECORD (
        id_venta    VENTAS.ID_VENTA%TYPE,
        fecha_hora  VENTAS.FECHA_HORA%TYPE,
        total       VENTAS.TOTAL%TYPE
    );

    v_venta t_venta_record;

    TYPE t_productos_varray IS VARRAY(5) OF VARCHAR2(100);
    v_productos t_productos_varray := t_productos_varray();
BEGIN
    SELECT ID_VENTA, FECHA_HORA, TOTAL
    INTO v_venta.id_venta,
         v_venta.fecha_hora,
         v_venta.total
    FROM VENTAS
    WHERE ID_VENTA = (SELECT MAX(ID_VENTA) FROM VENTAS);

    DBMS_OUTPUT.PUT_LINE('RESUMEN DE VENTA');
    DBMS_OUTPUT.PUT_LINE('ID venta: ' || v_venta.id_venta);
    DBMS_OUTPUT.PUT_LINE(
        'Fecha: ' || TO_CHAR(v_venta.fecha_hora, 'DD-MM-YYYY HH24:MI')
    );
    DBMS_OUTPUT.PUT_LINE('Total: $' || TO_CHAR(v_venta.total, 'FM999G999G990D00'));
    DBMS_OUTPUT.PUT_LINE('Productos asociados (maximo 5):');

    FOR producto IN (
        SELECT p.NOMBRE
        FROM DETALLE_VENTA d
        JOIN PRODUCTOS p
            ON p.ID_PRODUCTO = d.ID_PRODUCTO
        WHERE d.ID_VENTA = v_venta.id_venta
        ORDER BY d.ID_DETALLE
        FETCH FIRST 5 ROWS ONLY
    ) LOOP
        -- La consulta limita el resultado a la capacidad del VARRAY.
        v_productos.EXTEND;
        v_productos(v_productos.COUNT) := producto.NOMBRE;
    END LOOP;

    IF v_productos.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('La venta no tiene productos asociados.');
    ELSE
        FOR i IN 1 .. v_productos.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(i || '. ' || v_productos(i));
        END LOOP;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'No hay ventas disponibles para demostrar RECORD y VARRAY.'
        );
END;
/

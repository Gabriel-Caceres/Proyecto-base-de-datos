
SET SERVEROUTPUT ON;

DECLARE

    TYPE t_venta_record IS RECORD (
        id_venta VENTAS.ID_VENTA%TYPE,
        fecha_hora VENTAS.FECHA_HORA%TYPE,
        total VENTAS.TOTAL%TYPE
    );

    v_venta t_venta_record;

    TYPE t_productos_varray IS VARRAY(5) OF VARCHAR2(100);

    v_productos t_productos_varray := t_productos_varray();

    v_contador NUMBER := 0;

BEGIN

    SELECT ID_VENTA, FECHA_HORA, TOTAL
    INTO v_venta.id_venta,
         v_venta.fecha_hora,
         v_venta.total
    FROM VENTAS
    WHERE ID_VENTA = (
        SELECT MAX(ID_VENTA)
        FROM VENTAS
    );

    DBMS_OUTPUT.PUT_LINE(
        'ID Venta: ' || v_venta.id_venta
    );

    DBMS_OUTPUT.PUT_LINE(
        'Fecha: ' ||
        TO_CHAR(v_venta.fecha_hora, 'DD-MM-YYYY HH24:MI')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total: $' || v_venta.total
    );

    FOR producto IN (
        SELECT p.NOMBRE
        FROM DETALLE_VENTA d
        JOIN PRODUCTOS p
            ON p.ID_PRODUCTO = d.ID_PRODUCTO
        WHERE d.ID_VENTA = v_venta.id_venta
        FETCH FIRST 5 ROWS ONLY
    )
    LOOP

        v_contador := v_contador + 1;

        v_productos.EXTEND;

        v_productos(v_contador) := producto.NOMBRE;

    END LOOP;

    FOR i IN 1 .. v_productos.COUNT
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            i || '. ' || v_productos(i)
        );

    END LOOP;

END;
/


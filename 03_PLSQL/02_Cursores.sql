SET SERVEROUTPUT ON;

/*
   Demostracion de cursores explicitos y ciclos anidados:
   1. c_trabajadores: cursor explicito sin parametros.
   2. c_ventas_trabajador: cursor explicito parametrizado por trabajador.
   3. c_productos_venta: cursor explicito parametrizado por venta.
*/
DECLARE
    CURSOR c_trabajadores IS
        SELECT
            ID_TRABAJADOR,
            NOMBRE || ' ' || APELLIDO AS NOMBRE_COMPLETO
        FROM TRABAJADORES
        WHERE ID_ROL = 5
        ORDER BY ID_TRABAJADOR;

    CURSOR c_ventas_trabajador (
        p_id_trabajador TRABAJADORES.ID_TRABAJADOR%TYPE
    ) IS
        SELECT
            v.ID_VENTA,
            v.FECHA_HORA,
            v.TOTAL
        FROM VENTAS v
        WHERE v.ID_TRABAJADOR = p_id_trabajador
        ORDER BY v.FECHA_HORA, v.ID_VENTA;

    CURSOR c_productos_venta (
        p_id_venta VENTAS.ID_VENTA%TYPE
    ) IS
        SELECT
            p.NOMBRE,
            d.CANTIDAD,
            d.SUBTOTAL
        FROM DETALLE_VENTA d
        JOIN PRODUCTOS p
            ON p.ID_PRODUCTO = d.ID_PRODUCTO
        WHERE d.ID_VENTA = p_id_venta
        ORDER BY d.ID_DETALLE;

    v_total_trabajador VENTAS.TOTAL%TYPE;
    v_cantidad_ventas PLS_INTEGER;
    v_hay_trabajadores BOOLEAN := FALSE;
BEGIN
    FOR trabajador IN c_trabajadores LOOP
        v_hay_trabajadores := TRUE;
        v_total_trabajador := 0;
        v_cantidad_ventas := 0;

        DBMS_OUTPUT.PUT_LINE('========================================');
        DBMS_OUTPUT.PUT_LINE('Trabajador: ' || trabajador.NOMBRE_COMPLETO);
        DBMS_OUTPUT.PUT_LINE('ID trabajador: ' || trabajador.ID_TRABAJADOR);

        FOR venta IN c_ventas_trabajador(trabajador.ID_TRABAJADOR) LOOP
            v_cantidad_ventas := v_cantidad_ventas + 1;
            v_total_trabajador := v_total_trabajador + venta.TOTAL;

            DBMS_OUTPUT.PUT_LINE(
                'Venta ' || venta.ID_VENTA ||
                ' | Fecha: ' || TO_CHAR(venta.FECHA_HORA, 'DD-MM-YYYY HH24:MI') ||
                ' | Total: $' || TO_CHAR(venta.TOTAL, 'FM999G999G990D00')
            );

            FOR producto IN c_productos_venta(venta.ID_VENTA) LOOP
                DBMS_OUTPUT.PUT_LINE(
                    '   - ' || producto.NOMBRE ||
                    ' x' || producto.CANTIDAD ||
                    ' = $' || TO_CHAR(producto.SUBTOTAL, 'FM999G999G990D00')
                );
            END LOOP;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Cantidad de ventas: ' || v_cantidad_ventas);
        DBMS_OUTPUT.PUT_LINE(
            'Total vendido: $' ||
            TO_CHAR(v_total_trabajador, 'FM999G999G990D00')
        );
    END LOOP;

    IF NOT v_hay_trabajadores THEN
        DBMS_OUTPUT.PUT_LINE('No hay trabajadores con rol Crew para procesar.');
    END IF;
END;
/

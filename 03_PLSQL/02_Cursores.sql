
SET SERVEROUTPUT ON;

DECLARE

    CURSOR c_ventas_trabajador(
        p_id_trabajador NUMBER
    ) IS
        SELECT
            v.ID_VENTA,
            v.FECHA_HORA,
            v.TOTAL
        FROM VENTAS v
        WHERE v.ID_TRABAJADOR = p_id_trabajador
        ORDER BY v.FECHA_HORA;

    CURSOR c_productos_venta(
        p_id_venta NUMBER
    ) IS
        SELECT
            p.NOMBRE,
            d.CANTIDAD,
            d.SUBTOTAL
        FROM DETALLE_VENTA d
        JOIN PRODUCTOS p
            ON p.ID_PRODUCTO = d.ID_PRODUCTO
        WHERE d.ID_VENTA = p_id_venta;

    v_total_trabajador NUMBER := 0;
    v_cantidad_ventas NUMBER := 0;

BEGIN

    FOR trabajador IN (
        SELECT
            ID_TRABAJADOR,
            NOMBRE || ' ' || APELLIDO AS NOMBRE_COMPLETO
        FROM TRABAJADORES
        WHERE ID_ROL = 5
        ORDER BY ID_TRABAJADOR
    )
    LOOP

        v_total_trabajador := 0;
        v_cantidad_ventas := 0;

        FOR venta IN c_ventas_trabajador(
            trabajador.ID_TRABAJADOR
        )
        LOOP

            v_cantidad_ventas :=
                v_cantidad_ventas + 1;

            v_total_trabajador :=
                v_total_trabajador + venta.TOTAL;

            FOR producto IN c_productos_venta(
                venta.ID_VENTA
            )
            LOOP

                DBMS_OUTPUT.PUT_LINE(
                    producto.NOMBRE ||
                    ' x' ||
                    producto.CANTIDAD ||
                    ' = $' ||
                    producto.SUBTOTAL
                );

            END LOOP;

        END LOOP;

        DBMS_OUTPUT.PUT_LINE(
            'Cantidad de ventas: ' ||
            v_cantidad_ventas
        );

        DBMS_OUTPUT.PUT_LINE(
            'Total vendido: $' ||
            v_total_trabajador
        );

    END LOOP;

END;
/


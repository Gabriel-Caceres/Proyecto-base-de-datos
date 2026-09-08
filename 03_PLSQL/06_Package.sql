```sql
CREATE OR REPLACE PACKAGE pkg_reportes_ventas IS

    PROCEDURE resumen_ventas_trabajador (
        p_id_trabajador IN NUMBER
    );

    FUNCTION porcentaje_sugestiva (
        p_id_trabajador IN NUMBER
    )
    RETURN NUMBER;

END pkg_reportes_ventas;
/

CREATE OR REPLACE PACKAGE BODY pkg_reportes_ventas IS

    PROCEDURE resumen_ventas_trabajador (
        p_id_trabajador IN NUMBER
    )
    IS
        v_nombre VARCHAR2(120);
        v_cantidad NUMBER;
        v_total NUMBER;
    BEGIN

        SELECT
            NOMBRE || ' ' || APELLIDO
        INTO v_nombre
        FROM TRABAJADORES
        WHERE ID_TRABAJADOR = p_id_trabajador;

        SELECT
            COUNT(*),
            NVL(SUM(TOTAL), 0)
        INTO
            v_cantidad,
            v_total
        FROM VENTAS
        WHERE ID_TRABAJADOR = p_id_trabajador;

        DBMS_OUTPUT.PUT_LINE(
            'Trabajador: ' || v_nombre
        );

        DBMS_OUTPUT.PUT_LINE(
            'Cantidad de ventas: ' ||
            v_cantidad
        );

        DBMS_OUTPUT.PUT_LINE(
            'Total vendido: $' ||
            v_total
        );

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            DBMS_OUTPUT.PUT_LINE(
                'ERROR: No existe el trabajador.'
            );

        WHEN OTHERS THEN

            DBMS_OUTPUT.PUT_LINE(
                'ERROR: ' || SQLERRM
            );

    END resumen_ventas_trabajador;


    FUNCTION porcentaje_sugestiva (
        p_id_trabajador IN NUMBER
    )
    RETURN NUMBER
    IS
        v_total_ventas NUMBER;
        v_ventas_sugestiva NUMBER;
        v_porcentaje NUMBER;
    BEGIN

        SELECT COUNT(*)
        INTO v_total_ventas
        FROM VENTAS
        WHERE ID_TRABAJADOR = p_id_trabajador;

        SELECT COUNT(DISTINCT v.ID_VENTA)
        INTO v_ventas_sugestiva
        FROM VENTAS v
        JOIN SUGESTIVAS_VENTA sv
            ON sv.ID_VENTA = v.ID_VENTA
        WHERE v.ID_TRABAJADOR = p_id_trabajador;

        IF v_total_ventas = 0 THEN

            v_porcentaje := 0;

        ELSE

            v_porcentaje :=
                (v_ventas_sugestiva /
                v_total_ventas) * 100;

        END IF;

        RETURN ROUND(v_porcentaje, 2);

    EXCEPTION

        WHEN OTHERS THEN

            RETURN 0;

    END porcentaje_sugestiva;

END pkg_reportes_ventas;
/
```

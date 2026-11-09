CREATE OR REPLACE PACKAGE pkg_reportes_ventas IS
    PROCEDURE resumen_ventas_trabajador (
        p_id_trabajador IN TRABAJADORES.ID_TRABAJADOR%TYPE
    );

    FUNCTION porcentaje_sugestiva (
        p_id_trabajador IN TRABAJADORES.ID_TRABAJADOR%TYPE
    ) RETURN NUMBER;
END pkg_reportes_ventas;
/

CREATE OR REPLACE PACKAGE BODY pkg_reportes_ventas IS
    PROCEDURE resumen_ventas_trabajador (
        p_id_trabajador IN TRABAJADORES.ID_TRABAJADOR%TYPE
    )
    IS
        v_nombre_completo VARCHAR2(101);
        v_cantidad_ventas PLS_INTEGER;
        v_total_vendido   VENTAS.TOTAL%TYPE;
    BEGIN
        SELECT NOMBRE || ' ' || APELLIDO
        INTO v_nombre_completo
        FROM TRABAJADORES
        WHERE ID_TRABAJADOR = p_id_trabajador;

        SELECT COUNT(*), NVL(SUM(TOTAL), 0)
        INTO v_cantidad_ventas, v_total_vendido
        FROM VENTAS
        WHERE ID_TRABAJADOR = p_id_trabajador;

        DBMS_OUTPUT.PUT_LINE('RESUMEN DE VENTAS POR TRABAJADOR');
        DBMS_OUTPUT.PUT_LINE('Trabajador: ' || v_nombre_completo);
        DBMS_OUTPUT.PUT_LINE('Cantidad de ventas: ' || v_cantidad_ventas);
        DBMS_OUTPUT.PUT_LINE(
            'Total vendido: $' ||
            TO_CHAR(v_total_vendido, 'FM999G999G990D00')
        );
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'No existe un trabajador con ID ' || p_id_trabajador || '.'
            );
    END resumen_ventas_trabajador;

    FUNCTION porcentaje_sugestiva (
        p_id_trabajador IN TRABAJADORES.ID_TRABAJADOR%TYPE
    ) RETURN NUMBER
    IS
        v_existe_trabajador NUMBER;
        v_total_ventas      NUMBER;
        v_ventas_sugestiva  NUMBER;
        v_porcentaje        NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_existe_trabajador
        FROM TRABAJADORES
        WHERE ID_TRABAJADOR = p_id_trabajador;

        IF v_existe_trabajador = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'No existe un trabajador con ID ' || p_id_trabajador || '.'
            );
        END IF;

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
            v_porcentaje := (v_ventas_sugestiva / v_total_ventas) * 100;
        END IF;

        RETURN ROUND(v_porcentaje, 2);
    END porcentaje_sugestiva;
END pkg_reportes_ventas;
/

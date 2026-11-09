CREATE OR REPLACE PROCEDURE sp_resumen_ventas_trabajador (
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
END;
/

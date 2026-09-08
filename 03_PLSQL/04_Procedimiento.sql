CREATE OR REPLACE PROCEDURE sp_resumen_ventas_trabajador (
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

END;
/

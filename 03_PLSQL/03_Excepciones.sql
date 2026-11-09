
SET SERVEROUTPUT ON;

DECLARE
    v_nombre_trabajador TRABAJADORES.NOMBRE%TYPE;
    v_total_venta NUMBER;

    -- Excepcion definida por el desarrollador
    e_total_invalido EXCEPTION;

BEGIN

    --------------------------------------------------
    -- CASO 1: EXCEPCION PREDEFINIDA DE ORACLE
    -- NO_DATA_FOUND
    --------------------------------------------------

    BEGIN

        SELECT NOMBRE
        INTO v_nombre_trabajador
        FROM TRABAJADORES
        WHERE ID_TRABAJADOR = -1;

        DBMS_OUTPUT.PUT_LINE(
            'Trabajador encontrado: ' || v_nombre_trabajador
        );

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            DBMS_OUTPUT.PUT_LINE(
                'EXCEPCION ORACLE: NO_DATA_FOUND'
            );

            DBMS_OUTPUT.PUT_LINE(
                'No existe un trabajador con ID -1.'
            );

    END;


    --------------------------------------------------
    -- CASO 2: EXCEPCION DEFINIDA POR EL USUARIO
    --------------------------------------------------

    -- Simulamos un valor invalido para probar el control.
    -- No insertamos ni modificamos datos de la base.

    v_total_venta := 0;

    BEGIN

        IF v_total_venta <= 0 THEN

            RAISE e_total_invalido;

        END IF;

        DBMS_OUTPUT.PUT_LINE(
            'El total de la venta es valido.'
        );

    EXCEPTION

        WHEN e_total_invalido THEN

            DBMS_OUTPUT.PUT_LINE(
                'EXCEPCION USUARIO: El total de la venta no es valido.'
            );

    END;


    --------------------------------------------------
    -- FIN DE LAS PRUEBAS
    --------------------------------------------------

    DBMS_OUTPUT.PUT_LINE(
        'Pruebas de excepciones finalizadas.'
    );

END;
/

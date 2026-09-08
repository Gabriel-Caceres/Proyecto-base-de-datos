
SET SERVEROUTPUT ON;

DECLARE

    v_nombre_trabajador TRABAJADORES.NOMBRE%TYPE;
    v_total_venta VENTAS.TOTAL%TYPE;

    e_total_invalido EXCEPTION;

BEGIN

    BEGIN

        SELECT NOMBRE
        INTO v_nombre_trabajador
        FROM TRABAJADORES
        WHERE ID_TRABAJADOR = 9999;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            DBMS_OUTPUT.PUT_LINE(
                'EXCEPCION ORACLE: NO_DATA_FOUND'
            );

            DBMS_OUTPUT.PUT_LINE(
                'No existe un trabajador con ID 9999.'
            );

    END;

    SELECT TOTAL
    INTO v_total_venta
    FROM VENTAS
    WHERE ID_VENTA = (
        SELECT MAX(ID_VENTA)
        FROM VENTAS
    );

    IF v_total_venta <= 0 THEN

        RAISE e_total_invalido;

    END IF;

EXCEPTION

    WHEN e_total_invalido THEN

        DBMS_OUTPUT.PUT_LINE(
            'EXCEPCION USUARIO: El total de la venta no es valido.'
        );

    WHEN OTHERS THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR NO CONTROLADO: ' ||
            SQLERRM
        );

END;
/


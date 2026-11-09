SET SERVEROUTPUT ON;

/*
   Demostracion en un bloque PL/SQL anonimo:
   - NO_DATA_FOUND: excepcion predefinida de Oracle.
   - e_total_invalido: excepcion definida por el desarrollador.

   El total negativo se simula en una variable para probar la validacion
   antes de insertar una venta. No se modifica ninguna tabla.
*/
DECLARE
    v_nombre_trabajador TRABAJADORES.NOMBRE%TYPE;
    v_id_busqueda       TRABAJADORES.ID_TRABAJADOR%TYPE := -1;
    v_total_prueba      VENTAS.TOTAL%TYPE := -1;

    e_total_invalido EXCEPTION;
BEGIN
    -- Caso 1: Oracle genera NO_DATA_FOUND porque el trabajador no existe.
    BEGIN
        SELECT NOMBRE
        INTO v_nombre_trabajador
        FROM TRABAJADORES
        WHERE ID_TRABAJADOR = v_id_busqueda;

        DBMS_OUTPUT.PUT_LINE('Trabajador encontrado: ' || v_nombre_trabajador);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION ORACLE: NO_DATA_FOUND');
            DBMS_OUTPUT.PUT_LINE(
                'No existe un trabajador con ID ' || v_id_busqueda || '.'
            );
    END;

    -- Caso 2: se valida un total de prueba antes de registrar la venta.
    BEGIN
        IF v_total_prueba < 0 THEN
            RAISE e_total_invalido;
        END IF;

        DBMS_OUTPUT.PUT_LINE('El total de prueba es valido.');
    EXCEPTION
        WHEN e_total_invalido THEN
            DBMS_OUTPUT.PUT_LINE(
                'EXCEPCION USUARIO: el total de la venta no puede ser negativo.'
            );
    END;

    DBMS_OUTPUT.PUT_LINE('Demostracion de excepciones finalizada.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
        RAISE;
END;
/

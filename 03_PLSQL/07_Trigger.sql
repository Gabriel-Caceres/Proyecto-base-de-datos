
CREATE OR REPLACE TRIGGER trg_validar_trabajador_venta
BEFORE INSERT OR UPDATE ON VENTAS
FOR EACH ROW
DECLARE
    v_estado TRABAJADORES.ESTADO%TYPE;
BEGIN
    SELECT ESTADO
    INTO v_estado
    FROM TRABAJADORES
    WHERE ID_TRABAJADOR = :NEW.ID_TRABAJADOR;

    IF v_estado <> 'ACTIVO' THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'No se puede registrar la venta: el trabajador no esta ACTIVO.'
        );
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'No se puede registrar la venta: el trabajador no existe.'
        );
END;
/

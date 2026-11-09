CREATE OR REPLACE FUNCTION fn_porcentaje_sugestiva (
    p_id_trabajador IN TRABAJADORES.ID_TRABAJADOR%TYPE
)
RETURN NUMBER
IS
    v_existe_trabajador NUMBER;
    v_total_ventas      NUMBER;
    v_ventas_sugestiva  NUMBER;
    v_porcentaje        NUMBER;
BEGIN
    -- Evita devolver 0 cuando el identificador del trabajador no existe.
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

    -- Un trabajador sin ventas tiene 0% de ventas sugestivas.
    IF v_total_ventas = 0 THEN
        v_porcentaje := 0;
    ELSE
        v_porcentaje := (v_ventas_sugestiva / v_total_ventas) * 100;
    END IF;

    RETURN ROUND(v_porcentaje, 2);
END;
/

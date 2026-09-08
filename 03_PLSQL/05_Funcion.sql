
CREATE OR REPLACE FUNCTION fn_porcentaje_sugestiva (
    p_id_trabajador IN NUMBER
)
RETURN NUMBER
IS
    v_total_ventas       NUMBER;
    v_ventas_sugestiva   NUMBER;
    v_porcentaje         NUMBER;
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
            (v_ventas_sugestiva / v_total_ventas) * 100;
    END IF;

    RETURN ROUND(v_porcentaje, 2);

EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/

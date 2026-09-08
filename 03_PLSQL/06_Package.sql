
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

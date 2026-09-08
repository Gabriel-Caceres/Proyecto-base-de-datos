
--------------------------------------------------
-- GENERACION DE VENTAS
--------------------------------------------------

DECLARE
    v_id_venta       NUMBER;
    v_trabajador     NUMBER;
    v_caja           NUMBER;
    v_metodo_pago    NUMBER;
    v_fecha          TIMESTAMP;

    v_producto       NUMBER;
    v_precio         NUMBER;
    v_cantidad       NUMBER;

    v_subtotal       NUMBER;
    v_descuento      NUMBER;
    v_total          NUMBER;

    v_cantidad_productos NUMBER;

BEGIN

    --------------------------------------------------
    -- GENERAR 100 VENTAS
    --------------------------------------------------

    FOR i IN 1..100 LOOP

        --------------------------------------------------
        -- TRABAJADOR ALEATORIO
        -- Crew: ID 5 al 10
        --------------------------------------------------

        v_trabajador :=
            TRUNC(DBMS_RANDOM.VALUE(5, 11));


        --------------------------------------------------
        -- CAJA ALEATORIA
        -- Aproximadamente 10% de las ventas son delivery
        --------------------------------------------------

        IF DBMS_RANDOM.VALUE(0, 1) < 0.10 THEN
            v_caja := 4;
        ELSE
            v_caja := TRUNC(DBMS_RANDOM.VALUE(1, 4));
        END IF;


        --------------------------------------------------
        -- METODO DE PAGO
        --------------------------------------------------

        v_metodo_pago :=
            TRUNC(DBMS_RANDOM.VALUE(1, 5));


        --------------------------------------------------
        -- FECHA ALEATORIA
        -- Dentro de los ultimos 30 dias
        --------------------------------------------------

        v_fecha :=
            SYSTIMESTAMP
            - NUMTODSINTERVAL(
                TRUNC(DBMS_RANDOM.VALUE(0, 30)),
                'DAY'
            )
            - NUMTODSINTERVAL(
                TRUNC(DBMS_RANDOM.VALUE(0, 86400)),
                'SECOND'
            );


        --------------------------------------------------
        -- CREAR VENTA TEMPORALMENTE EN 0
        --------------------------------------------------

        INSERT INTO VENTAS (
            FECHA_HORA,
            ID_TRABAJADOR,
            ID_CAJA,
            ID_METODO_PAGO,
            SUBTOTAL,
            DESCUENTO,
            TOTAL
        )
        VALUES (
            v_fecha,
            v_trabajador,
            v_caja,
            v_metodo_pago,
            0,
            0,
            0
        )
        RETURNING ID_VENTA INTO v_id_venta;


        --------------------------------------------------
        -- GENERAR ENTRE 1 Y 4 PRODUCTOS
        --------------------------------------------------

        v_subtotal := 0;

        v_cantidad_productos :=
            TRUNC(DBMS_RANDOM.VALUE(1, 5));


        FOR j IN 1..v_cantidad_productos LOOP

            --------------------------------------------------
            -- PRODUCTO ALEATORIO
            --------------------------------------------------

            v_producto :=
                TRUNC(DBMS_RANDOM.VALUE(1, 29));


            --------------------------------------------------
            -- OBTENER PRECIO DEL PRODUCTO
            --------------------------------------------------

            SELECT PRECIO
            INTO v_precio
            FROM PRODUCTOS
            WHERE ID_PRODUCTO = v_producto;


            --------------------------------------------------
            -- CANTIDAD ENTRE 1 Y 2
            --------------------------------------------------

            v_cantidad :=
                TRUNC(DBMS_RANDOM.VALUE(1, 3));


            --------------------------------------------------
            -- INSERTAR DETALLE
            --------------------------------------------------

            INSERT INTO DETALLE_VENTA (
                ID_VENTA,
                ID_PRODUCTO,
                CANTIDAD,
                PRECIO_UNITARIO,
                SUBTOTAL
            )
            VALUES (
                v_id_venta,
                v_producto,
                v_cantidad,
                v_precio,
                v_cantidad * v_precio
            );


            --------------------------------------------------
            -- ACUMULAR SUBTOTAL
            --------------------------------------------------

            v_subtotal :=
                v_subtotal + (v_cantidad * v_precio);

        END LOOP;


        --------------------------------------------------
        -- DESCUENTO
        -- Aproximadamente 15% de las ventas
        --------------------------------------------------

        IF DBMS_RANDOM.VALUE(0, 1) < 0.15 THEN

            v_descuento :=
                ROUND(v_subtotal * 0.10);

        ELSE

            v_descuento := 0;

        END IF;


        --------------------------------------------------
        -- CALCULAR TOTAL
        --------------------------------------------------

        v_total :=
            v_subtotal - v_descuento;


        --------------------------------------------------
        -- ACTUALIZAR VENTA
        --------------------------------------------------

        UPDATE VENTAS
        SET SUBTOTAL = v_subtotal,
            DESCUENTO = v_descuento,
            TOTAL = v_total
        WHERE ID_VENTA = v_id_venta;

    END LOOP;


    COMMIT;

END;
/


--------------------------------------------------
-- GENERACION DE VENTAS SUGESTIVAS
--------------------------------------------------

DECLARE

    v_id_venta            NUMBER;
    v_tipo_sugestiva      NUMBER;
    v_producto_original   NUMBER;
    v_producto_sugerido   NUMBER;
    v_valor_adicional     NUMBER;

BEGIN

    --------------------------------------------------
    -- GENERAR 30 SUGESTIVAS
    --------------------------------------------------

    FOR i IN 1..30 LOOP

        --------------------------------------------------
        -- SELECCIONAR UNA VENTA ALEATORIA
        --------------------------------------------------

        SELECT ID_VENTA
        INTO v_id_venta
        FROM (
            SELECT ID_VENTA
            FROM VENTAS
            ORDER BY DBMS_RANDOM.VALUE
        )
        WHERE ROWNUM = 1;


        --------------------------------------------------
        -- TIPO DE SUGESTIVA
        --------------------------------------------------

        v_tipo_sugestiva :=
            TRUNC(DBMS_RANDOM.VALUE(1, 6));


        --------------------------------------------------
        -- VALORES SEGUN EL TIPO
        --------------------------------------------------

        v_producto_original := NULL;
        v_producto_sugerido := NULL;
        v_valor_adicional := 0;


        --------------------------------------------------
        -- CAMBIO DE ACOMPANAMIENTO
        --------------------------------------------------

        IF v_tipo_sugestiva = 1 THEN

            v_producto_original :=
                TRUNC(DBMS_RANDOM.VALUE(11, 14));

            v_producto_sugerido := 14;

            SELECT GREATEST(
                       p2.PRECIO - p1.PRECIO,
                       0
                   )
            INTO v_valor_adicional
            FROM PRODUCTOS p1,
                 PRODUCTOS p2
            WHERE p1.ID_PRODUCTO = v_producto_original
              AND p2.ID_PRODUCTO = v_producto_sugerido;


        --------------------------------------------------
        -- SALSA ADICIONAL
        --------------------------------------------------

        ELSIF v_tipo_sugestiva = 2 THEN

            v_producto_sugerido :=
                TRUNC(DBMS_RANDOM.VALUE(26, 29));

            SELECT PRECIO
            INTO v_valor_adicional
            FROM PRODUCTOS
            WHERE ID_PRODUCTO = v_producto_sugerido;


        --------------------------------------------------
        -- UPGRADE DE BEBIDA
        --------------------------------------------------

        ELSIF v_tipo_sugestiva = 3 THEN

            v_producto_original :=
                TRUNC(DBMS_RANDOM.VALUE(15, 20));

            v_producto_sugerido :=
                TRUNC(DBMS_RANDOM.VALUE(15, 20));

            SELECT GREATEST(
                       p2.PRECIO - p1.PRECIO,
                       0
                   )
            INTO v_valor_adicional
            FROM PRODUCTOS p1,
                 PRODUCTOS p2
            WHERE p1.ID_PRODUCTO = v_producto_original
              AND p2.ID_PRODUCTO = v_producto_sugerido;


        --------------------------------------------------
        -- PRODUCTO ADICIONAL
        --------------------------------------------------

        ELSIF v_tipo_sugestiva = 4 THEN

            v_producto_sugerido :=
                TRUNC(DBMS_RANDOM.VALUE(20, 29));

            SELECT PRECIO
            INTO v_valor_adicional
            FROM PRODUCTOS
            WHERE ID_PRODUCTO = v_producto_sugerido;


        --------------------------------------------------
        -- OTRO
        --------------------------------------------------

        ELSE

            v_producto_sugerido :=
                TRUNC(DBMS_RANDOM.VALUE(1, 29));

            SELECT PRECIO
            INTO v_valor_adicional
            FROM PRODUCTOS
            WHERE ID_PRODUCTO = v_producto_sugerido;

        END IF;


        --------------------------------------------------
        -- INSERTAR SUGESTIVA
        --------------------------------------------------

        INSERT INTO SUGESTIVAS_VENTA (
            ID_VENTA,
            ID_TIPO_SUGESTIVA,
            ID_PRODUCTO_ORIGINAL,
            ID_PRODUCTO_SUGERIDO,
            VALOR_ADICIONAL,
            CANTIDAD,
            OBSERVACION
        )
        VALUES (
            v_id_venta,
            v_tipo_sugestiva,
            v_producto_original,
            v_producto_sugerido,
            v_valor_adicional,
            1,
            'Cajero ofrecio venta sugestiva'
        );

    END LOOP;


    COMMIT;

END;
/

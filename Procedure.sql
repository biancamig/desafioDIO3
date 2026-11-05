USE ecommerce;

DROP PROCEDURE IF EXISTS create_order_transaction;

DELIMITER $$
CREATE PROCEDURE create_order_transaction(
    IN p_idClient INT,
    IN p_idProduct INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_idPedido INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro na transação. Operações desfeitas.' AS Message;
    END;

    START TRANSACTION;

    INSERT INTO orders
        (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
    VALUES
        (p_idClient, 'Confirmado', 'Pedido via procedure', 10.00, 1);

    SET v_idPedido = LAST_INSERT_ID();

    INSERT INTO productOrder
        (idPOproduct, idPOorder, poQuantity, poStatus)
    VALUES
        (p_idProduct, v_idPedido, p_quantity, 'Disponivel');

    COMMIT;
    
    SELECT 'Pedido realizado com sucesso!' AS Message;
    
END $$
DELIMITER ;

CALL create_order_transaction(1, 1, 2);

CALL create_order_transaction(999, 1, 2);
USE ecommerce;

SET autocommit = 0;

START TRANSACTION;

INSERT INTO orders
    (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES
    (1, 'Confirmado', 'Pedido realizado via transação', 10.00, 1);

SET @idPedido = LAST_INSERT_ID();

INSERT INTO productOrder
    (idPOproduct, idPOorder, poQuantity, poStatus)
VALUES
    (1, @idPedido, 2, 'Disponivel');

SELECT * FROM orders
WHERE idOrder = @idPedido;

SELECT * FROM productOrder
WHERE idPOorder = @idPedido;

COMMIT;

SET autocommit = 1;


START TRANSACTION;

UPDATE orders
SET orderStatus = 'Cancelado'
WHERE idOrder = @idPedido;

ROLLBACK;

SELECT * FROM orders
WHERE idOrder = @idPedido;

DELIMITER //
CREATE TRIGGER after_produit_insert
AFTER INSERT ON produit
FOR EACH ROW
BEGIN
    CALL calculerStockTotal();
END //


CREATE TRIGGER after_produit_insert
AFTER UPDATE ON produit
FOR EACH ROW
BEGIN
    CALL calculerStockTotal();
END //


CREATE TRIGGER after_produit_insert
AFTER DELETE ON produit
FOR EACH ROW
BEGIN
    CALL calculerStockTotal();
END //
DELIMITER ;
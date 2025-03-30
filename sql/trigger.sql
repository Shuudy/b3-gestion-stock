DELIMITER //

CREATE TRIGGER update_product_quantity
AFTER INSERT ON commande
FOR EACH ROW
BEGIN
    DECLARE @quantite_produit INT;

    SELECT quantite FROM produit WHERE id_produit = NEW.id_produit INTO @quantite_produit;

    SET @quantite_produit = @quantite_produit - -- Quantité de produit acheté dans la commande --;

    UPDATE produit SET quantite = @quantite_produit WHERE id_produit = NEW.id_produit;
    UPDATE stock_total SET total_stock = total_stock - -- Quantité de produit acheté dans la commande -- WHERE id_stock_total = 1;
END //

DELIMITER ;
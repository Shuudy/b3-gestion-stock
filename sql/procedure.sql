-- valeur iitiale dans stock_total afin de pouvoir mettre a jour 
INSERT INTO stock_total (total_stock, derniere_maj) VALUES (0, CURDATE());


-- Création de procédures stockées pour chaque élément d’un CRUD

-- CRUD POUR produit
-- create
DELIMITER //
CREATE PROCEDURE ajouterProduit (
    IN p_nom_produit VARCHAR(100),
    IN p_description VARCHAR(100),
    IN p_quantite INT,
    IN p_prix DECIMAL(10,2),
    IN p_categorie VARCHAR(30)
)
BEGIN
    INSERT INTO produit (nom_produit, description, quantite, prix, categorie)
    VALUES (p_nom_produit, p_description, p_quantite, p_prix, p_categorie);
END //
DELIMITER ;


-- read
DELIMITER //
CREATE PROCEDURE obtenirProduits ()
BEGIN
    SELECT * FROM produit;
END //
DELIMITER ;


-- updat
DELIMITER //
CREATE PROCEDURE mettreAJourProduit (
    IN p_id_produit INT,
    IN p_nom_produit VARCHAR(100),
    IN p_description VARCHAR(100),
    IN p_quantite INT,
    IN p_prix DECIMAL(10,2),
    IN p_categorie VARCHAR(30)
)
BEGIN
    UPDATE produit
    SET nom_produit = p_nom_produit,
        description = p_description,
        quantite = p_quantite,
        prix = p_prix,
        categorie = p_categorie
    WHERE id_produit = p_id_produit;
END //
DELIMITER ;


-- delete
DELIMITER //
CREATE PROCEDURE supprimerProduit (
    IN p_id_produit INT
)
BEGIN
    DELETE FROM produit WHERE id_produit = p_id_produit;
END //
DELIMITER ;


-- CRUD POUR stock_total

-- read
DELIMITER //
CREATE PROCEDURE obtenirStockTotal ()
BEGIN
    SELECT * FROM stock_total WHERE id_stock_total = 1;
END //
DELIMITER ;


-- updat
DELIMITER //
CREATE PROCEDURE mettreAJourStockTotal (
    IN p_total_stock INT
)
BEGIN
    UPDATE stock_total
    SET total_stock = p_total_stock,
        derniere_maj = CURDATE()
    WHERE id_stock_total = 1;
END //
DELIMITER ;


-- calculer et mettre à jour le stock total
DELIMITER //
CREATE PROCEDURE calculerStockTotal ()
BEGIN
    DECLARE total INT;

    SELECT SUM(quantite) INTO total FROM produit;

    UPDATE stock_total
    SET total_stock = total,
        derniere_maj = CURDATE()
    WHERE id_stock_total = 1;
END //
DELIMITER ;


-- Pocédures pour accéder au données des autres modules (achat et ventes)

DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS stock_total;
DROP TABLE IF EXISTS Achat;
DROP TABLE IF EXISTS achat_produit;

CREATE TABLE produit (
    id_produit INT AUTO_INCREMENT PRIMARY KEY,
    nom_produit VARCHAR(100) NOT NULL,
    description VARCHAR(100), 
    quantite INT,
    prix DECIMAL(10,2) NOT NULL,
    categorie VARCHAR(30)
);

CREATE TABLE stock_total (
    id_stock_total INT AUTO_INCREMENT PRIMARY KEY,
    total_stock INT NOT NULL,
    derniere_maj DATE NOT NULL
);


-- achat
CREATE TABLE Achat (
    id_achat INT AUTO_INCREMENT PRIMARY KEY,
    date_achat DATE NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    fournisseur VARCHAR(100) NOT NULL,
    FOREIGN KEY(id_produit) REFERENCES produit(id_produit) 
);


-- table de liaison achat-produit (relation plusieurs-plusieurs entre achats et produits )
CREATE TABLE achat_produit (
    id_achat INT NOT NULL,
    id_produit INT NOT NULL,
    quantite INT NOT NULL,
    PRIMARY KEY (id_achat, id_produit),
    FOREIGN KEY(id_achat) REFERENCES achat(id_achat),
    FOREIGN KEY(id_produit) REFERENCES produit(id_produit)
);



-- valeur initiale dans stock_total afin de pouvoir mettre a jour 
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
DELIMITER //
CREATE PROCEDURE calculerStockProduit (
    IN p_id_produit INT
)
BEGIN
    DECLARE total_achats INT DEFAULT 0;
    DECLARE total_ventes INT DEFAULT 0;

    --Total des achats poour ce produit (en utilsants table achat_produit)
    SELECT IFNULL(SUM(quantite), 0) INTO total_achats
    FROM achat_produit
    WHERE id_produit = p_id_produit;

    -- Total des ventes pour ce produit (en utilisant table Ligne_bon) 
    SELECT IFNULL(SUM(quantité), 0) INTO total_ventes
    FROM Ligne_bon
    WHERE Id_Produit = p_id_produit;

    -- Mettre à jour le stock du produit
    UPDATE produit
    SET quantite = total_achats - total_ventes
    WHERE id_produit = p_id_produit;

    -- Mettre a jour le stock total 
    CALL calculerStockTotal();
END //
DELIMITER ;



-- Trigger

DELIMITER //
CREATE TRIGGER after_produit_insert
AFTER INSERT ON produit
FOR EACH ROW
BEGIN
    CALL calculerStockTotal();
END //


CREATE TRIGGER after_produit_update
AFTER UPDATE ON produit
FOR EACH ROW
BEGIN
    CALL calculerStockTotal();
END //


CREATE TRIGGER after_produit_delete
AFTER DELETE ON produit
FOR EACH ROW
BEGIN
    CALL calculerStockTotal();
END //
DELIMITER ;


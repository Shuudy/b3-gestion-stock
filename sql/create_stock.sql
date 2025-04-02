DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS stock_total;

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


<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250423125322 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            CREATE TABLE achat (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date DATE NOT NULL, montant NUMERIC(10, 2) NOT NULL, fournisseur VARCHAR(100) NOT NULL)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE achat_produit (produit_id INTEGER NOT NULL, achat_id INTEGER NOT NULL, PRIMARY KEY(produit_id), CONSTRAINT FK_C26FA378F347EFB FOREIGN KEY (produit_id) REFERENCES produit (id) NOT DEFERRABLE INITIALLY IMMEDIATE, CONSTRAINT FK_C26FA378FE95D117 FOREIGN KEY (achat_id) REFERENCES produit (id) NOT DEFERRABLE INITIALLY IMMEDIATE)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE INDEX IDX_C26FA378FE95D117 ON achat_produit (achat_id)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE produit (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nom VARCHAR(100) NOT NULL, description VARCHAR(100) DEFAULT NULL, quantite INTEGER NOT NULL, prix NUMERIC(10, 2) NOT NULL, categorie VARCHAR(30) NOT NULL)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE stock_total (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, total_stock INTEGER NOT NULL, derniere_maj DATE NOT NULL)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE TABLE messenger_messages (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, body CLOB NOT NULL, headers CLOB NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at DATETIME NOT NULL --(DC2Type:datetime_immutable)
            , available_at DATETIME NOT NULL --(DC2Type:datetime_immutable)
            , delivered_at DATETIME DEFAULT NULL --(DC2Type:datetime_immutable)
            )
        SQL);
        $this->addSql(<<<'SQL'
            CREATE INDEX IDX_75EA56E0FB7336F0 ON messenger_messages (queue_name)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE INDEX IDX_75EA56E0E3BD61CE ON messenger_messages (available_at)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE INDEX IDX_75EA56E016BA31DB ON messenger_messages (delivered_at)
        SQL);
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            DROP TABLE achat
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE achat_produit
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE produit
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE stock_total
        SQL);
        $this->addSql(<<<'SQL'
            DROP TABLE messenger_messages
        SQL);
    }
}

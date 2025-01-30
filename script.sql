-- 0. TypeProduit
CREATE TABLE TypeProduit (
    id_type_produit SERIAL PRIMARY KEY,
    designation VARCHAR(255) NOT NULL
);

INSERT INTO TypeProduit (designation) VALUES ('Pain');
INSERT INTO TypeProduit (designation) VALUES ('Gateau');
INSERT INTO TypeProduit (designation) VALUES ('Viennoiserie');


-- 0-1. TypeIngredient
CREATE TABLE TypeIngredient (
    id_type_ingredient SERIAL PRIMARY KEY,
    designation VARCHAR(255) NOT NULL
);

INSERT INTO typeIngredient (designation) VALUES ('Type Gay');
INSERT INTO typeIngredient (designation) VALUES ('Type Normal');

CREATE TABLE Saveur (
    id_saveur SERIAL PRIMARY KEY,
    designation VARCHAR(255) NOT NULL
);

INSERT INTO Saveur (designation) VALUES ('Nature');
INSERT INTO Saveur (designation) VALUES ('Vanille');
INSERT INTO Saveur (designation) VALUES ('fraise');


-- 0-2. Unite
CREATE TABLE Unite (
    id_unite SERIAL PRIMARY KEY,
    designation VARCHAR(255) NOT NULL
);

INSERT INTO Unite (designation) VALUES ('Litre');
INSERT INTO Unite (designation) VALUES ('Kilogramme');
INSERT INTO Unite (designation) VALUES ('Gramme');
INSERT INTO Unite (designation) VALUES ('Piece');
INSERT INTO Unite (designation) VALUES ('Sachet');
INSERT INTO Unite (designation) VALUES ('Pince');


-- 2. Ingrédient
CREATE TABLE Ingredient (
    id_ingredient SERIAL PRIMARY KEY,
    nom_ingredient VARCHAR(255) NOT NULL,
    id_type_ingredient INT NOT NULL,
    quantite_en_stock NUMERIC NOT NULL,
    prix_unitaire NUMERIC NOT NULL,
    id_unite INT NOT NULL,
    FOREIGN KEY (id_type_ingredient) REFERENCES TypeIngredient(id_type_ingredient),
    FOREIGN KEY (id_unite) REFERENCES Unite(id_unite)
);


-- 3. Recette
CREATE TABLE Recette (
    id_recette SERIAL PRIMARY KEY,
    temps_preparation INT NOT NULL
);

-- 3-1. RecetteFille
CREATE TABLE RecetteFille (
    id_recette_fille SERIAL PRIMARY KEY,
    id_recette INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite_necessaire NUMERIC NOT NULL,
    FOREIGN KEY (id_recette) REFERENCES Recette(id_recette),
    FOREIGN KEY (id_ingredient) REFERENCES Ingredient(id_ingredient)
);

-- 1. Produit
CREATE TABLE Produit (
    id_produit SERIAL PRIMARY KEY,
    nom_produit VARCHAR(255) NOT NULL,
    id_type_produit INT NOT NULL,
    duree_vie NUMERIC NOT NULL,
    FOREIGN KEY (id_type_produit) REFERENCES TypeProduit(id_type_produit)
);

create table saveurProduit(
    id_saveur_produit SERIAL PRIMARY KEY,
    id_produit INT,
    id_saveur INT,
    id_recette INT,
    prix_unitaire NUMERIC,
    quantite_en_stock NUMERIC,
    FOREIGN KEY (id_produit) REFERENCES Produit(id_produit),
    FOREIGN KEY (id_saveur) REFERENCES Saveur(id_saveur),
    FOREIGN KEY (id_recette) REFERENCES Recette(id_recette)
);

CREATE TABLE ChangementPrix (
    id_changement_prix SERIAL PRIMARY KEY,
    oldPrix numeric not null,
    newPrix numeric not null,
    id_saveur_produit int references saveurProduit(id_saveur_produit),
    date_changement date
);

-- 1-1. FabricationProduit
CREATE TABLE FabricationProduit (
    id_fabrication_produit SERIAL PRIMARY KEY,
    date_action DATE NOT NULL
);

-- 1-2. FabricationProduitFille
CREATE TABLE FabricationProduitFille (
    id_fabrication_produit_fille SERIAL PRIMARY KEY,
    id_fabrication_produit INT NOT NULL,
    id_saveur_produit INT NOT NULL,
    quantite_fabrique NUMERIC NOT NULL,
    FOREIGN KEY (id_fabrication_produit) REFERENCES FabricationProduit(id_fabrication_produit),
    FOREIGN KEY (id_saveur_produit) REFERENCES saveurProduit(id_saveur_produit)
);

-- 4. Client
CREATE TABLE Client (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL
);

INSERT INTO client (nom, contact) VALUES ('Anjara', '123456789');
INSERT INTO client (nom, contact) VALUES ('Tonny', '0341456141');

-- 5. VenteProduit
CREATE TABLE VenteProduit (
    id_vente SERIAL PRIMARY KEY,
    id_client INT NOT NULL,
    date_vente DATE NOT NULL,
    id_vendeur INT REFERENCES Vendeur(id_vendeur),
    total NUMERIC NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Client(id_client)
);

-- 5-1. DetailVenteProduit
CREATE TABLE DetailVenteProduit (
    id_detail_vente SERIAL PRIMARY KEY,
    id_vente INT NOT NULL,
    id_saveur_produit INT NOT NULL,
    quantite_vendue NUMERIC NOT NULL,
    prix_unitaire NUMERIC NOT NULL,
    FOREIGN KEY (id_vente) REFERENCES VenteProduit(id_vente),
    FOREIGN KEY (id_saveur_produit) REFERENCES saveurProduit(id_saveur_produit)
);



-- 8. Fournisseur
CREATE TABLE Fournisseur (
    id_fournisseur SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL
);

INSERT INTO Fournisseur (nom , contact) VALUES ('fournisseur A', 'contact A');

-- 6. AchatIngredient
CREATE TABLE AchatIngredient (
    id_achat SERIAL PRIMARY KEY,
    id_fournisseur INT NOT NULL,
    date_achat DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id_fournisseur)
);

-- 6-1. DetailAchatIngredient
CREATE TABLE DetailAchatIngredient (
    id_achat_ingredient SERIAL PRIMARY KEY,
    id_achat INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite_achetee NUMERIC NOT NULL,
    prix_unitaire NUMERIC NOT NULL,
    FOREIGN KEY (id_achat) REFERENCES AchatIngredient(id_achat),
    FOREIGN KEY (id_ingredient) REFERENCES Ingredient(id_ingredient)
);

-- 7. Creance
CREATE TABLE Creance (
    id_creance SERIAL PRIMARY KEY,
    id_client INT NOT NULL,
    montant_du NUMERIC NOT NULL,
    date_echeance DATE NOT NULL,
    id_vente INT NOT NULL,
    statut VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Client(id_client),
    FOREIGN KEY (id_vente) REFERENCES VenteProduit(id_vente)
);

-- 9. MvtStockProduit
CREATE TABLE MvtStockProduit (
    id_mvt_stock_produit SERIAL PRIMARY KEY,
    date_action DATE NOT NULL,
    id_vente_produit INT,
    id_fabrication INT,
    FOREIGN KEY (id_vente_produit) REFERENCES VenteProduit(id_vente),
    FOREIGN KEY (id_fabrication) REFERENCES FabricationProduit(id_fabrication_produit)
);

-- 9-1. MvtStockProduitFille
CREATE TABLE MvtStockProduitFille (
    id_mvt_stock_produit_fille SERIAL PRIMARY KEY,
    id_mvt_stock_produit INT NOT NULL,
    entree NUMERIC NOT NULL,
    sortie NUMERIC NOT NULL,
    nouveau_quantite NUMERIC NOT NULL,
    id_saveur_produit INT NOT NULL,
    date_expiration DATE,
    FOREIGN KEY (id_mvt_stock_produit) REFERENCES MvtStockProduit(id_mvt_stock_produit),
    FOREIGN KEY (id_saveur_produit) REFERENCES saveurProduit(id_saveur_produit)
);

-- 10. MvtStockIngredient
CREATE TABLE MvtStockIngredient (
    id_mvt_stock_ingredient SERIAL PRIMARY KEY,
    date_action DATE NOT NULL
);

-- 10-1. MvtStockIngredientFille
CREATE TABLE MvtStockIngredientFille (
    id_mvt_stock_ingredient_fille SERIAL PRIMARY KEY,
    id_mvt_stock_ingredient INT NOT NULL,
    entree NUMERIC NOT NULL,
    sortie NUMERIC NOT NULL,
    nouveau_quantite NUMERIC NOT NULL,
    id_ingredient INT NOT NULL,
    FOREIGN KEY (id_mvt_stock_ingredient) REFERENCES MvtStockIngredient(id_mvt_stock_ingredient),
    FOREIGN KEY (id_ingredient) REFERENCES Ingredient(id_ingredient)
);

-- 11. Global
CREATE TABLE Global (
    id_global SERIAL PRIMARY KEY,
    nom_company VARCHAR(255) NOT NULL,
    caisse_actuel NUMERIC NOT NULL
);

-- 11-1. MouvementCaisse
CREATE TABLE MvtCaisse (
    id_mvt_caisse SERIAL PRIMARY KEY,
    entree NUMERIC,
    sortie NUMERIC,
    date_action DATE NOT NULL,
    nouveau_caisse NUMERIC NOT NULL
);


CREATE TABLE ConseilMois(
    id_conseil_mois SERIAL PRIMARY KEY,
    id_saveur_produit INT REFERENCES saveurProduit(id_saveur_produit),
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL
);

-- Fonction pour vérifier si un produit est déjà inséré dans l'intervalle de dates spécifié
CREATE OR REPLACE FUNCTION isProduitDejaInserer(idProduit INT, dateDebut DATE, dateFin DATE)
RETURNS BOOLEAN AS $$
DECLARE
existe BOOLEAN;
BEGIN
    -- Vérifier si l'intervalle des dates chevauche une entrée existante pour ce produit
SELECT EXISTS(
    SELECT 1
    FROM ConseilMois
    WHERE id_saveur_produit = idProduit
      AND (
        -- L'intervalle des dates de la nouvelle insertion chevauche les dates existantes
        (date_debut < dateFin AND date_fin > dateDebut)
        )
) INTO existe;

-- Retourner vrai si une entrée existe, sinon faux
RETURN existe;
END;
$$ LANGUAGE plpgsql;

   CREATE OR REPLACE FUNCTION checkProduitDate()
RETURNS TRIGGER AS $$
BEGIN
    -- Appel de la fonction pour vérifier si le produit a déjà été inséré dans l'intervalle de dates
    IF isProduitDejaInserer(NEW.id_saveur_produit, NEW.date_debut, NEW.date_fin) THEN
        -- Si la fonction retourne TRUE, on génère une exception
        RAISE EXCEPTION 'Produit % déjà inséré dans cet intervalle de dates!', NEW.id_saveur_produit;
END IF;

    -- Si le produit n'est pas encore inséré, on continue l'insertion
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_conseilmois
    BEFORE INSERT ON ConseilMois
    FOR EACH ROW
    EXECUTE PROCEDURE checkProduitDate();

-- DROP TRIGGER IF EXISTS before_insert_conseilmois ON ConseilMois;

CREATE VIEW v_client_stat AS
SELECT
    c.id_client,
    SUM(v.total) AS total
FROM
    Client c
        LEFT JOIN
    VenteProduit v ON c.id_client = v.id_client
GROUP BY
    c.id_client;

CREATE TABLE Genre (
    id_genre SERIAL PRIMARY KEY ,
    designation VARCHAR(50) NOT NULL
);

INSERT INTO Genre (designation) values ('Homme');
INSERT INTO Genre (designation) values ('Femme');


CREATE TABLE Vendeur (
     id_vendeur SERIAL PRIMARY KEY,
     nom VARCHAR(50) NOT NULL,
     id_genre INT REFERENCES Genre(id_genre)
);

INSERT INTO Vendeur (nom) values ('Vendeur A');
INSERT INTO Vendeur (nom) values ('Vendeur B');


CREATE TABLE VendeurCommission (
   id_vendeur_commission SERIAL PRIMARY KEY,
   id_vendeur INT REFERENCES Vendeur(id_vendeur),
   id_vente INT REFERENCES VenteProduit(id_vente),
   value NUMERIC NOT NULL,
   date_vente DATE NOT NULL
);

CREATE OR REPLACE FUNCTION get_vendeur_commissions(start_date DATE, end_date DATE)
    RETURNS TABLE (id_vendeur INT, total_value NUMERIC) AS $$
BEGIN
    RETURN QUERY
        SELECT
            v.id_vendeur,
            COALESCE(SUM(vc.value), 0) AS total_value
        FROM
            Vendeur v
                LEFT JOIN
            VendeurCommission vc
            ON v.id_vendeur = vc.id_vendeur
                AND vc.date_vente BETWEEN start_date AND end_date
        GROUP BY
            v.id_vendeur
        ORDER BY
            v.id_vendeur;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calculer_somme_par_genre(date_debut DATE, date_fin DATE)
RETURNS TABLE (
    homme NUMERIC,
    femme NUMERIC
) AS $$
BEGIN
RETURN QUERY
SELECT
    SUM(CASE WHEN g.id_genre = 1 THEN vc.value ELSE 0 END) AS homme,
    SUM(CASE WHEN g.id_genre = 2 THEN vc.value ELSE 0 END) AS femme
FROM
    VendeurCommission vc
        JOIN
    Vendeur v ON vc.id_vendeur = v.id_vendeur
        JOIN
    Genre g ON v.id_genre = g.id_genre
WHERE
    vc.date_vente BETWEEN date_debut AND date_fin;
END;
$$ LANGUAGE plpgsql;



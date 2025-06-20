
CREATE TABLE ind_colleges (
    id SERIAL PRIMARY KEY,
    num_ligne INTEGER,
    annee DATE NOT NULL,
    uai VARCHAR(20) NOT NULL,
    nom_de_letablissement VARCHAR(255),
    commune VARCHAR(100),
    region_academique VARCHAR(50),
    academie VARCHAR(50),
    departement VARCHAR(100),
    secteur VARCHAR(10),
    nb_candidats_g INTEGER,
    taux_de_reussite_g DECIMAL(5,1),
    va_du_taux_de_reussite_g DECIMAL(5,1),
    note_a_lecrit_g DECIMAL(4,1),
    va_de_la_note_g DECIMAL(4,1),
    taux_dacces_6eme_3eme DECIMAL(5,1),
    part_presents_3eme_ordinaire_total DECIMAL(5,1),
    nb_mentions_ab_g INTEGER,
    nb_mentions_b_g INTEGER,
    nb_mentions_tb_g INTEGER,
    nb_mentions_global_g INTEGER
);
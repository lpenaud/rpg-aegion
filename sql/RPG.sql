CREATE TABLE IF NOT EXISTS INVENTAIRE_PERSONNAGE
 (
   ID_INVENTAIRE INTEGER PRIMARY KEY ,
   ID_PERSONNAGE INTEGER NOT NULL  ,
   NB_EMPLACEMENT INTEGER NULL,
   FOREIGN KEY (ID_PERSONNAGE) REFERENCES PERSONNAGE(ID_PERSONNAGE)
 );

CREATE TABLE IF NOT EXISTS CLASSE_PERSONNAGE
 (
   ID_CLASSE INTEGER PRIMARY KEY ,
   ID_STAT_PERSONNAGE_A_DES INTEGER NOT NULL  ,
   ID_STAT_MULTIPLICATEUR INTEGER NOT NULL  ,
   NOM_CLASSE TEXT NULL  ,
   TYPE_CLASSE TEXT NULL  ,
   ID_STAT_PERSONNAGE INTEGER NULL  ,
   ID_CLASSE_PARENT INTEGER NULL ,
   FOREIGN KEY (ID_STAT_PERSONNAGE) REFERENCES DEBUT_STAT_PERSONNAGE (ID_STAT_PERSONNAGE),
   FOREIGN KEY (ID_STAT_MULTIPLICATEUR) REFERENCES MULTIPLICATEUR (ID_STAT_MULTIPLICATEUR)
 );

CREATE TABLE IF NOT EXISTS STAT_PERSONNAGE
 (
   ID_STAT_PERSONNAGE INTEGER PRIMARY KEY ,
   PV_PERSONNAGE INTEGER NULL  ,
   VITALITE_PERSONNAGE INTEGER NULL  ,
   ARMURE_PERSONNAGE INTEGER NULL  ,
   FORCE_PERSONNAGE INTEGER NULL  ,
   INTELLIGENCE_PERSONNAGE INTEGER NULL  ,
   DEXTERITE_PERSONNAGE INTEGER NULL  ,
   ENDURANCE_PERSONNAGE INTEGER NULL  ,
   MANA_PERSONNAGE INTEGER NULL  ,
   ENERGIE_PERSONNAGE INTEGER NULL  ,
   DEGAT_CRITIQUE_PERSONNAGE NUMERIC NULL
 );


CREATE TABLE IF NOT EXISTS MULTIPLICATEUR
 (
   ID_STAT_MULTIPLICATEUR INTEGER PRIMARY KEY ,
   PV_MULTIPLICATEUR INTEGER NULL  ,
   VITALITE_MULTIPLICATEUR INTEGER NULL  ,
   ARMURE_MULTIPLICATEUR INTEGER NULL  ,
   FORCE_MULTIPLICATEUR INTEGER NULL  ,
   INTELLIGENCE_MULTIPLICATEUR INTEGER NULL  ,
   DEXTERITE_MULTIPLICATEUR INTEGER NULL  ,
   ENDURANCE_MULTIPLICATEUR INTEGER NULL  ,
   MANA_MULTIPLICATEUR INTEGER NULL  ,
   ENERGIE_MULTIPLICATEUR INTEGER NULL  ,
   DEGAT_CRITIQUE_PERSONNAGE NUMERIC NULL
 );


CREATE TABLE IF NOT EXISTS OBJET
 (
   ID_OBJET INTEGER PRIMARY KEY ,
   NOM_OBJET TEXT NULL  ,
   DEGATS_OBJET TEXT NULL  ,
   ARMURE_OBJET INTEGER NULL  ,
   DESC_OBJET TEXT NULL  ,
   IMAGE_OBJET TEXT NULL  ,
   ID_TYPE_OBJET INTEGER NULL  ,
   ID_RARETE_OBJET INTEGER NULL  ,
   ID_DEGAT_OBJET INTEGER NULL ,
   ID_EFFET INTEGER NULL ,
   FOREIGN KEY (ID_EFFET) REFERENCES EFFET(ID_EFFET) ,
   FOREIGN KEY (ID_TYPE_OBJET) REFERENCES TYPE_OBJET (ID_TYPE_OBJET) ,
   FOREIGN KEY (ID_RARETE_OBJET) REFERENCES RARETE_OBJET (ID_RARETE_OBJET)
 );

CREATE TABLE IF NOT EXISTS EFFET
 (
   ID_EFFET INTEGER PRIMARY KEY ,
   NOM_EFFET TEXT NULL
 );

CREATE TABLE IF NOT EXISTS DEBUT_STAT_PERSONNAGE
 (
   ID_STAT_PERSONNAGE INTEGER PRIMARY KEY ,
   PV_PERSONNAGE INTEGER NULL  ,
   VITALITE_PERSONNAGE INTEGER NULL  ,
   ARMURE_PERSONNAGE INTEGER NULL  ,
   FORCE_PERSONNAGE INTEGER NULL  ,
   INTELLIGENCE_PERSONNAGE INTEGER NULL  ,
   DEXTERITE_PERSONNAGE INTEGER NULL  ,
   ENDURANCE_PERSONNAGE INTEGER NULL  ,
   MANA_PERSONNAGE INTEGER NULL  ,
   ENERGIE_PERSONNAGE INTEGER NULL  ,
   DEGAT_CRITIQUE_PERSONNAGE NUMERIC NULL
 );

CREATE TABLE IF NOT EXISTS PERSONNAGE
 (
   ID_PERSONNAGE INTEGER PRIMARY KEY ,
   ID_ENNEMIE INTEGER NULL  ,
   ID_STAT_PERSONNAGE_POSSÈDE_DES INTEGER NOT NULL  ,
   NOM_PERSONNAGE TEXT NULL  ,
   PRENOM_PERSONNAGE TEXT NULL  ,
   AGE_PERSONNAGE INTEGER NULL  ,
   BIO_PERSONNAGE TEXT NULL  ,
   SEXE_PERSONNAGE TEXT NULL  ,
   RACE_PERSONNAGE TEXT NULL  ,
   TAILLE_PERSONNAGE TEXT NULL  ,
   IMAGE_PERSONNAGE TEXT NULL  ,
   ID_CLASSE INTEGER NULL  ,
   ID_INVENTAIRE INTEGER NULL  ,
   ID_STAT_PERSONNAGE INTEGER NULL  ,
   FOREIGN KEY (ID_CLASSE) REFERENCES CLASSE_PERSONNAGE (ID_CLASSE) ,
   FOREIGN KEY (ID_ENNEMIE) REFERENCES ENNEMIE (ID_ENNEMIE) ,
   FOREIGN KEY (ID_STAT_PERSONNAGE) REFERENCES STAT_PERSONNAGE (ID_STAT_PERSONNAGE),
   FOREIGN KEY (ID_INVENTAIRE) REFERENCES STAT_PERSONNAGE (ID_STAT_PERSONNAGE)
 );

CREATE TABLE IF NOT EXISTS ANATOMIE
 (
	ID_ANATOMIE INTEGER PRIMARY KEY ,
	NOM INTEGER NOT NULL
 );

CREATE TABLE IF NOT EXISTS EQUIPEMENT
 (
	ID_ANATOMIE INTEGER ,
	ID_PERSONNAGE INTEGER NULL ,
	ID_OBJET INTEGER NULL ,
	PRIMARY KEY(ID_ANATOMIE, ID_PERSONNAGE) ,
	FOREIGN KEY (ID_ANATOMIE) REFERENCES ANATOMIE (ID_ANATOMIE) ,
	FOREIGN KEY (ID_PERSONNAGE) REFERENCES PERSONNAGE (ID_PERSONNAGE)
 );

CREATE TABLE IF NOT EXISTS TYPE_DEGAT_OBJET
 (
   ID_DEGAT_OBJET INTEGER PRIMARY KEY ,
   NOM_DEGAT_OBJET TEXT NULL  ,
   DESC_DEGAT_OBJET TEXT NULL
 );

CREATE TABLE IF NOT EXISTS USERS
 (
   LOGIN TEXT PRIMARY KEY ,
   PASSWORD TEXT NULL
 );

CREATE TABLE IF NOT EXISTS USERS
 (
   LOGIN TEXT ,
   ID_PERSONNAGE INTEGER ,
   PRIMARY KEY (ID_USERS, ID_PERSONNAGE),
   FOREIGN KEY (LOGIN) REFERENCES USERS (LOGIN),
   FOREIGN KEY (ID_PERSONNAGE) REFERENCES PERSONNAGE (ID_PERSONNAGE)
 );

CREATE TABLE IF NOT EXISTS STAT_ENNEMIE
 (
   ID_STAT_ENNEMIE INTEGER PRIMARY KEY ,
   PV_ENNEMIE INTEGER NULL  ,
   ARMURE_ENNEMIE INTEGER NULL  ,
   DEGATS_ENNEMIE INTEGER NULL  ,
   DEGATS_CRITIQUE_ENNEMIE NUMERIC NULL  ,
   TAUX_CRITIQUE_ENNEMIE NUMERIC NULL
 );


CREATE TABLE IF NOT EXISTS ENNEMIE
 (
   ID_ENNEMIE INTEGER PRIMARY KEY ,
   ID_STAT_ENNEMIE INTEGER NOT NULL  ,
   ID_PERSONNAGE INTEGER NOT NULL  ,
   NOM_ENNEMIE TEXT NULL  ,
   DESC_ENNEMIE TEXT NULL  ,
   IMAGE_ENNEMIE TEXT NULL  ,
   TAILLE_ENNEMIE TEXT NULL  ,
   ID_TYPE_ENNEMIE INTEGER NULL  ,
   TAUX_MIN_EXP_ENNEMIE INTEGER NULL  ,
   TAUX_MAX_EXP_ENNEMIE INTEGER NULL  ,
   TAUX_MIN_OR_ENNEMIE INTEGER NULL  ,
   TAUX_MAX_OR_ENNEMIE INTEGER NULL  ,
   EST_BOSS INTEGER NULL  ,
   FOREIGN KEY(ID_STAT_ENNEMIE) REFERENCES STAT_ENNEMIE (ID_STAT_ENNEMIE) ,
   FOREIGN KEY(ID_PERSONNAGE) REFERENCES PERSONNAGE (ID_PERSONNAGE)
 );

CREATE TABLE IF NOT EXISTS TYPE_OBJET
 (
   ID_TYPE_OBJET INTEGER PRIMARY KEY ,
   NOM_TYPE_OBJET TEXT NULL
 );

CREATE TABLE IF NOT EXISTS TYPE_ENNEMIE
 (
   ID_TYPE_ENNEMIE INTEGER PRIMARY KEY ,
   ID_DEGAT_OBJET INTEGER NOT NULL  ,
   ID_DEGAT_OBJET_RESITANCE INTEGER NOT NULL  ,
   ID_ENNEMIE INTEGER NOT NULL  ,
   NOM_TYPE_ENNEMIE TEXT NULL  ,
   ID_FAIBLESSE_ENNEMIE INTEGER NULL  ,
   ID_FORCE_ENNEMIE TEXT NULL ,
   FOREIGN KEY (ID_DEGAT_OBJET) REFERENCES TYPE_DEGAT_OBJET (ID_DEGAT_OBJET) ,
   FOREIGN KEY (ID_DEGAT_OBJET_RESITANCE) REFERENCES TYPE_DEGAT_OBJET (ID_DEGAT_OBJET_RESITANCE) ,
   FOREIGN KEY (ID_ENNEMIE) REFERENCES ENNEMIE (ID_ENNEMIE)
 );

CREATE TABLE IF NOT EXISTS RARETE_OBJET
 (
   ID_RARETE_OBJET INTEGER PRIMARY KEY ,
   NOM_RARETE_OBJET TEXT NULL  ,
   COULEUR_RARETE_OBJET TEXT NULL  ,
   TAUX_RARETE_OBJET NUMERIC NULL
 );

CREATE TABLE IF NOT EXISTS SONT_AFFECTEES_A
 (
   ID_DEGAT_OBJET INTEGER ,
   ID_OBJET INTEGER NOT NULL ,
   PRIMARY KEY (ID_DEGAT_OBJET, ID_OBJET) ,
   FOREIGN KEY (ID_DEGAT_OBJET) REFERENCES TYPE_DEGAT_OBJET (ID_DEGAT_OBJET) ,
   FOREIGN KEY (ID_OBJET) REFERENCES OBJET (ID_OBJET)
 );

CREATE TABLE IF NOT EXISTS POSSEDE
 (
   ID_INVENTAIRE INTEGER ,
   ID_OBJET INTEGER ,
   FOIS INTEGER NULL ,
   PRIMARY KEY (ID_INVENTAIRE, ID_OBJET) ,
   FOREIGN KEY (ID_OBJET) REFERENCES OBJET (ID_OBJET) ,
   FOREIGN KEY (ID_INVENTAIRE) REFERENCES INVENTAIRE_PERSONNAGE (ID_INVENTAIRE)
 );

CREATE TABLE IF NOT EXISTS LOOT
 (
   ID_ENNEMIE INTEGER PRIMARY KEY ,
   ID_OBJET INTEGER NOT NULL  ,
   TAUX NUMERIC NULL ,
   FOREIGN KEY (ID_ENNEMIE) REFERENCES ENNEMIE (ID_ENNEMIE) ,
   FOREIGN KEY (ID_OBJET) REFERENCES OBJET (ID_OBJET)
 );

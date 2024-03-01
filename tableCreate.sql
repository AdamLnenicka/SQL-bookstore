

--DROP TABLE druh CASCADE CONSTRAINTS;
--DROP TABLE exemplar CASCADE CONSTRAINTS;
--DROP TABLE jazyk CASCADE CONSTRAINTS;
--DROP TABLE klicove_slovo CASCADE CONSTRAINTS;
--DROP TABLE kniha CASCADE CONSTRAINTS;
--DROP TABLE oddeleni CASCADE CONSTRAINTS;
--DROP TABLE osoba CASCADE CONSTRAINTS;
--DROP TABLE vypujcka CASCADE CONSTRAINTS;
--DROP TABLE vyraz CASCADE CONSTRAINTS;
-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-04-18 16:07:45 SEL�
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE druh (
    id_druhu INTEGER NOT NULL,
    nazev    VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE druh ADD CONSTRAINT druh_pk PRIMARY KEY ( id_druhu );

CREATE TABLE exemplar (
    id_exemplare         INTEGER NOT NULL,
    poznamka             VARCHAR2(100 CHAR),
    kniha_id_knihy       INTEGER NOT NULL,
    osoba_id_osoby       INTEGER NOT NULL,
    oddeleni_id_oddeleni INTEGER NOT NULL
);

ALTER TABLE exemplar ADD CONSTRAINT exemplar_pk PRIMARY KEY ( id_exemplare );

CREATE TABLE jazyk (
    id_jazyku INTEGER NOT NULL,
    n�zev     VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE jazyk ADD CONSTRAINT jazyk_pk PRIMARY KEY ( id_jazyku );

CREATE TABLE klicove_slovo (
    vyraz_id_vyrazu INTEGER NOT NULL,
    kniha_id_knihy  INTEGER NOT NULL
);

ALTER TABLE klicove_slovo ADD CONSTRAINT klicove_slovo_pk PRIMARY KEY ( vyraz_id_vyrazu,
                                                                        kniha_id_knihy );

CREATE TABLE kniha (
    id_knihy        INTEGER NOT NULL,
    isbn            VARCHAR2(50 CHAR),
    nazev           VARCHAR2(250 CHAR),
    pocet_stran     INTEGER,
    rok_vydani      INTEGER,
    misto_vydani    VARCHAR2(150 CHAR),
    nakladatel      VARCHAR2(150 CHAR),
    vyd�n�          INTEGER,
    edice           VARCHAR2(150 CHAR),
    autor           VARCHAR2(150 CHAR),
    jazyk_id_jazyku INTEGER,
    druh_id_druhu   INTEGER
);

ALTER TABLE kniha ADD CONSTRAINT kniha_pk PRIMARY KEY ( id_knihy );

CREATE TABLE oddeleni (
    id_oddeleni INTEGER NOT NULL,
    nazev       VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE oddeleni ADD CONSTRAINT oddeleni_pk PRIMARY KEY ( id_oddeleni );

CREATE TABLE osoba (
    id_osoby INTEGER NOT NULL,
    login    VARCHAR2(30 CHAR) NOT NULL,
    jmeno    VARCHAR2(30 CHAR) NOT NULL,
    prijmeni VARCHAR2(30 CHAR) NOT NULL,
    heslo    VARCHAR2(50 CHAR) NOT NULL,
    email    VARCHAR2(40 CHAR)
);

ALTER TABLE osoba ADD CONSTRAINT osoba_pk PRIMARY KEY ( id_osoby );

ALTER TABLE osoba ADD CONSTRAINT osoba_login_un UNIQUE ( login );

CREATE TABLE vypujcka (
    id_vypujcky           INTEGER NOT NULL,
    datum_pujceni         DATE NOT NULL,
    vratit_do             DATE,
    skutecne_vraceno      DATE,
    poznamka              VARCHAR2(50 CHAR),
    exemplar_id_exempl��e INTEGER NOT NULL,
    osoba_id_osoby        INTEGER NOT NULL
);

ALTER TABLE vypujcka ADD CONSTRAINT vypujcka_pk PRIMARY KEY ( id_vypujcky );

CREATE TABLE vyraz (
    id_vyrazu INTEGER NOT NULL,
    text      VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE vyraz ADD CONSTRAINT vyraz_pk PRIMARY KEY ( id_vyrazu );

ALTER TABLE exemplar
    ADD CONSTRAINT exemplar_kniha_fk FOREIGN KEY ( kniha_id_knihy )
        REFERENCES kniha ( id_knihy );

ALTER TABLE exemplar
    ADD CONSTRAINT exemplar_oddeleni_fk FOREIGN KEY ( oddeleni_id_oddeleni )
        REFERENCES oddeleni ( id_oddeleni );

ALTER TABLE exemplar
    ADD CONSTRAINT exemplar_osoba_fk FOREIGN KEY ( osoba_id_osoby )
        REFERENCES osoba ( id_osoby );

ALTER TABLE klicove_slovo
    ADD CONSTRAINT klicove_slovo_kniha_fk FOREIGN KEY ( kniha_id_knihy )
        REFERENCES kniha ( id_knihy );

ALTER TABLE klicove_slovo
    ADD CONSTRAINT klicove_slovo_vyraz_fk FOREIGN KEY ( vyraz_id_vyrazu )
        REFERENCES vyraz ( id_vyrazu );

ALTER TABLE kniha
    ADD CONSTRAINT kniha_druh_fk FOREIGN KEY ( druh_id_druhu )
        REFERENCES druh ( id_druhu );

ALTER TABLE kniha
    ADD CONSTRAINT kniha_jazyk_fk FOREIGN KEY ( jazyk_id_jazyku )
        REFERENCES jazyk ( id_jazyku );

ALTER TABLE vypujcka
    ADD CONSTRAINT vypujcka_exemplar_fk FOREIGN KEY ( exemplar_id_exempl��e )
        REFERENCES exemplar ( id_exemplare );

ALTER TABLE vypujcka
    ADD CONSTRAINT vypujcka_osoba_fk FOREIGN KEY ( osoba_id_osoby )
        REFERENCES osoba ( id_osoby );


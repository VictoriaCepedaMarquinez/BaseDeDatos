-- Created by Redgate Data Modeler (https://datamodeler.redgate-platform.com)
-- Last modification date: 2026-03-30 18:40:51.073
-- Borrado seguro de Foreign Keys (opcional, pero recomendado si el motor lo pide)
ALTER TABLE IF EXISTS Autor DROP CONSTRAINT IF EXISTS Autor_Catalogo_libro;
ALTER TABLE IF EXISTS Con_carnet DROP CONSTRAINT IF EXISTS Con_carnet_Usuario;
ALTER TABLE IF EXISTS Prestamo DROP CONSTRAINT IF EXISTS Corresponde_a;
ALTER TABLE IF EXISTS Lo_integran DROP CONSTRAINT IF EXISTS Lo_integran_Ejemplar_lib;
ALTER TABLE IF EXISTS Lo_integran DROP CONSTRAINT IF EXISTS Lo_integran_Prestamo;
ALTER TABLE IF EXISTS Sin_carnet DROP CONSTRAINT IF EXISTS Sin_carnet_Usuario;
ALTER TABLE IF EXISTS Ejemplar_lib DROP CONSTRAINT IF EXISTS es_de;

-- Borrado seguro de Tablas
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Lo_integran;
DROP TABLE IF EXISTS Ejemplar_lib;
DROP TABLE IF EXISTS Prestamo;
DROP TABLE IF EXISTS Con_carnet;
DROP TABLE IF EXISTS Sin_carnet;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Catalogo_libro;
-- End of file.


-- Created by Redgate Data Modeler (https://datamodeler.redgate-platform.com)
-- Last modification date: 2026-03-30 18:40:51.073

-- tables
-- Table: Autor
CREATE TABLE Autor (
    Catalogo_libro_cod_catalogo int  NOT NULL,
    nombre varchar(20)  NOT NULL,
    CONSTRAINT Autor_pk PRIMARY KEY (Catalogo_libro_cod_catalogo)
);

-- Table: Catalogo_libro
CREATE TABLE Catalogo_libro (
    cod_catalogo int  NOT NULL,
    titulo varchar(20)  NOT NULL,
    formato varchar(20)  NOT NULL,
    editorial varchar(20)  NOT NULL,
    CONSTRAINT Catalogo_libro_pk PRIMARY KEY (cod_catalogo)
);

-- Table: Con_carnet
CREATE TABLE Con_carnet (
    nro_carnet int  NOT NULL,
    Usuario_id_usuario int  NOT NULL,
    CONSTRAINT Con_carnet_ak_1 UNIQUE (nro_carnet) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT Con_carnet_pk PRIMARY KEY (Usuario_id_usuario)
);

-- Table: Ejemplar_lib
CREATE TABLE Ejemplar_lib (
    nro_ejemplar int  NOT NULL,
    anio_edicion int  NOT NULL,
    nro_edicion int  NOT NULL,
    Catalogo_libro_cod_catalogo int  NOT NULL,
    CONSTRAINT Ejemplar_lib_pk PRIMARY KEY (nro_ejemplar)
);

-- Table: Lo_integran
CREATE TABLE Lo_integran (
    Prestamo_id_prestamo int  NOT NULL,
    Ejemplar_lib_nro_ejemplar int  NOT NULL,
    CONSTRAINT Lo_integran_pk PRIMARY KEY (Prestamo_id_prestamo,Ejemplar_lib_nro_ejemplar)
);

-- Table: Prestamo
CREATE TABLE Prestamo (
    id_prestamo int  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    Con_carnet_Usuario_id_usuario int  NOT NULL,
    CONSTRAINT Prestamo_pk PRIMARY KEY (id_prestamo)
);

-- Table: Sin_carnet
CREATE TABLE Sin_carnet (
    nro_celular int  NOT NULL,
    Usuario_id_usuario int  NOT NULL,
    CONSTRAINT Sin_carnet_pk PRIMARY KEY (Usuario_id_usuario)
);

-- Table: Usuario
CREATE TABLE Usuario (
    id_usuario int  NOT NULL,
    tipo_doc varchar(20)  NOT NULL,
    nro_doc int  NOT NULL,
    apellido varchar(20)  NOT NULL,
    nombre varchar(20)  NOT NULL,
    e_mail varchar(50)  NOT NULL,
    tipo_usuario varchar(20)  NOT NULL,
    CONSTRAINT Usuario_ak_1 UNIQUE (tipo_doc) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT Usuario_ak_2 UNIQUE (nro_doc) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT Usuario_pk PRIMARY KEY (id_usuario)
);

-- foreign keys
-- Reference: Autor_Catalogo_libro (table: Autor)
ALTER TABLE Autor ADD CONSTRAINT Autor_Catalogo_libro
    FOREIGN KEY (Catalogo_libro_cod_catalogo)
    REFERENCES Catalogo_libro (cod_catalogo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Con_carnet_Usuario (table: Con_carnet)
ALTER TABLE Con_carnet ADD CONSTRAINT Con_carnet_Usuario
    FOREIGN KEY (Usuario_id_usuario)
    REFERENCES Usuario (id_usuario)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Corresponde_a (table: Prestamo)
ALTER TABLE Prestamo ADD CONSTRAINT Corresponde_a
    FOREIGN KEY (Con_carnet_Usuario_id_usuario)
    REFERENCES Con_carnet (Usuario_id_usuario)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Lo_integran_Ejemplar_lib (table: Lo_integran)
ALTER TABLE Lo_integran ADD CONSTRAINT Lo_integran_Ejemplar_lib
    FOREIGN KEY (Ejemplar_lib_nro_ejemplar)
    REFERENCES Ejemplar_lib (nro_ejemplar)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Lo_integran_Prestamo (table: Lo_integran)
ALTER TABLE Lo_integran ADD CONSTRAINT Lo_integran_Prestamo
    FOREIGN KEY (Prestamo_id_prestamo)
    REFERENCES Prestamo (id_prestamo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Sin_carnet_Usuario (table: Sin_carnet)
ALTER TABLE Sin_carnet ADD CONSTRAINT Sin_carnet_Usuario
    FOREIGN KEY (Usuario_id_usuario)
    REFERENCES Usuario (id_usuario)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: es_de (table: Ejemplar_lib)
ALTER TABLE Ejemplar_lib ADD CONSTRAINT es_de
    FOREIGN KEY (Catalogo_libro_cod_catalogo)
    REFERENCES Catalogo_libro (cod_catalogo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.


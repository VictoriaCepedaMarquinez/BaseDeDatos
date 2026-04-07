-- ======================================================
-- 1. BORRADO DE TABLAS Y RESTRICCIONES AL INICIO
-- ======================================================

-- Eliminamos las restricciones (Foreign Keys) primero
ALTER TABLE Compone DROP CONSTRAINT IF EXISTS Compone_Producto_quimico1;
ALTER TABLE Compone DROP CONSTRAINT IF EXISTS Compone_Producto_quimico2;
ALTER TABLE Envio DROP CONSTRAINT IF EXISTS Envio_Cliente;
ALTER TABLE Pq_liquido DROP CONSTRAINT IF EXISTS Pq_liquido_Producto_quimico;
ALTER TABLE Pq_solido DROP CONSTRAINT IF EXISTS Pq_solido_Producto_quimico;
ALTER TABLE Envio DROP CONSTRAINT IF EXISTS contiene;
ALTER TABLE Cliente DROP CONSTRAINT IF EXISTS es_garante;

-- Eliminamos las tablas en orden inverso a su jerarquía
DROP TABLE IF EXISTS Pq_liquido;
DROP TABLE IF EXISTS Pq_solido;
DROP TABLE IF EXISTS Compone;
DROP TABLE IF EXISTS Envio;
DROP TABLE IF EXISTS Producto_quimico;
DROP TABLE IF EXISTS Cliente;


-- ======================================================
-- 2. CREACIÓN DE LAS TABLAS (CREATE TABLE)
-- ======================================================

-- Table: Cliente
CREATE TABLE Cliente (
    id_cliente int  NOT NULL,
    CUIT int  NOT NULL,
    apellido varchar(20)  NOT NULL,
    nombre varchar(20)  NOT NULL,
    direccion_calle varchar(20)  NOT NULL,
    direccion_puerta int  NOT NULL,
    direccion_piso int  NOT NULL,
    e_mail varchar(20)  NULL,
    telefono int  NOT NULL,
    garante int  NULL,
    CONSTRAINT Cliente_pk PRIMARY KEY (id_cliente)
);

-- Table: Producto_quimico
CREATE TABLE Producto_quimico (
    id_prod_quimico int  NOT NULL,
    nombre_prod_quimico varchar(20)  NOT NULL,
    formula varchar(20)  NOT NULL,
    tipo_pq varchar(20)  NOT NULL,
    CONSTRAINT Producto_quimico_pk PRIMARY KEY (id_prod_quimico)
);

-- Table: Compone
CREATE TABLE Compone (
    porcentaje int  NOT NULL,
    Producto_quimico_id_prod_quimico int  NOT NULL,
    Producto_quimico_2_id_prod_quimico int  NOT NULL,
    CONSTRAINT Compone_pk PRIMARY KEY (Producto_quimico_id_prod_quimico,Producto_quimico_2_id_prod_quimico)
);

-- Table: Envio
CREATE TABLE Envio (
    nro_envio int  NOT NULL,
    cantidad int  NOT NULL,
    peso decimal(20,20)  NOT NULL,
    Producto_quimico_id_prod_quimico int  NOT NULL,
    Cliente_id_cliente int  NOT NULL,
    CONSTRAINT Envio_pk PRIMARY KEY (nro_envio)
);

-- Table: Pq_liquido
CREATE TABLE Pq_liquido (
    inflamable boolean  NOT NULL,
    tipo_envase varchar(20)  NOT NULL,
    cond_traslado varchar(20)  NULL,
    Producto_quimico_id_prod_quimico int  NOT NULL,
    CONSTRAINT Pq_liquido_pk PRIMARY KEY (Producto_quimico_id_prod_quimico)
);

-- Table: Pq_solido
CREATE TABLE Pq_solido (
    forma varchar(20)  NOT NULL,
    empaque_maximo int  NOT NULL,
    Producto_quimico_id_prod_quimico int  NOT NULL,
    CONSTRAINT Pq_solido_pk PRIMARY KEY (Producto_quimico_id_prod_quimico)
);


-- ======================================================
-- 3. DEFINICIÓN DE CLAVES FORÁNEAS (FOREIGN KEYS)
-- ======================================================

ALTER TABLE Compone ADD CONSTRAINT Compone_Producto_quimico1
    FOREIGN KEY (Producto_quimico_id_prod_quimico)
    REFERENCES Producto_quimico (id_prod_quimico);

ALTER TABLE Compone ADD CONSTRAINT Compone_Producto_quimico2
    FOREIGN KEY (Producto_quimico_2_id_prod_quimico)
    REFERENCES Producto_quimico (id_prod_quimico);

ALTER TABLE Envio ADD CONSTRAINT Envio_Cliente
    FOREIGN KEY (Cliente_id_cliente)
    REFERENCES Cliente (id_cliente);

ALTER TABLE Pq_liquido ADD CONSTRAINT Pq_liquido_Producto_quimico
    FOREIGN KEY (Producto_quimico_id_prod_quimico)
    REFERENCES Producto_quimico (id_prod_quimico);

ALTER TABLE Pq_solido ADD CONSTRAINT Pq_solido_Producto_quimico
    FOREIGN KEY (Producto_quimico_id_prod_quimico)
    REFERENCES Producto_quimico (id_prod_quimico);

ALTER TABLE Envio ADD CONSTRAINT contiene
    FOREIGN KEY (Producto_quimico_id_prod_quimico)
    REFERENCES Producto_quimico (id_prod_quimico);

ALTER TABLE Cliente ADD CONSTRAINT es_garante
    FOREIGN KEY (garante)
    REFERENCES Cliente (id_cliente);

-- End of file.

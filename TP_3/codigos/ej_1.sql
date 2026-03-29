-- ======================================================
-- b) Realice el borrado de las tablas al inicio del script
-- ======================================================

-- Eliminamos las restricciones primero para evitar errores de integridad
ALTER TABLE Audio DROP CONSTRAINT IF EXISTS Audio_Objeto;
ALTER TABLE Documento DROP CONSTRAINT IF EXISTS Documento_Objeto;
ALTER TABLE Video DROP CONSTRAINT IF EXISTS Video_Objeto;
ALTER TABLE Objeto DROP CONSTRAINT IF EXISTS pertenece;
ALTER TABLE Objeto DROP CONSTRAINT IF EXISTS se_encuentra;

-- Eliminamos las tablas (en orden: primero las que tienen FKs, luego las maestras)
DROP TABLE IF EXISTS Audio;
DROP TABLE IF EXISTS Documento;
DROP TABLE IF EXISTS Video;
DROP TABLE IF EXISTS Objeto;
DROP TABLE IF EXISTS Coleccion;
DROP TABLE IF EXISTS Repositorio;

-- ======================================================
-- a) Creen las tablas que lo representan
-- ======================================================

-- Table: Audio
CREATE TABLE Audio (
    formato varchar(20)  NOT NULL,
    duracion int  NOT NULL,
    Objeto_id_objeto int  NOT NULL,
    CONSTRAINT Audio_pk PRIMARY KEY (Objeto_id_objeto)
);

-- Table: Coleccion
CREATE TABLE Coleccion (
    id_coleccion int  NOT NULL,
    titulo varchar(50)  NOT NULL,
    descripcion varchar(150)  NOT NULL,
    CONSTRAINT Coleccion_pk PRIMARY KEY (id_coleccion)
);

-- Table: Documento
CREATE TABLE Documento (
    tipo_publicacion varchar(20)  NOT NULL,
    modos_color varchar(20)  NOT NULL,
    resolucion_captura int  NOT NULL,
    Objeto_id_objeto int  NOT NULL,
    CONSTRAINT Documento_pk PRIMARY KEY (Objeto_id_objeto)
);

-- Table: Objeto
CREATE TABLE Objeto (
    id_objeto int  NOT NULL,
    titulo varchar(20)  NOT NULL,
    descripcion varchar(150)  NOT NULL,
    fuente varchar(20)  NOT NULL,
    fecha date  NOT NULL,
    Repositorio_id_repositorio int  NOT NULL,
    Coleccion_id_coleccion int  NOT NULL,
    tipo varchar(20)  NOT NULL,
    CONSTRAINT Objeto_pk PRIMARY KEY (id_objeto)
);

-- Table: Repositorio
CREATE TABLE Repositorio (
    id_repositorio int  NOT NULL,
    nombre varchar(20)  NOT NULL,
    publico boolean  NOT NULL,
    descripcion varchar(150)  NOT NULL,
    duenio varchar(20)  NULL,
    CONSTRAINT Repositorio_pk PRIMARY KEY (id_repositorio)
);

-- Table: Video
CREATE TABLE Video (
    resolucion int  NOT NULL,
    frames_x_segundo int  NOT NULL,
    Objeto_id_objeto int  NOT NULL,
    CONSTRAINT Video_pk PRIMARY KEY (Objeto_id_objeto)
);

-- ======================================================
-- Definición de Claves Foráneas (Foreign Keys)
-- ======================================================

ALTER TABLE Audio ADD CONSTRAINT Audio_Objeto
    FOREIGN KEY (Objeto_id_objeto)
    REFERENCES Objeto (id_objeto);

ALTER TABLE Documento ADD CONSTRAINT Documento_Objeto
    FOREIGN KEY (Objeto_id_objeto)
    REFERENCES Objeto (id_objeto);

ALTER TABLE Video ADD CONSTRAINT Video_Objeto
    FOREIGN KEY (Objeto_id_objeto)
    REFERENCES Objeto (id_objeto);

ALTER TABLE Objeto ADD CONSTRAINT pertenece
    FOREIGN KEY (Coleccion_id_coleccion)
    REFERENCES Coleccion (id_coleccion);

ALTER TABLE Objeto ADD CONSTRAINT se_encuentra
    FOREIGN KEY (Repositorio_id_repositorio)
    REFERENCES Repositorio (id_repositorio);

-- End of file.

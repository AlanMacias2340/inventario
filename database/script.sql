-- Create Database
CREATE DATABASE IF NOT EXISTS inventario;
USE inventario;


-- Table: rol_usuario
CREATE TABLE IF NOT EXISTS rol_usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE usuario (
    ci VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasenia VARCHAR(255) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL, -- New
    telefono VARCHAR(20),               -- New
    direccion TEXT,                     -- New
    foto_perfil VARCHAR(255),           -- New
    rol_id INT,                         -- FK (Assuming an ID)
    jefe_ci VARCHAR(20),                -- FK (Self-reference)
    activo BOOLEAN DEFAULT TRUE,        -- New
    ultimo_ingreso TIMESTAMP,           -- New
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_baja TIMESTAMP,
    
    CONSTRAINT fk_rol FOREIGN KEY (rol_id) REFERENCES rol_usuario(id),
    CONSTRAINT fk_jefe FOREIGN KEY (jefe_ci) REFERENCES usuario(ci)
);

CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE,            -- New: for clean URLs
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,         -- New: soft status
    parent_id INT,                       -- New: for subcategories
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_parent_category FOREIGN KEY (parent_id) REFERENCES categoria(id)
);

CREATE TABLE producto (
    -- Original Fields from Image
    sku VARCHAR(50) PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    usuario_creador VARCHAR(20),
    categoria_id INT,
    costo_total DECIMAL(12, 2),
    costo_venta DECIMAL(12, 2),
    cantidad_total INT DEFAULT 0,
    
    -- New Recommended Fields
    codigo_barras VARCHAR(50) UNIQUE,      -- For scanners
    marca VARCHAR(100),                    -- Brand filtering
    stock_minimo INT DEFAULT 5,            -- For inventory alerts
    slug VARCHAR(150) UNIQUE,              -- For SEO/Web URLs
    imagen_url VARCHAR(255),               -- Link to product photo
    unidad_medida VARCHAR(20) DEFAULT 'u', -- e.g., 'kg', 'm', 'unit'
    esta_activo BOOLEAN DEFAULT TRUE,      -- Quick toggle status
    
    -- Audit Fields
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_baja TIMESTAMP,

    -- Relationships
    CONSTRAINT fk_usuario_creador FOREIGN KEY (usuario_creador) REFERENCES usuario(ci),
    CONSTRAINT fk_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);
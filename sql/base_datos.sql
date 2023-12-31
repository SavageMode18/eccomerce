CREATE TABLE persona (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR(150) NOT NULL,
 correo VARCHAR(150) NOT NULL,
 direccion VARCHAR(250) NOT NULL,
 celular INTEGER
);
CREATE TABLE persona_natural (
    id SERIAL PRIMARY KEY,
    id_persona INTEGER REFERENCES persona(id),
    apellido VARCHAR(250) NOT NULL,
    cedula VARCHAR(80),
    fecha_nacimiento DATE,
    genero CHAR
);

CREATE TABLE persona_juridica
(
    id SERIAL PRIMARY KEY,
    id_persona INTEGER REFERENCES persona(id),
    ruc VARCHAR(250) NOT NULL,
    razon_social VARCHAR(250),
    fecha_constitucional DATE
);

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    id_persona INTEGER REFERENCES persona(id),
    tipo_cliente VARCHAR(250) NOT NULL,
    foto VARCHAR(250) ,
    estado INTEGER
);


CREATE TABLE trabajador
(
    id SERIAL primary key,
    id_persona INTEGER REFERENCES persona(id),
    foto VARCHAR(250) ,
    estado INTEGER 
);


CREATE TABLE salario
( 
    id SERIAL PRIMARY KEY,
    id_trabajador INTEGER REFERENCES trabajador(id),
    salario_actual NUMERIC(10,2) NOT NULL,
    salario_anterior NUMERIC(10,2),
    estado INTEGER
);

CREATE TABLE categoria_producto
(
    id SERIAL PRIMARY KEY ,
    nombre VARCHAR(120) NOT NULL,
    descripcion VARCHAR(250),
    estado INTEGER
);

CREATE TABLE sub_categoria_producto(
    id SERIAL PRIMARY KEY,
    id_categoria INTEGER REFERENCES categoria_producto(id),
    nombre VARCHAR(250) NOT NUll,
    descripcion VARCHAR(250),
    estado INTEGER
);

CREATE TABLE producto
(
    id SERIAL PRIMARY KEY,
    id_sub_categoria INTEGER REFERENCES sub_categoria_producto(id),
    nombre VARCHAR(120) NOT NULL,
    descripcion varchar(250) NOT NULL,
    cantidad INTEGER NOT NUll,
    logo VARCHAR(250),
    estado INTEGER
);

CREATE TABLE precio(
    id SERIAL PRIMARY KEY,
    id_producto INTEGER REFERENCES producto(id),
    precio_actual NUMERIC(10,2) NOT NULL,
    precio_anterior NUMERIC(10,2),
    estado INTEGER
);


CREATE TABLE servicios(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(250),
    foto VARCHAR(250),
    estado INTEGER
);

CREATE TABLE precio_servicios(
    id SERIAL PRIMARY KEY,
    id_servicios INTEGER REFERENCES servicios(id),
    precio_actual NUMERIC(10,2) NOT NULL,
    precio_anterior NUMERIC(10,2),
    estado INTEGER
);


Create table personalizacion
(
    id SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES clientes(id),
    descripcion VARCHAR(250),
    fotos VARCHAR(150),
    presupuesto NUMERIC,
    estado INTEGER
);

CREATE TABLE detalle_personalizacion(
    id SERIAL PRIMARY KEY,
    id_personalizacion INTEGER REFERENCES personalizacion(id),
    costo_total NUMERIC,
    nota TEXT,
    fecha_entrega DATE,
    tipo_entrega VARCHAR(5000)
    
);

/**
*Pedidos y personalizaciones
*/

CREATE TABLE tipo_venta (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(250) NOT NUll,
    descripcion VARCHAR(250),
    estado INTEGER
);

CREATE TABLE venta(
    id SERIAL PRIMARY KEY,
    id_tipo INTEGER REFERENCES tipo_venta(id),
    id_cliente INTEGER REFERENCES clientes(id),
    codigo VARCHAR(255),
    tipo_entrega VARCHAR(5000),
    fecha DATE,
    fecha_entrega DATE,
    descuento NUMERIC NOT NULL,
    total NUMERIC NOT NULL,
    estado INTEGER
);


CREATE TABLE detalle_venta
(
    id SERIAL PRIMARY KEY,
    id_venta INTEGER REFERENCES venta(id),
    id_producto INTEGER REFERENCES producto(id),
    precio_unitario NUMERIC NOT NULL,
    cantidad INTEGER NOT NULL,
    subtotal numeric NOT NULL
);

CREATE TABLE venta_personalizacion(
    id SERIAL PRIMARY KEY,
    id_venta INTEGER REFERENCES venta(id),
    id_personalizacion INTEGER REFERENCES personalizacion(id),
    descripcion VARCHAR(255),
    subtotal numeric NOT NULL,
    cantidad INTEGER
);
CREATE TABLE venta_servicios(
    id SERIAL PRIMARY KEY,
    id_venta INTEGER REFERENCES venta(id),
    id_reservacion INTEGER REFERENCES servicios(id),
    subtotal numeric NOT NUll 
);

CREATE TABLE modulo(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(250),
    icono VARCHAR(500),
    estado INTEGER 
);

CREATE TABLE sub_modulo(
    id SERIAL PRIMARY KEY,
    id_modulo INTEGER REFERENCES modulo(id),
    nombre VARCHAR(250) NOT NUll,
    enlace VARCHAR(500)NOT NULL
);



CREATE TABLE grupo_usuarios
(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    estado INTEGER 
);


CREATE TABLE usuario
(
    id SERIAL PRIMARY KEY,
    id_grupo INTEGER REFERENCES grupo_usuarios(id),
    id_persona INTEGER REFERENCES persona(id),
    usuario VARCHAR(200) NOT NULL,
    contraseña VARCHAR(250) NOT NULL,
    estado INTEGER 
);

CREATE TABLE conexion(
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES usuario(id),
    ip VARCHAR(250) ,
    mac VARCHAR(250),
    navegador VARCHAR(150),
    version_navegador VARCHAR(150),
    os VARCHAR(150),
    version_os VARCHAR(150),
    dispostivo VARCHAR(150),
    version_dispositivos VARCHAR(150),
    fecha date DEFAULT CURRENT_DATE,
    estado INTEGER NOT NULL
);

CREATE TABLE privilegio_modulo(
    id SERIAL PRIMARY KEY,
    id_sub INTEGER REFERENCES submodulo(id),
    id_usuario INTEGER REFERENCES usuario(id),
    fecha_registro DATE DEFAULT NOW()
);


CREATE TABLE permiso(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(250)
);


CREATE TABLE permiso_modulo (
    id SERIAL PRIMARY KEY,
    id_permiso INTEGER REFERENCES permiso(id),
    id_modulo INTEGER REFERENCES modulo(id)
);


CREATE TABLE permiso_usuario(
    id SERIAL PRIMARY KEY,
    id_permiso_modulo INTEGER REFERENCES permiso_modulo(id),
    id_usuario INTEGER REFERENCES usuario(id)
);

CREATE TABLE catpregunta(
id serial primary key,
categoria VARCHAR(250)
);

CREATE TABLE pregunta(
    id serial primary key,
    id_cat INTEGER REFERENCES catpregunta(id),
    pregunta VARCHAR(250) NOT NULL,
    respuesta TEXT NOT NULL
  );



CREATE TABLE comentario(
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES usuario(id),
    id_producto INTEGER REFERENCES producto(id),
    comentario TEXT NOT NULL
);


CREATE TABLE valoracion(
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES usuario(id),
    id_producto INTEGER REFERENCES producto(id),
    puntos INTEGER NOT NULL
);
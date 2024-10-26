-- PASO 1: CREACIÓN DE LAS TABLAS 

-- Tabla de Clientes
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_registro DATE,
    email VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla de Productos
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    nombre_producto VARCHAR(50),
    categoria VARCHAR(50),
    precio DECIMAL(10, 2),
    stock INT
);

-- Tabla de Ventas
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    cantidad INT,
    fecha_venta DATE,
    total_venta DECIMAL(10, 2),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Tabla de Personal de Ventas
CREATE TABLE sales_staff (
    staff_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100),
    telefono VARCHAR(15)
);

-- POBLAR CADA TABLA

-- Insertar Clientes
INSERT INTO customers VALUES (1, 'Juan', 'Pérez', TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'juan.perez@mail.com', '123456789');
INSERT INTO customers VALUES (2, 'Ana', 'Gómez', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'ana.gomez@mail.com', '987654321');
INSERT INTO customers VALUES (3, 'Pedro', 'Fernández', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'pedro.fernandez@mail.com', '555666777');
INSERT INTO customers VALUES (4, 'Marta', 'López', TO_DATE('2024-08-25', 'YYYY-MM-DD'), 'marta.lopez@mail.com', '444555666');
INSERT INTO customers VALUES (5, 'Carlos', 'Rodríguez', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'carlos.rodriguez@mail.com', '111222333');

-- Insertar Productos
INSERT INTO products VALUES (1, 'Laptop X', 'Tecnología', 1200.99, 15);
INSERT INTO products VALUES (2, 'Smartphone Y', 'Tecnología', 699.50, 30);
INSERT INTO products VALUES (3, 'Tablet Z', 'Tecnología', 499.99, 25);
INSERT INTO products VALUES (4, 'Audífonos', 'Accesorios', 199.90, 50);
INSERT INTO products VALUES (5, 'Monitor 4K', 'Tecnología', 299.99, 8);
INSERT INTO products VALUES (6, 'Camara', 'Tecnología', 299.99, 12);

-- Insertar Ventas

INSERT INTO sales VALUES (1, 1, 2, 1, TO_DATE('2024-10-20', 'YYYY-MM-DD'), 699.50);
INSERT INTO sales VALUES (2, 3, 1, 2, TO_DATE('2024-10-21', 'YYYY-MM-DD'), 2401.98);
INSERT INTO sales VALUES (3, 2, 4, 3, TO_DATE('2024-10-15', 'YYYY-MM-DD'), 599.70);
INSERT INTO sales VALUES (4, 4, 5, 1, TO_DATE('2024-08-25', 'YYYY-MM-DD'), 299.99);
INSERT INTO sales VALUES (5, 5, 3, 2, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 999.98);


-- Insertar Personal de Ventas
INSERT INTO sales_staff VALUES (1, 'Lucía', 'Martínez', 'lucia.martinez@mail.com', '321654987');
INSERT INTO sales_staff VALUES (2, 'Sofía', 'García', 'sofia.garcia@mail.com', '123987654');
INSERT INTO sales_staff VALUES (3, 'Miguel', 'Torres', 'miguel.torres@mail.com', '789456123');
INSERT INTO sales_staff VALUES (4, 'Laura', 'Hernández', 'laura.hernandez@mail.com', '654123789');
INSERT INTO sales_staff VALUES (5, 'Javier', 'Vargas', 'javier.vargas@mail.com', '987321654');



-- PASO 2: CONSULTAS SQL

-- Clientes registrados en el último mes 

SELECT CONCAT(nombre, ' ') ||  apellido AS "Nombre completo del cliente", 
       fecha_registro AS "Fecha de registro"
FROM customers
WHERE fecha_registro >= ADD_MONTHS(SYSDATE, -1)
ORDER BY fecha_registro DESC;


-- Incremento del 15% del precio de productos

SELECT 
    nombre_producto AS "Nombre del producto",
    ROUND(precio + (precio * 0.15), 1) AS "Precio incrementado en 15%",  
    precio AS "Precio original"
FROM products
WHERE LOWER(TRIM(nombre_producto)) LIKE '%a'  -- Nombre que termina en 'a'
  AND stock > 10  -- Más de 10 unidades en stock
ORDER BY 2 ASC;  -- Ordenar por el precio incrementado


-- Mostrar personal de ventas con contraseña generada


SELECT 
    nombre || ' ' || apellido AS nombre_completo,  -- Concatenar nombre y apellido con un espacio intermedio
    email AS correo_electronico,  -- Mostrar el correo electrónico del personal
    SUBSTR(nombre, 1, 4) ||  -- Tomar las primeras 4 letras del nombre
    LENGTH(email) ||  -- Calcular la longitud total del correo electrónico
    SUBSTR(apellido, -3) AS contrasena  -- Tomar las últimas 3 letras del apellido
FROM sales_staff  -- Consultar desde la tabla sales_staff
ORDER BY apellido DESC,  -- Ordenar por apellido en forma descendente
         nombre ASC;  -- Si hay coincidencias en apellido, ordenar por nombre en forma ascendente


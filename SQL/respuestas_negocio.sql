/* 
Pregunta 1:
Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas
 realizadas en enero 2020 sea superior a 1500.
*/
SELECT c.first_name, c.last_name
FROM Customer c
WHERE 
    MONTH(c.birth_date) = MONTH(GETDATE())
    AND DAY(c.birth_date) = DAY(GETDATE())
    AND c.customer_id IN (
        SELECT buyer_id
    FROM [Order]
    WHERE MONTH(created_date) = 1 AND YEAR(created_date) = 2020
    GROUP BY buyer_id
    HAVING COUNT(*) > 1500
    )
/*
Pregunta 2:
 Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la
 categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del
 vendedor, cantidad de ventas realizadas, cantidad de productos vendidos y el monto
 total transaccionado.

 SIDE NOTE: 
    This query could be optimized by using the category_id for 'Celulares' directly within the Item table,
    but for illustrative purposes, it joins with the Category table using the category name instead.
*/
SELECT TOP 5
    YEAR(o.created_date) AS year,
    MONTH(o.created_date) AS month,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_sales,
    SUM(o.quantity) AS total_quantity,
    SUM(o.total_amount) AS total_amount
FROM [Order] o
    JOIN Customer c ON o.seller_id = c.customer_id
    JOIN Item i ON o.item_id = i.item_id
    JOIN Category cat ON i.category_id = cat.category_id
WHERE 
    cat.name = 'Celulares'
    AND YEAR(o.created_date) = 2020
GROUP BY
    MONTH(o.created_date),
    YEAR(o.created_date),
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_sales DESC;

/*
Pregunta 3:
Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día.
 Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item,
 vamos a tener únicamente el último estado informado por la PK definida. (Se puede
 resolver a través de StoredProcedure)

 SIDE NOTE:
    You should assume the ItemDailyStatus table has been created previously with appropriate column definitions.
*/

CREATE PROCEDURE PopulateItemDailyStatus
AS
BEGIN
    DECLARE @CurrentDate DATETIME = GETDATE()

    INSERT INTO ItemDailyStatus (item_id, price, status, last_updated_date)
    SELECT item_id, price, status, @CurrentDate
    FROM Item
END;
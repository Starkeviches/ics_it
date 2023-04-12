/*3.Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в ветке Functions)
3.1 Входной параметр @ID_SKU
3.2 Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле
   3.1.1 сумма Value по переданному SKU / сумма Quantity по переданному SKU
3.3 На выходе значение типа decimal(18, 2)*/

CREATE FUNCTION udf_GetSKUPrice (@ID_SKU INT = 0)
    RETURNS decimal(18, 2)
    BEGIN
        DECLARE @amountID_SKU decimal(18, 2)
        SELECT @amountID_SKU = SUM (Value) / SUM (Quantity) FROM Basket b
		where ID_SKU=@ID_SKU
		group by ID_SKU
        RETURN @amountID_SKU
    END;


	

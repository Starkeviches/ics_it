/*6.Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)
6.1 Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение в поле DiscountValue, 
для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0*/

CREATE TRIGGER TR_Basket_insert_update

ON basket FOR INSERT

AS

BEGIN

select ID_SKU from inserted where id_sku in  
	  (select ID_SKU from basket group by ID_SKU, PurchaseDate having count(ID_SKU)>=2)

if @@ROWCOUNT > 1

update Basket set DiscountValue = 0 
	  where ID_SKU in 
	  (select ID_SKU from inserted where id_sku in  
	  (select ID_SKU from basket group by ID_SKU, PurchaseDate having count(ID_SKU)=1))

update Basket set DiscountValue = value * 0.05 
	  where ID_SKU in 
	  (select ID_SKU from inserted where id_sku in  
	  (select ID_SKU from basket group by ID_SKU, PurchaseDate having count(ID_SKU)>=2))

END;


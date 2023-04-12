/*6.������� ������� (�� ������: ���� � ����������� dbo.TR_Basket_insert_update � ����� Triggers)
6.1 ���� � ������� dbo.Basket �� ��� ����������� 2 � ����� ������� ������ ID_SKU, �� �������� � ���� DiscountValue, 
��� ����� ID_SKU �������������� �� ������� Value * 5%, ����� DiscountValue = 0*/

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


/*3.������� ������� (�� ������: ���� � ����������� dbo.udf_GetSKUPrice.sql � ����� Functions)
3.1 ������� �������� @ID_SKU
3.2 ������������ ��������� ������������� �������� �� ������� dbo.Basket �� �������
   3.1.1 ����� Value �� ����������� SKU / ����� Quantity �� ����������� SKU
3.3 �� ������ �������� ���� decimal(18, 2)*/

CREATE FUNCTION udf_GetSKUPrice (@ID_SKU INT = 0)
    RETURNS decimal(18, 2)
    BEGIN
        DECLARE @amountID_SKU decimal(18, 2)
        SELECT @amountID_SKU = SUM (Value) / SUM (Quantity) FROM Basket b
		where ID_SKU=@ID_SKU
		group by ID_SKU
        RETURN @amountID_SKU
    END;


	

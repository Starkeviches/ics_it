/*4.������� ������������� (�� ������: ���� � ����������� dbo.vw_SKUPrice� ����� VIEWs)
4.1 ���������� ��� �������� ��������� �� ������� dbo.SKU � ��������� ������� �� ���������� ������ �������� (��������� ������� dbo.udf_GetSKUPrice)*/



create view SKU_udf_GetSKUPrice as
select *, [dbo].[udf_GetSKUPrice](1) as price_one_product from SKU;

/*create view SKU_udf_GetSKUPrice_no_function as
select s.ID, s.Code, s.Name, sum(b.Value)/sum(b.Quantity) as price_one_product from SKU s
inner join Basket b on (s.ID=b.ID_SKU)
group by s.ID, s.Code, s.Name;*/



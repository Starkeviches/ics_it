/*5.������� ��������� (�� ������: ���� � ����������� dbo.usp_MakeFamilyPurchase � ����� Procedures
5.1 ������� �������� (@FamilySurName varchar(255)) ���� �� �������� ��������� SurName ������� dbo.Family
5.2 ��������� ��� ������ ��������� ������ � ������� dbo.Family � ���� BudgetValue �� ������
   5.2.1 dbo.Family.BudgetValue - sum(dbo.Basket.Value), ��� dbo.Basket.Value ������� ��� ���������� � ��������� �����
   5.2.2 ��� �������� ��������������� dbo.Family.SurName ������������ �������� ������, ��� ����� ����� ���*/

   CREATE PROCEDURE usp_MakeFamilyPurchase
(
    @FamilySurName VARCHAR(255)
    
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Family where SurName=@FamilySurName
	)
    BEGIN
        update Family set BudgetValue = (
             select f.BudgetValue - sum(B.Value) from Family f 
                inner join Basket b on (b.ID_Family=f.ID)
             where f.SurName=@FamilySurName
             group by f.id, f.BudgetValue)
	
    END
ELSE
    BEGIN
       
	PRINT '����� ����� ���'
    END
END;


/*5.Создать процедуру (на выходе: файл в репозитории dbo.usp_MakeFamilyPurchase в ветке Procedures
5.1 Входной параметр (@FamilySurName varchar(255)) одно из значений аттрибута SurName таблицы dbo.Family
5.2 Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
   5.2.1 dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
   5.2.2 При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет*/

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
       
	PRINT 'Такой семьи нет'
    END
END;


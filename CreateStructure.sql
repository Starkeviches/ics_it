/*2.1 dbo.SKU (ID identity, Code, Name)
   2.1.1 ����������� �� ������������ ���� Code
   2.1.2 ���� Code �����������: "s" + ID
2.2 dbo.Family (ID identity, SurName, BudgetValue)
2.3 dbo.Basket (ID identity, ID_SKU (������� ���� �� ������� dbo.SKU), ID_Family (������� ���� �� ������� dbo.Family) Quantity, Value, PurchaseDate, DiscountValue)
   2.3.1 �����������, ��� ���� Quantity � Value �� ����� ���� ������ 0
  2.3.2 �������� �������� �� ��������� ��� ���� PurchaseDate: ���� ���������� ������ (������� ����)*/

  create table SKU (
  ID  int identity  PRIMARY KEY,
  Code as 's'+ CAST(ID AS VARCHAR),
  Name varchar(150));
  
  ALTER TABLE SKU   
  ADD CONSTRAINT AK_Code UNIQUE (Code);

  create table Family (
  ID int identity PRIMARY KEY, 
  SurName varchar(255), 
  BudgetValue decimal(8,2));
  
  create table Basket (
  ID int identity,
  ID_SKU int,
  ID_Family int,
  Quantity decimal(8,2), 
  Value decimal(8,2), 
  PurchaseDate DATETIME DEFAULT GETDATE(), 
  DiscountValue decimal(8,2),
  CONSTRAINT FK_Basket_Family FOREIGN KEY (ID_Family)
        REFERENCES Family (ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
  CONSTRAINT FK_Basket_SKU FOREIGN KEY (ID_SKU)
        REFERENCES SKU (ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
  CONSTRAINT CHK_Basket_Quantity   
   CHECK (Quantity > 0),
  CONSTRAINT CHK_Basket_Value   
   CHECK (Value > 0));

 








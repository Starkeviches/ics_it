/*2.1 dbo.SKU (ID identity, Code, Name)
   2.1.1 Ограничение на уникальность поля Code
   2.1.2 Поле Code вычисляемое: "s" + ID
2.2 dbo.Family (ID identity, SurName, BudgetValue)
2.3 dbo.Basket (ID identity, ID_SKU (внешний ключ на таблицу dbo.SKU), ID_Family (Внешний ключ на таблицу dbo.Family) Quantity, Value, PurchaseDate, DiscountValue)
   2.3.1 Ограничение, что поле Quantity и Value не могут быть меньше 0
  2.3.2 Добавить значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата)*/

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

 








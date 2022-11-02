Create Table Customers 
(
	ID varchar(50),Name varchar(50),Phone int,Email varchar(50),Postal_Code int,City varchar(50),State varchar(50)
)

Create Table Products 
(
	ID varchar(50),Category varchar(50),Name varchar(50),Description varchar(50),Photos int,Weight int,
	Lenght int,Height int,Width int,Seller_ID varchar(50),Category_ID varchar(50)
)

Create Table Orders 
(
	ID varchar(50),Status varchar(50),Order_Date Datetime,Est_Delivery_Date Datetime,
	Act_Delivery_date datetime,Location_ID varchar(50),Pay_Type varchar(50),Pay_Installment int,
	Pay_Value int,Customer_ID varchar(50)
)

Create Table Seller
(
	ID varchar(50),Name varchar(50),Phone int, Email varchar(50)
)

Create Table Location 
(
	ID varchar(50),Name varchar(50),Phone int,City varchar(50),State varchar(50),Lat Float,Long float,
	Postal_Code int,Customer_ID varchar(50)
)

Create Table Category
(
	ID varchar(50),Name varchar(50),Description varchar(50),Photos int 
)

Create Table Item
(
	ID varchar(50),Unit_Price Float,Freight_Value Float,Order_ID varchar(50),Product_ID varchar(50)
)

Create Table Review 
(
	ID varchar(50),Rate int,Comment varchar(50),Order_ID varchar(50),Customer_ID varchar(50)
)
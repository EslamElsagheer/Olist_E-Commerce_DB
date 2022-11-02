Create Procedure Crud_Operations_Category 
( @ID varchar(50),@Name varchar(50),@Description varchar(50),@Photos int,@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Category
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Category
		(ID ,Name ,Description ,Photos)
		Values (@ID ,@Name ,@Description ,@Photos)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Category
		Set Name = @Name ,
			Description = @Description ,
			Photos = @Photos
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Category 
		Where ID = @ID
	End
End

Exec Crud_Operations_Category '"007FA526-6FB4-46C5-8CC3-784B1BE8E98C"','drinks','bused',5,'Select'

Create Procedure Crud_Operations_Customers 
( @ID varchar(50),@Name varchar(50),@Phone int ,@Email varchar(50),@Postal_Code int,
@City varchar(50),@State varchar(50),@Location_ID varchar(50),@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Customers
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Customers
		(ID ,Name ,Phone,Email,Postal_Code,City,State,Location_ID)
		Values (@ID ,@Name ,@Phone,@Email,@Postal_Code,@City,@State,@Location_ID)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Customers
		Set Name = @Name ,
			Phone = @Phone ,
			Email = @Email ,
			Postal_Code = @Postal_Code ,
			City = @City ,
			State = @State , 
			Location_ID = @Location_ID
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Customers
		Where ID = @ID
	End
End

Exec Crud_Operations_Customers


Create Procedure Crud_Operations_Item 
( @ID varchar(50),@Unit_Price Float,@Quantity int ,@Freight_Value Float,@Order_ID varchar(50),
@Product_ID varchar(50),@Seller_ID varchar(50),@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Item
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Item
		(ID ,Unit_Price,Quantity,Freight_Value,Order_ID,Product_ID,Seller_ID)
		Values (@ID ,@Unit_Price,@Quantity,@Freight_Value,@Order_ID,@Product_ID,@Seller_ID)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Item
		Set Unit_Price = @Unit_Price ,
			Quantity = @Quantity ,
			Freight_Value = @Freight_Value ,
			Order_ID = @Order_ID ,
			Product_ID = @Product_ID ,
			Seller_ID = @Seller_ID 
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Item
		Where ID = @ID
	End
End

Exec Crud_Operations_Item


Create Procedure Crud_Operations_Location
( @ID varchar(50),@Name varchar(50),@Phone int ,@City varchar(50),@State varchar(50),@Lat Float ,@Long Float,
@Postal_Code int,@Customer_ID varchar(50),@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Location
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Location
		(ID ,Name ,Phone,City,State,Lat,Long,Postal_Code,Customer_ID)
		Values (@ID ,@Name ,@Phone,@City,@State,@Lat,@Long,@Postal_Code,@Customer_ID)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Location
		Set Name = @Name ,
			Phone = @Phone ,
			City = @City ,
			State = @State , 
			Lat = @Lat , 
			Long = @Long ,
			Postal_Code = @Postal_Code ,
			Customer_ID = @Customer_ID
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Location
		Where ID = @ID
	End
End

Exec Crud_Operations_Location

Create Procedure Crud_Operations_Orders
( @ID varchar(50),@Status varchar(50),@Order_Date Datetime ,@Est_Delivery_Date Datetime,
@Act_Delivery_Date Datetime,@Location_ID varchar(50),@Pay_Type varchar(50),@Pay_Installment int,
@Pay_Value int,@Customer_ID varchar(50),@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Orders
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Orders
		(ID ,Status,Order_Date,Est_Delivery_Date,Act_Delivery_date,Location_ID,Pay_Type,Pay_Installment,
		Pay_Value,Customer_ID)
		Values (@ID ,@Status,@Order_Date,@Est_Delivery_Date,@Act_Delivery_Date,@Location_ID,@Pay_Type,
		@Pay_Installment,@Pay_Value,@Customer_ID)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Orders
		Set Status = @Status,
			Order_Date = @Order_Date ,
			Est_Delivery_Date = @Est_Delivery_Date ,
			Act_Delivery_date = @Act_Delivery_Date ,
			Location_ID = @Location_ID ,
			Pay_Type = @Pay_Type ,
			Pay_Installment = @Pay_Installment ,
			Pay_Value = @Pay_Value ,
			Customer_ID = @Customer_ID
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Orders
		Where ID = @ID
	End
End

Exec Crud_Operations_Orders


Create Procedure Crud_Operations_Products
( @ID varchar(50),@Category varchar(50),@Name varchar(50),@Description varchar(50),@Photos int,
@Weight int,@Lenght int,@Height int,@Width int,@Seller_ID varchar(50),@Category_ID varchar(50),
@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Products
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Products
		(ID ,Category,Name,Description,Photos,Weight,Lenght,Height,Width,Seller_ID,Category_ID)
		Values (@ID ,@Category ,@Name ,@Description ,@Photos ,@Weight ,@Lenght ,@Height ,@Width ,@Seller_ID ,
		@Category_ID )
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Products
		Set Category = @Category ,
			Name = @Name ,
			Description = @Description ,
			Photos = @Photos ,
			Weight = @Weight ,
			Lenght = @Lenght ,
			Height = @Height ,
			Width = @Width ,
			Seller_ID = @Seller_ID ,
			Category_ID = @Category_ID
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Products
		Where ID = @ID
	End
End

Exec Crud_Operations_Products

Create Procedure Crud_Operations_Review
( @ID varchar(50),@Rate int,@Comment text,@Order_ID varchar(50),@Customer_ID varchar(50),
@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Review
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Review
		(ID ,Rate,Comment,Order_ID,Customer_ID)
		Values (@ID ,@Rate,@Comment,@Order_ID,@Customer_ID)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Review
		Set Rate = @Rate ,
			Comment = @Comment , 
			Order_ID = @Order_ID ,
			Customer_ID = @Customer_ID
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Review
		Where ID = @ID
	End
End

Exec Crud_Operations_Review

Create Procedure Crud_Operations_Seller
( @ID varchar(50),@Name varchar(50),@Phone int,@Email varchar(50),@Statment_Type varchar(20) = '' )
as
Begin 
If @Statment_Type = 'Select'
	Begin
		Select * 
		From dbo.Seller
	End

If @Statment_Type = 'Insert'
	Begin
		Insert into dbo.Seller
		(ID ,Name,Phone,Email)
		Values (@ID ,@Name,@Phone,@Email)
	End

If @Statment_Type = 'Update'
	Begin 
		Update dbo.Seller
		Set Name = @Name ,
			Phone = @Phone ,
			Email = @Email
		Where ID = @ID
	End

Else If @Statment_Type = 'Delete'
	Begin 
		Delete From dbo.Seller
		Where ID = @ID
	End
End

Exec Crud_Operations_Seller

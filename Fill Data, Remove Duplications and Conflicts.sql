Create Procedure Fill_Location_Data
as
Insert Into dbo.Location 
(ID,Name,Phone,City,State,Lat,Long,Postal_Code,Customer_ID)
Select NEWID(),null,null,geolocation_city,geolocation_state,geolocation_lat,geolocation_lng,
geolocation_zip_code_prefix,null
From Dataset.dbo.olist_geolocation_dataset

Exec Fill_Location_Data

Create Procedure Fill_Customer_Data
as
Insert Into dbo.Customers 
(ID,Name,Phone,Email,Postal_Code,City,State)
Select customer_id,null,null,null,customer_zip_code_prefix,customer_city,customer_state
From Dataset.dbo.olist_customers_dataset

Exec Fill_Customer_Data

Create Procedure Fill_Category_Data
as
Insert Into dbo.Category 
(ID,Name,Description,Photos)
Select NEWID(),product_category_name_english,product_category_name,null
From Dataset.dbo.product_category_name_translation

Exec Fill_Category_Data

Create Procedure Fill_Item_Data
as
Insert Into dbo.Item 
(ID,Unit_Price,Quantity,Freight_Value,Order_ID,Product_ID,Seller_ID)
Select NEWID(),price,order_item_id,freight_value,order_id,product_id,seller_id
From Dataset.dbo.olist_order_items_dataset

Exec Fill_Item_Data

Create Procedure Fill_Orders_Data
as
Insert Into dbo.Orders 
(ID,Status,Order_Date,Est_Delivery_Date,Act_Delivery_date,Location_ID,Pay_Type,
Pay_Installment,Pay_Value,Customer_ID)
Select Dataset.dbo.olist_orders_dataset.order_id,order_status,order_approved_at,
order_estimated_delivery_date,order_delivered_customer_date,
null,payment_type,payment_installments,payment_value,customer_id
From Dataset.dbo.olist_orders_dataset INNER JOIN Dataset.dbo.olist_order_payments_dataset 
ON Dataset.dbo.olist_orders_dataset.order_id = Dataset.dbo.olist_order_payments_dataset.order_id

Exec Fill_Orders_Data

Create Procedure 
Create Procedure Fill_Products_Data
as
Insert Into dbo.Products 
(ID,Name,Description,Photos,Weight,Lenght,Height,Width,Seller_ID,Category_ID)
Select product_id,null,product_description_lenght,product_photos_qty,product_weight_g,product_length_cm,
product_height_cm,product_width_cm,null,product_category_name
From Dataset.dbo.olist_products_dataset

Exec Fill_Products_Data

Alter Procedure Fill_Review_Data
as
Insert Into dbo.Review
(ID,Rate,Comment,Order_ID,Customer_ID)
Select review_id,review_score,review_comment_message,order_id,null
From Dataset.dbo.olist_order_reviews_dataset
Where order_id IN ( Select ID From dbo.Orders )

Exec Fill_Review_Data

Create Procedure Fill_Seller_Data
as
Insert Into dbo.Seller 
(ID,Name,Phone,Email)
Select seller_id,null,null,null 
From Dataset.dbo.olist_sellers_dataset

Exec Fill_Seller_Data

Create Procedure Fill_Location_Customer_ID
as
Update dbo.Location
Set Customer_ID = dbo.Customers.ID 
From dbo.Location Inner Join dbo.Customers 
On dbo.Location.Postal_Code = dbo.Customers.Postal_Code

Exec Fill_Location_Customer_ID

Alter Procedure Fill_Orders_Location_ID
as
Update dbo.Orders
Set dbo.Orders.Location_ID = dbo.Location.ID
From dbo.Orders Inner Join dbo.Customers On dbo.Orders.Customer_ID = dbo.Customers.ID Inner Join dbo.Location
On dbo.Customers.ID = dbo.Location.Customer_ID

Exec Fill_Orders_Location_ID

Create Procedure Fill_Review_Customer_ID
as
Update dbo.Review
Set Customer_ID = dbo.Orders.Customer_ID
From dbo.Review Inner Join dbo.Orders On dbo.Review.Order_ID = dbo.Orders.ID

Exec Fill_Review_Customer_ID

Create Procedure Fill_Products_Seller_ID
as
Update dbo.Products
Set Seller_ID = dbo.Seller.ID
From dbo.Products Inner Join dbo.Item On dbo.Products.ID = dbo.Item.Product_ID
Inner Join dbo.Seller On dbo.Seller.ID = dbo.Item.Seller_ID

Exec Fill_Products_Seller_ID

Create Procedure Fill_Products_Category_ID
as
Update dbo.Products
Set Category_ID = dbo.Category.ID
From dbo.Products Inner Join dbo.Category On dbo.Products.Category_ID = dbo.Category.Description

Exec Fill_Products_Category_ID

Alter Procedure Fill_Products_Category
as
Update dbo.Products
Set Category = dbo.Category.Name
From dbo.Products Inner Join dbo.Category On dbo.Products.Category_ID = dbo.Category.ID

Exec Fill_Products_Category

Alter Procedure Fill_Products_Product_Name
as
Update dbo.Products
Set Name = Dataset.dbo.Product_Name.ProductName
From Dataset.dbo.Product_Name
Where dbo.Products.ID = Dataset.dbo.Product_Name.Product_ID

Exec Fill_Products_Product_Name

---------------------------------------------------------------------------------------
Create Procedure Fill_Customers_Location_ID
as
Update dbo.Customers
Set Location_ID = dbo.Location.ID
From dbo.Customers Inner Join dbo.Location On dbo.Customers.Postal_Code = dbo.Location.Postal_Code

Exec Fill_Customers_Location_ID

Create Procedure Fill_Orders_Location_ID_From_Customers
as
Update dbo.Orders
Set Location_ID = dbo.Customers.Location_ID
From dbo.Orders Inner Join dbo.Customers On dbo.Orders.Customer_ID = dbo.Customers.ID

Exec Fill_Orders_Location_ID_From_Customers

----------------------------------------------------------------------------------------------------
/* Remove Duplicate data from customer */
		
		WITH Remove_Dublicate_customers AS (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY ID) AS row_num
			FROM [dbo].[Customers]
		)

		DELETE FROM Remove_Dublicate_customers
		WHERE row_num > 1

/*remove conflict data between order and item*/
		WITH Remove_Conflict_Item_Orders
		AS (
			SELECT * 
			FROM [dbo].[Item]
			WHERE order_id not in ( SELECT ID FROM [dbo].[Orders]))

		DELETE FROM Remove_Conflict_Item_Orders

/*remove conflict data between order and Customer*/
		WITH Remove_Conflict_Order_Customers
		AS (
		SELECT * 
		FROM [dbo].[Orders] AS O
		WHERE O.Customer_ID NOT IN (
									SELECT ID
									FROM [dbo].[Customers]
								)
		)

		UPDATE Remove_Conflict_Order_Customers SET Customer_ID = null

/*remove conflict data between Product and Category*/
		
		Create PROC Remove_Conflict_Product_Category
		AS 
			UPDATE [dbo].[Products] 
			SET Category_ID = null 
			WHERE Category_ID NOT IN (SELECT ID FROM [dbo].[Category] )
	
		EXEC Remove_Conflict_Product_Category

/* Remove Duplicate data from Orders */
		
		WITH Remove_Dublicate_Orders AS (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY ID) AS row_num
			FROM [dbo].[Orders]
		)

		DELETE FROM Remove_Dublicate_Orders
		WHERE row_num > 1;

/* Remove Duplicate data from Reviews */
		
		WITH Remove_Dublicate_Reviews AS (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY ID) AS row_num
			FROM [dbo].[Review]
		)

		DELETE FROM Remove_Dublicate_Reviews
		WHERE row_num > 1;
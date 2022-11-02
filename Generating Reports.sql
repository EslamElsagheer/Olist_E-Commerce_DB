Create Procedure Top_Customers_By_City_Report
as
begin
Select *
From 
(Select Customers.ID, Customers.City , COUNT(Orders.ID) "No. Of Orders" ,
SUM((Item.Unit_Price)*(Item.Quantity)) "Total Revenue" ,
dense_rank() over (partition by Customers.City 
Order by SUM((Item.Unit_Price)*(Item.Quantity)) desc , COUNT(Orders.ID) desc ) "Rank"
From Customers , Orders , Item
Where Customers.ID = Orders.Customer_ID And Orders.ID = Item.Order_ID
Group by Customers.ID, Customers.City) T
Where Rank in (1,2,3,4,5)
End

Exec Top_Customers_By_City_Report


Create Procedure Top_Products_By_City_Report
as
begin
Select *
From 
(Select Products.Category, Products.Name , Location.City , COUNT(Orders.ID) "No. Of Orders" ,
SUM((Item.Unit_Price)*(Item.Quantity)) "Total Revenue" ,
dense_rank() over (partition by Location.City 
Order by SUM((Item.Unit_Price)*(Item.Quantity)) desc , COUNT(Orders.ID) desc ) "Rank"
From Products , Location , Orders , Item
Where Products.ID = Item.Product_ID And Orders.ID = Item.Order_ID And Orders.Location_ID = Location.ID
Group by Products.Category, Products.Name , Location.City ) T
Where Rank in (1,2,3,4,5)
End

Exec Top_Products_By_City_Report


Create Procedure Top_Cities_Avg_Delivery_Time_Report
as
begin
Select *
From 
(Select Location.City , Location.State , 
AVG(DATEDIFF(day,Orders.Order_Date,Orders.Act_Delivery_date)) "Avg. Delivery Time",
dense_rank() over (partition by Location.State 
Order by AVG(DATEDIFF(day,Orders.Order_Date,Orders.Act_Delivery_date)) desc  ) "Rank"
From Location , Orders
Where Orders.Location_ID = Location.ID
Group by  Location.City , Location.State ) T
Where Rank in (1,2,3,4,5)
End

Exec Top_Cities_Avg_Delivery_Time_Report


Create Procedure Top_Seller_Per_Orders_By_Category_Report
as
begin
Select *
From 
(Select Seller.ID , Products.Category , COUNT(Orders.ID) "No. Of Orders" ,
dense_rank() over (partition by Products.Category 
Order by COUNT(Orders.ID) desc  ) "Rank"
From Seller , Orders , Products , Item
Where Seller.ID = Products.Seller_ID And Products.ID = Item.Product_ID And Item.Order_ID = Orders.ID
Group by  Products.Category , Seller.ID ) T
Where Rank in (1,2,3,4,5)
End

Exec Top_Seller_Per_Orders_By_Category_Report


Create Procedure Order_Status_By_NoOrders_By_Revenue_Per_MonthYear_Report
as
begin
Select Distinct Orders.Status , DATEPART(Month,Orders.Order_Date) ,DATENAME(Month,Orders.Order_Date) "Month" ,
COUNT(Orders.Status) "No. Of Orders" , SUM((Item.Unit_Price)*(Item.Quantity)) "Total Revenue" ,
dense_rank() over (partition by DATEPART(Month,Orders.Order_Date) 
Order by DATEPART(Month,Orders.Order_Date) desc , SUM((Item.Unit_Price)*(Item.Quantity)) desc ,
COUNT(Orders.ID) desc) "Rank"
From Orders , Item
Where Item.Order_ID = Orders.ID And DATENAME(Month,Orders.Order_Date) is not null
Group by Orders.Status , DATENAME(Month,Orders.Order_Date) , DATEPART(Month,Orders.Order_Date)
End

Exec Order_Status_By_NoOrders_By_Revenue_Per_MonthYear_Report


Create Procedure Top_PaymentType_By_City_Per_NoOrders_Report
as
begin
Select *
From
(Select Orders.Pay_Type , Location.City , COUNT(Orders.Pay_Type) "No. Of Orders" ,
DENSE_RANK() Over (Partition by Location.City Order by COUNT(Orders.Pay_Type) desc) "Rank"
From Orders , Location
Where Orders.Location_ID = Location.ID
Group by Orders.Pay_Type , Location.City)T
Where Rank = 1
Order by [No. Of Orders] desc
End

Exec Top_PaymentType_By_City_Per_NoOrders_Report


Create Procedure Avg_Delivery_Time_and_Avg_Review_Score_Per_City_Report
as
begin
Select *
From
(Select Location.City , AVG(DATEDIFF(day,Orders.Order_Date,Orders.Act_Delivery_date)) "Avg. Delivery Time" ,
AVG(Review.Rate) "Avg. Review Score" ,
DENSE_RANK() Over (Partition by Location.City 
Order by AVG(DATEDIFF(day,Orders.Order_Date,Orders.Act_Delivery_date)),
AVG(Review.Rate) desc) "Rank"
From Orders , Location , Review
Where Orders.Location_ID = Location.ID And Orders.ID = Review.Order_ID
Group by Location.City)T
Where Rank = 1 And [Avg. Delivery Time] is not null 
Order by [Avg. Delivery Time] desc , [Avg. Review Score] desc
End

Exec Avg_Delivery_Time_and_Avg_Review_Score_Per_City_Report


Create Procedure Top_PaymentInstallment_By_City_Per_NoOrders_Report
as
begin
Select *
From
(Select Orders.Pay_Installment , Location.City , COUNT(Orders.Pay_Installment) "No. Of Orders" ,
DENSE_RANK() Over (Partition by Location.City Order by COUNT(Orders.Pay_Installment) desc) "Rank"
From Orders , Location
Where Orders.Location_ID = Location.ID
Group by Orders.Pay_Installment , Location.City)T
Where Rank = 1
Order by [No. Of Orders] desc
End

Exec Top_PaymentInstallment_By_City_Per_NoOrders_Report

INSERT INTO OrderDiscount(OrderID,DiscountID,Order_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(5,1,(select SUM(Total_Price) from Orders where OrderID=5),NULL,20);
INSERT INTO OrderDiscount(OrderID,DiscountID,Order_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(8,5,(select SUM(Total_Price) from Orders where OrderID=8),NULL,15);
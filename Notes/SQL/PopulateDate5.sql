INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Table_Number,Seat_Number)
VALUES
(1,1,"Dine-In",(select SUM(Cost) from Pizza where PizzaID=1),"2022-03-05 12:03:00",(select Price from Pizza where PizzaID=1)-(select COALESCE(Discount_Money_Off,0) from PizzaDiscount where PizzaID=1),14,"1,2,3");
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Table_Number,Seat_Number)
VALUES
(2,2,"Dine-In",(select SUM(Cost) from Pizza where PizzaID=2),"2022-03-05 12:05:00",(select Price from Pizza where PizzaID=2)-(select COALESCE(Discount_Money_Off,0) from PizzaDiscount where PizzaID=2),4,"1");
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Table_Number,Seat_Number)
VALUES
(3,3,"Dine-In",(select SUM(Cost) from Pizza where PizzaID=3),"2022-03-05 12:05:00",(select Price from Pizza where PizzaID=3),4,"2");
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(4,4,"Pickup",(select SUM(Cost) from Pizza where PizzaID=4)*6,"2022-03-03 21:30:00",(select Price from Pizza where PizzaID=4)*6,1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(5,5,"Delivery",(select SUM(Cost) from Pizza where PizzaID=5),"2022-03-05 19:11:00",(select Price from Pizza where PizzaID=5)*(select 1-(COALESCE(Discount_Percent_Off/100,1)) from OrderDiscount where OrderID=5),1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(5,6,"Delivery",(select SUM(Cost) from Pizza where PizzaID=6),"2022-03-05 19:11:00",((select Price from Pizza where PizzaID=6)-(select COALESCE(Discount_Money_Off,0) from PizzaDiscount where PizzaID=6)),1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(5,7,"Delivery",(select SUM(Cost) from Pizza where PizzaID=7),"2022-03-05 19:11:00",(select Price from Pizza where PizzaID=7)*(select 1-(COALESCE(Discount_Percent_Off/100,1)) from OrderDiscount where OrderID=5),1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(6,8,"Pickup",(select SUM(Cost) from Pizza where PizzaID=8),"2022-03-02 17:30:00",((select Price from Pizza where PizzaID=8)-(select COALESCE(Discount_Money_Off,0) from PizzaDiscount where PizzaID=8)),2);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(7,9,"Delivery",(select SUM(Cost) from Pizza where PizzaID=9),"2022-03-02 18:17:00",(select Price from Pizza where PizzaID=9),3);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(8,10,"Delivery",(select SUM(Cost) from Pizza where PizzaID=10),"2022-03-06 20:32:00",(select Price from Pizza where PizzaID=10)*(select 1-(COALESCE(Discount_Percent_Off/100,1)) from OrderDiscount where OrderID=8),4);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(8,11,"Delivery",(select SUM(Cost) from Pizza where PizzaID=11),"2022-03-06 20:32:00",(select Price from Pizza where PizzaID=11)*(select 1-(COALESCE(Discount_Percent_Off/100,1)) from OrderDiscount where OrderID=8),4);
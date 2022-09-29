INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("small","Thin",3,0.5);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("small","Original",3,0.75);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("small","Pan",3.5,1);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("small","Gluten-Free",4,2);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("medium","Thin",5,1);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("medium","Original",5,1.5);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("medium","Pan",6,2.25);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("medium","Gluten-Free",6.25,3);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("Large","Thin",8,1.25);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("Large","Original",8,2);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("Large","Pan",9,3);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("Large","Gluten-Free",9.5,4);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("X-Large","Thin",10,2);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("X-Large","Original",10,3);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("X-Large","Pan",11.5,4.5);
INSERT INTO Price(Size,Crust,Price,Cost)
VALUES
("X-Large","Gluten-Free",12.5,6);

INSERT INTO Discount(Name,Percent_Off,Money_Off)
VALUES
("employee",15,NULL);
INSERT INTO Discount(Name,Percent_Off,Money_Off)
VALUES
("Lunch Special Medium",NULL,1);
INSERT INTO Discount(Name,Percent_Off,Money_Off)
VALUES
("Lunch Special Large",NULL,2);
INSERT INTO Discount(Name,Percent_Off,Money_Off)
VALUES
("Specialy Pizza",NULL,1.5);
INSERT INTO Discount(Name,Percent_Off,Money_Off)
VALUES
("Gameday special",20,NULL);

INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Pepperoni",1.25,0.2,100,2,2.75,3.5,4.5); -- 1
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Sausage",1.25,0.15,100,2.5,3,3.5,4.25); -- 2
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Ham",1.5,0.15,78,2,2.5,3.25,4); -- 3
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Chicken",1.75,0.25,56,1.5,2,2.25,3); -- 4
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Green Pepper",0.5,0.02,79,1,1.5,2,2.5); -- 5
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Onion",0.5,0.02,85,1,1.5,2,2.75); -- 6
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Roma Tomato",0.75,0.03,86,2,3,3.5,4.5); -- 7
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Mushrooms",0.75,0.1,52,1.5,2,2.5,3); -- 8
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Black Olives",0.6,0.1,39,0.75,1,1.5,2); -- 9
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Pineapple",1,0.25,15,1,1.25,1.75,2); -- 10
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Jalapenos",0.5,0.05,64,0.5,0.75,1.25,1.75); -- 11
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Banana Peppers",0.5,0.05,36,0.6,1,1.3,1.75); -- 12
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Regular Cheese",1.5,0.12,250,2,3.5,5,7); -- 13
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Four Cheese Blend",2,0.15,150,2,3.5,5,7); -- 14
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Feta Cheese",2,0.18,75,1.75,3,4,5.5); -- 15
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Goat Cheese",2,0.2,54,1.6,2.75,4,5.5); -- 16
INSERT INTO Topping(Name,Price,Cost,Inventory,Small_Size,Medium_Size,Large_Size,Extra_Large_Size)
VALUES
("Bacon",1.5,0.25,89,1,1.5,2,3); -- 17

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(1,13,1,(select Price from Topping WHERE ToppingID=13)*(2),(select Cost from Topping WHERE ToppingID=13)*(2)*(5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(1,1,0,(select Price from Topping WHERE ToppingID=1)*(1),(select Cost from Topping WHERE ToppingID=1)*(1)*(3.5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(1,2,0,(select Price from Topping WHERE ToppingID=2)*(1),(select Cost from Topping WHERE ToppingID=2)*(1)*(3.5));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(2,15,0,(select Price from Topping WHERE ToppingID=15)*(1),(select Cost from Topping WHERE ToppingID=15)*(1)*(3));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(2,9,0,(select Price from Topping WHERE ToppingID=9)*(1),(select Cost from Topping WHERE ToppingID=9)*(1)*(1));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(2,7,0,(select Price from Topping WHERE ToppingID=7)*(1),(select Cost from Topping WHERE ToppingID=7)*(1)*(3));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(2,8,0,(select Price from Topping WHERE ToppingID=8)*(1),(select Cost from Topping WHERE ToppingID=8)*(1)*(2));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(2,12,0,(select Price from Topping WHERE ToppingID=12)*(1),(select Cost from Topping WHERE ToppingID=12)*(1)*(1));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(3,13,0,(select Price from Topping WHERE ToppingID=13)*(1),(select Cost from Topping WHERE ToppingID=13)*(1)*(2));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(3,4,0,(select Price from Topping WHERE ToppingID=4)*(1),(select Cost from Topping WHERE ToppingID=4)*(1)*(1.5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(3,12,0,(select Price from Topping WHERE ToppingID=12)*(1),(select Cost from Topping WHERE ToppingID=12)*(1)*(0.6));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(4,13,0,(select Price from Topping WHERE ToppingID=13)*(1),(select Cost from Topping WHERE ToppingID=13)*(1)*(5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(4,1,0,(select Price from Topping WHERE ToppingID=1)*(1),(select Cost from Topping WHERE ToppingID=1)*(1)*(3.5));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(5,1,0,(select Price from Topping WHERE ToppingID=1)*(1),(select Cost from Topping WHERE ToppingID=1)*(1)*(4.5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(5,2,0,(select Price from Topping WHERE ToppingID=2)*(1),(select Cost from Topping WHERE ToppingID=2)*(1)*(4.25));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(5,14,0,(select Price from Topping WHERE ToppingID=14)*(1),(select Cost from Topping WHERE ToppingID=14)*(1)*(7));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(6,3,1,(select Price from Topping WHERE ToppingID=3)*(2),(select Cost from Topping WHERE ToppingID=3)*(2)*(4));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(6,10,1,(select Price from Topping WHERE ToppingID=10)*(2),(select Cost from Topping WHERE ToppingID=10)*(2)*(2));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(6,14,0,(select Price from Topping WHERE ToppingID=14)*(1),(select Cost from Topping WHERE ToppingID=14)*(1)*(7));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(7,11,0,(select Price from Topping WHERE ToppingID=11)*(1),(select Cost from Topping WHERE ToppingID=11)*(1)*(1.75));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(7,17,0,(select Price from Topping WHERE ToppingID=17)*(1),(select Cost from Topping WHERE ToppingID=17)*(1)*(3));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(7,14,0,(select Price from Topping WHERE ToppingID=14)*(1),(select Cost from Topping WHERE ToppingID=14)*(1)*(7));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(8,5,0,(select Price from Topping WHERE ToppingID=5)*(1),(select Cost from Topping WHERE ToppingID=5)*(1)*(2.5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(8,6,0,(select Price from Topping WHERE ToppingID=6)*(1),(select Cost from Topping WHERE ToppingID=6)*(1)*(2.75));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(8,7,0,(select Price from Topping WHERE ToppingID=7)*(1),(select Cost from Topping WHERE ToppingID=7)*(1)*(4.5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(8,8,0,(select Price from Topping WHERE ToppingID=8)*(1),(select Cost from Topping WHERE ToppingID=8)*(1)*(3));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(8,9,0,(select Price from Topping WHERE ToppingID=9)*(1),(select Cost from Topping WHERE ToppingID=9)*(1)*(2));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(8,16,0,(select Price from Topping WHERE ToppingID=16)*(1),(select Cost from Topping WHERE ToppingID=16)*(1)*(5.5));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(9,4,0,(select Price from Topping WHERE ToppingID=4)*(1),(select Cost from Topping WHERE ToppingID=4)*(1)*(2.25));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(9,5,0,(select Price from Topping WHERE ToppingID=5)*(1),(select Cost from Topping WHERE ToppingID=5)*(1)*(2));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(9,6,0,(select Price from Topping WHERE ToppingID=6)*(1),(select Cost from Topping WHERE ToppingID=6)*(1)*(2));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(9,8,0,(select Price from Topping WHERE ToppingID=8)*(1),(select Cost from Topping WHERE ToppingID=8)*(1)*(2.5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(9,14,0,(select Price from Topping WHERE ToppingID=14)*(1),(select Cost from Topping WHERE ToppingID=14)*(1)*(5));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(10,14,1,(select Price from Topping WHERE ToppingID=14)*(2),(select Cost from Topping WHERE ToppingID=14)*(2)*(5));

INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(11,13,0,(select Price from Topping WHERE ToppingID=13)*(1),(select Cost from Topping WHERE ToppingID=13)*(1)*(5));
INSERT INTO PizzaTopping(PizzaID,ToppingID,Extra_Topping,Topping_Price,Topping_Cost)
VALUES
(11,1,1,(select Price from Topping WHERE ToppingID=1)*(2),(select Cost from Topping WHERE ToppingID=1)*(2)*(3.5));

INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=1)+(select Price from Price where Size="Large" and Crust="Thin"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=1)+(select Cost from Price where Size="Large" and Crust="Thin"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Pan","Medium",(select Sum(Topping_Price) from PizzaTopping where PizzaID=2)+(select Price from Price where Size="medium" and Crust="Pan"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=2)+(select Cost from Price where Size="medium" and Crust="Pan"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Original","Small",(select Sum(Topping_Price) from PizzaTopping where PizzaID=3)+(select Price from Price where Size="small" and Crust="Original"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=3)+(select Cost from Price where Size="small" and Crust="Original"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Original","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=4)+(select Price from Price where Size="Large" and Crust="Original"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=4)+(select Cost from Price where Size="Large" and Crust="Original"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Original","Extra-Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=5)+(select Price from Price where Size="X-Large" and Crust="Original"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=5)+(select Cost from Price where Size="X-Large" and Crust="Original"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Original","Extra-Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=6)+(select Price from Price where Size="X-Large" and Crust="Original"),5.59,1);
-- ("Original","Extra-Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=6)+(select Price from Price where Size="X-Large" and Crust="Original"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=6)+(select Cost from Price where Size="X-Large" and Crust="Original"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Original","Extra-Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=7)+(select Price from Price where Size="X-Large" and Crust="Original"),5.68,1);
-- ("Original","Extra-Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=7)+(select Price from Price where Size="X-Large" and Crust="Original"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=7)+(select Cost from Price where Size="X-Large" and Crust="Original"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Gluten-Free","Extra-Large",16.85,(select Sum(Topping_Cost) from PizzaTopping where PizzaID=8)+(select Cost from Price where Size="X-Large" and Crust="Gluten-Free"),1);
-- ("Gluten-Free","Extra-Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=8)+(select Price from Price where Size="X-Large" and Crust="Gluten-Free"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=8)+(select Cost from Price where Size="X-Large" and Crust="Gluten-Free"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Thin","Large",13.25,3.2,1);
-- ("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=9)+(select Price from Price where Size="Large" and Crust="Thin"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=9)+(select Cost from Price where Size="Large" and Crust="Thin"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=10)+(select Price from Price where Size="Large" and Crust="Thin"),3.75,1);
-- ("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=10)+(select Price from Price where Size="Large" and Crust="Thin"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=10)+(select Cost from Price where Size="Large" and Crust="Thin"),1);
INSERT INTO Pizza(Crust_Type,Size,Price,Cost,Completed_By_Kitchen)
VALUES
("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=11)+(select Price from Price where Size="Large" and Crust="Thin"),2.55,1);
-- ("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=11)+(select Price from Price where Size="Large" and Crust="Thin"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=11)+(select Cost from Price where Size="Large" and Crust="Thin"),1);

INSERT INTO PizzaDiscount(PizzaID,DiscountID,Pizza_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(1,3,(select Price from Pizza where PizzaID=1),2,NULL);
INSERT INTO PizzaDiscount(PizzaID,DiscountID,Pizza_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(2,2,(select Price from Pizza where PizzaID=2),1,NULL);
INSERT INTO PizzaDiscount(PizzaID,DiscountID,Pizza_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(6,4,(select Price from Pizza where PizzaID=6),1.5,NULL);
INSERT INTO PizzaDiscount(PizzaID,DiscountID,Pizza_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(8,4,(select Price from Pizza where PizzaID=8),1.5,NULL);

INSERT INTO Customer(Name,Phone_Number,Address)
VALUES
("Andrew Wilkes-Krier","864-254-5861","115 Party Blvd, Anderson SC 29621");
INSERT INTO Customer(Name,Phone_Number,Address)
VALUES
("Matt Engers","864-474-9953",NULL);
INSERT INTO Customer(Name,Phone_Number,Address)
VALUES
("Frank Turner","864-232-8944","6745 Wessex St Anderson SC 29621");
INSERT INTO Customer(Name,Phone_Number,Address)
VALUES
("Milo Auckerman","864-878-5679","879 Suburban Home, Anderson, SC 29621");

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
(5,5,"Delivery",(select SUM(Cost) from Pizza where PizzaID=5),"2022-03-05 19:11:00",(select Price from Pizza where PizzaID=5)*(.8),1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(5,6,"Delivery",(select SUM(Cost) from Pizza where PizzaID=6),"2022-03-05 19:11:00",((select Price from Pizza where PizzaID=6)-(select COALESCE(Discount_Money_Off,0) from PizzaDiscount where PizzaID=6))*(.8),1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(5,7,"Delivery",(select SUM(Cost) from Pizza where PizzaID=7),"2022-03-05 19:11:00",(select Price from Pizza where PizzaID=7)*(.8),1);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(6,8,"Pickup",(select SUM(Cost) from Pizza where PizzaID=8),"2022-03-02 17:30:00",((select Price from Pizza where PizzaID=8)-(select COALESCE(Discount_Money_Off,0) from PizzaDiscount where PizzaID=8)),2);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(7,9,"Delivery",(select SUM(Cost) from Pizza where PizzaID=9),"2022-03-02 18:17:00",(select Price from Pizza where PizzaID=9),3);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(8,10,"Delivery",(select SUM(Cost) from Pizza where PizzaID=10),"2022-03-06 20:32:00",(select Price from Pizza where PizzaID=10)*(.85),4);
INSERT INTO Orders(OrderID,PizzaID,Order_Type,Total_Cost,Order_Time,Total_Price,Pickup_Customer)
VALUES
(8,11,"Delivery",(select SUM(Cost) from Pizza where PizzaID=11),"2022-03-06 20:32:00",(select Price from Pizza where PizzaID=11)*(.85),4);

INSERT INTO OrderDiscount(OrderID,DiscountID,Order_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(5,1,(select SUM(Total_Price) from Orders where OrderID=5),NULL,20);
INSERT INTO OrderDiscount(OrderID,DiscountID,Order_Price,Discount_Money_Off,Discount_Percent_Off)
VALUES
(8,5,(select SUM(Total_Price) from Orders where OrderID=8),NULL,15);
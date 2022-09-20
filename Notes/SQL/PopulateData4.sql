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
("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=11)+(select Price from Price where Size="Large" and Crust="Thin"),2,1);
-- ("Thin","Large",(select Sum(Topping_Price) from PizzaTopping where PizzaID=11)+(select Price from Price where Size="Large" and Crust="Thin"),(select Sum(Topping_Cost) from PizzaTopping where PizzaID=11)+(select Cost from Price where Size="Large" and Crust="Thin"),1);

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



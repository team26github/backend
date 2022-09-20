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
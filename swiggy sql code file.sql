CREATE TABLE swiggy_orders (
    Order_ID VARCHAR(50),
    User_ID BIGINT,
    Restaurant_Name VARCHAR(255),
    Cuisine_Type VARCHAR(100),
    Order_Time DATETIME,
    Delivery_Distance_km FLOAT,
    Order_Amount FLOAT,
    Discount_Applied FLOAT,
    Delivery_Status VARCHAR(50),
    Customer_Rating INT,
    Payment_Mode VARCHAR(50),
    City_Tier VARCHAR(50),
    Delivery_Time_min INT,
    Order_Date DATE,
    Order_Hours INT,
    Order_Weekday VARCHAR(20)
);

SELECT * FROM  swiggy_orders ;
   SELECT 
    Cuisine_Type,
    COUNT(*) AS Order_Count
FROM swiggy_orders
GROUP BY Cuisine_Type
ORDER BY Order_Count DESC;
 
 SELECT 
    Restaurant_Name,
    COUNT(*) AS Order_Count
FROM swiggy_orders
GROUP BY Restaurant_Name
ORDER BY Order_Count DESC;

SELECT 
    DATE(Order_Time) AS Order_Date,
    COUNT(Order_ID) AS Total_Orders
FROM swiggy_orders
GROUP BY DATE(Order_Time)
ORDER BY Order_Date;

SELECT 
    DAYNAME(Order_Time) AS Day_Name,
    COUNT(Order_ID) AS Total_Orders
FROM swiggy_orders
GROUP BY Day_Name
ORDER BY FIELD(Day_Name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

SELECT 
    User_ID,
    COUNT(Order_ID) AS Order_Frequency,
    SUM(Order_Amount) AS Total_Spent,
    City_Tier
FROM swiggy_orders
GROUP BY User_ID, City_Tier
ORDER BY Total_Spent DESC;

SELECT 
    User_ID,
    DATEDIFF('2024-05-31', MAX(Order_Time)) AS Recency,
    COUNT(Order_ID) AS Frequency,
    SUM(Order_Amount) AS Monetary
FROM swiggy_orders
GROUP BY User_ID
ORDER BY Recency ASC, Frequency DESC, Monetary DESC;

SELECT 
    ROUND(Delivery_Distance_km, 1) AS Distance_Band,
    AVG(Delivery_Time_min) AS Avg_Delivery_Time
FROM swiggy_orders
WHERE Delivery_Status = 'Delivered'
GROUP BY Distance_Band
ORDER BY Distance_Band;

SELECT 
    City_Tier,
    COUNT(CASE WHEN Delivery_Status = 'Late' THEN 1 END) AS Late_Deliveries,
    COUNT(*) AS Total_Orders,
    ROUND(100.0 * COUNT(CASE WHEN Delivery_Status = 'Late' THEN 1 END) / COUNT(*), 2) AS Late_Delivery_Rate_Percent
FROM swiggy_orders
GROUP BY City_Tier;

SELECT 
    Delivery_Time_min,
    ROUND(AVG(Customer_Rating), 2) AS Avg_Rating
FROM swiggy_orders
WHERE Delivery_Status = 'Delivered'
GROUP BY Delivery_Time_min
ORDER BY Delivery_Time_min;

SELECT
Order_Id,
Order_Amount,
Discount_Applied,
(Order_Amount-Discount_Applied) AS Revenue_After_Discount
FROM swiggy_orders;

SELECT
HOUR(Order_Time) AS Hour,
AVG(Delivery_Time_Min) AS Avg_Delivery_Min
FROM swiggy_orders
GROUP BY HOUR(Order_Time)
ORDER BY HOUR
LIMIT 10;

SELECT 
    COUNT(*) AS Discounted_Orders,
    AVG(Order_Amount) AS Avg_Discounted_Value
FROM swiggy_orders
WHERE Discount_Applied > 0 AND DATE(Order_Time) = CURDATE();

SELECT 
    COUNT(*) AS Non_Discounted_Orders,
    AVG(Order_Amount) AS Avg_Non_Discounted_Value
FROM swiggy_orders
WHERE Discount_Applied = 0 AND DATE(Order_Time) = CURDATE();

SELECT 
    user_Id,
    COUNT(Order_Id) AS Orders_Today
FROM swiggy_orders
WHERE DATE(Order_Time) = CURDATE()
GROUP BY user_Id
ORDER BY Orders_Today DESC;


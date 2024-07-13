CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    ShopID INT,
    Quantity INT,
    Price DECIMAL(18, 2),
    TransactionDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
        FOREIGN KEY (ShopID) REFERENCES Shops(ShopID)

);

package Model;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class Product {
    private int productID;
    private String productName;
    private String productDescription;
    private double price;
    private int quantity;
    private int typeID;
    private String typeName;
    private String fileName;


    public Product() {
    }

    public Product(int productID, String productName, String productDescription, double price, int quantity, int typeID, String typeName, String fileName) {
        this.productID = productID;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.typeID = typeID;
        this.typeName = typeName;
        this.fileName = fileName;
    }

    public Product(int productID, String productName, String productDescription, double price, int quantity, int typeID, String typeName) {
        this.productID = productID;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.typeID = typeID;
        this.typeName = typeName;
    }

    public Product(String productName, String productDescription, double price, int quantity, int typeID) {
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.typeID = typeID;
    }
    public Product(String productName, String productDescription, double price,String typeName, int quantity ) {
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.typeName = typeName;
    }

    public Product(int productID, String productName, String productDescription, double price, int quantity, int typeID) {
        this.productID = productID;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.typeID = typeID;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public Product(String productName, String productDescription, double price, int quantity) {
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
    }

    public Product(int productID, String productName, String productDescription, double price, int quantity) {
        this.productID = productID;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

@NotEmpty(message = "Product name is not empty")
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    @NotEmpty(message = "Product description is not empty")
    @Length(min = 10, max = 1000, message ="Length of description from 10 to 1000 characters" )
    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    @NotNull(message = "Price is not null, please enter price of product!")
    @Min(value = 1, message = "Minimum price  is $1 and price is a number")
    @Max(value = 1000000000, message = "Maximum price is 1 billion USD")
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @NotNull(message = "Quantity is not null, please enter Quantity of product")
    @Min(value = 1, message = "Minimum quantity is 1 product.")
    @Max(value = 10000, message = "Maximum Quantity is 10000 products.")
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}

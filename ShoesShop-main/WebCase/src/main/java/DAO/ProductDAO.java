package DAO;

import Model.Product;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO implements IProductDAO {
        private String jdbcURL = "jdbc:mysql://localhost:3306/planthouse?useSSL=false";
        private String jdbcUsername = "root";
        private String jdbcPassword = "123456";
    private static final String INSERT_PRODUCT_SQL = "INSERT INTO product" +
            "(productName, productDescription, price, quantity, typeID,image) VALUES" + "(?,?,?,?,?,?);";
    private static final String SELECT_ALL_PRODUCT_INNER_JOIN= "select p.productID, p.productName, p.productDescription, p.price, p.quantity,p.image, t.typeName, t.typeID \n" +
            "from product as p inner join typeproduct as t on p.typeID = t.typeID";
    private static final String SELECT_ALL_PRODUCT_INNER_JOIN_BYTYPE= "select p.productID, p.productName, p.productDescription, p.price, p.quantity,p.image, t.typeID, t.typeName " +
            " from product as p inner join typeproduct as t on p.typeID = t.typeID where p.typeID=? order by p.productID ASC ";
    private static final String SELECT_PRODUCT_SQL = "SELECT productName, productDescription, price, quantity,image from product where productID = ?;";
    private static final String DELETE_PRODUCT_SQL = "delete from product where productID = ?;";
    private static final String UPDATE_quantity = "update product set quantity =? where productID=?";
    private static final String UPDATE_PRICE = "update product set price =? where productID=?";
    private static final String UPDATE_PRODUCT_SQL = "update product" +
            " set productName = ?,productDescription =?, price= ? ,quantity =?,typeID =?, image=? where productID=?;";
    private int noOfRecord;

    public ProductDAO(){
    }
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }
    @Override
    public void insertProduct(Product product) {
        try(Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL)){
            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setString(2, product.getProductDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setInt(5, product.getTypeID());
            preparedStatement.setString(6, product.getFileName());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public Product selectProductByID(int id) {
        Product product = null;
        try(Connection connection =getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_SQL)){
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                String productName = resultSet.getString("productName");
                String productDiscription = resultSet.getString("productDescription");
                Double price = resultSet.getDouble("price");
                int quantity = resultSet.getInt("quantity");
                String img = resultSet.getString("image");
                product = new Product(productName,productDiscription,price,quantity);
                product.setFileName(img);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return product;
    }

    @Override
    public List<Product> selectAllProduct() {

        List<Product> listProduct = new ArrayList<>();
        try(Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCT_INNER_JOIN)){
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int productID = rs.getInt("productID");
                String productName = rs.getString("productName");
                String productDiscription = rs.getString("productDescription");
                Double price = Double.valueOf(rs.getString("price"));
                int quantity = Integer.parseInt(rs.getString("quantity"));
                int typeID = rs.getInt("typeID");
                String image = rs.getString("image");
                String typeName = rs.getString("typeName");

                listProduct.add(new Product(productID,productName,productDiscription,price,quantity,typeID,image,typeName));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return listProduct;
    }
    public boolean selectProductByPrice(String productName, double price, int type){
        for (Product product : selectAllProduct()){
            if (product.getProductName().equals(productName)&&product.getPrice()==price&&product.getTypeID()==product.getTypeID()){
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean deleteProductByID(int ID) {
        boolean rowDelete;
        try(Connection connection =getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {
            preparedStatement.setInt(1, ID);
            rowDelete = preparedStatement.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rowDelete;
    }

    @Override
    public boolean updateQuantityProduct(int ID, int quantity) {
        boolean rowUpdate;
        try(Connection connection =getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_quantity)) {
            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, ID);
            rowUpdate = preparedStatement.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rowUpdate;
    }

    @Override
    public boolean updatePriceOfProduct(int ID, double price) {
        boolean rowUpdate;
        try(Connection connection =getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRICE)) {
            preparedStatement.setInt(2, ID);
            preparedStatement.setDouble(1, price);
            rowUpdate = preparedStatement.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rowUpdate;
    }

    @Override
    public boolean updateProductByID(Product product) {
        boolean updateProduct = true;
        try(Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_SQL)){
            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setString(2, product.getProductDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setInt(5, product.getTypeID());
            preparedStatement.setString(6, product.getFileName());
            preparedStatement.setInt(7, product.getProductID());
            updateProduct = preparedStatement.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return updateProduct;
    }

    public List<Product> selectProductFilter(int TypeID){
        String query = "select SQL_CALC_FOUND_ROWS p.productID, p.productName, p.productDescription, p.price, p.quantity,p.image, t.typeName, t.typeID" +
                " from product as p inner join typeproduct as t on t.typeID = p.typeID where p.typeID = "+TypeID+" order by p.productID DESC ;";
        System.out.println("hello");
        List<Product> listProdcut = new ArrayList<>();
        Product product =null;
        Connection connection =null;
        Statement statement =null;
        try{
            connection =getConnection();
            statement= connection.createStatement();
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()){
                product =new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setProductDescription(rs.getString("productDescription"));
                product.setPrice(Double.valueOf(rs.getString("price")));
                product.setQuantity(Integer.parseInt(rs.getString("quantity")));
                product.setTypeID(rs.getInt("typeID"));
                product.setFileName(rs.getString("image"));
                product.setTypeName(rs.getString("typeName"));
                listProdcut.add(product);
            }
            rs.close();
            rs=statement.executeQuery("select found_rows()");
            if (rs.next()){
                this.noOfRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }finally {
            try {
                if (statement!=null){
                    statement.close();
                }
                if (connection!=null){
                    connection.close();
                }
            } catch (SQLException e) {
                printSQLException(e);
            }
        }
        return listProdcut;
    }
    public List<Product> selectProductPagging(int offset, int noOfRecord){
        String query = "select SQL_CALC_FOUND_ROWS p.productID, p.productName, p.productDescription, p.price, p.quantity,p.image, t.typeName, t.typeID" +
                " from product as p inner join typeproduct as t where p.typeID = t.typeID group by p.productID" +
                " limit "+offset+", "+noOfRecord+";";
        List<Product> listProdcut = new ArrayList<>();
        Product product =null;
        Connection connection =null;
        Statement statement =null;
        try{
            connection =getConnection();
            statement= connection.createStatement();
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()){
                product =new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setProductDescription(rs.getString("productDescription"));
                product.setPrice(Double.valueOf(rs.getString("price")));
                product.setQuantity(Integer.parseInt(rs.getString("quantity")));
                product.setTypeID(rs.getInt("typeID"));
                product.setFileName(rs.getString("image"));
                product.setTypeName(rs.getString("typeName"));

                listProdcut.add(product);
            }
            rs.close();
            rs=statement.executeQuery("select found_rows()");
            if (rs.next()){
                this.noOfRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }finally {
            try {
                if (statement!=null){
                    statement.close();
                }
                if (connection!=null){
                    connection.close();
                }
            } catch (SQLException e) {
                printSQLException(e);
            }
        }
        return listProdcut;
    }

    @Override
    public List<Product> selectProductByType(int typeID) {
        List<Product> list = new ArrayList<>();
        try(Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCT_INNER_JOIN_BYTYPE)){
            preparedStatement.setInt(1,typeID);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                Product product = new Product();
                product.setProductID(resultSet.getInt(1));
                product.setProductName(resultSet.getString(2));
                product.setProductDescription(resultSet.getString(3));
                product.setPrice(resultSet.getDouble(4));
                product.setQuantity(resultSet.getInt(5));
                product.setFileName(resultSet.getString(6));
                product.setTypeID(resultSet.getInt(7));
                product.setTypeName(resultSet.getString(8));
                list.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Product> selectProductPaggingFilter(int offset, int noOfRecord, int typeID){
        String query = "select SQL_CALC_FOUND_ROWS p.productID, p.productName, p.productDescription, p.price, p.quantity,p.image, t.typeName, t.typeID" +
                " from product as p inner join typeproduct as t on p.typeID = "+typeID+"  group by p.productID" +
                " limit "+offset+", "+noOfRecord+";";
        List<Product> listProdcut = new ArrayList<>();
        Product product =null;
        Connection connection =null;
        Statement statement =null;
        try{
            connection =getConnection();
            statement= connection.createStatement();
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()){
                product =new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setProductDescription(rs.getString("productDescription"));
                product.setPrice(Double.valueOf(rs.getString("price")));
                product.setQuantity(Integer.parseInt(rs.getString("quantity")));
                product.setTypeID(rs.getInt("typeID"));
                product.setTypeName(rs.getString("typeName"));
                product.setFileName(rs.getString("image"));
                listProdcut.add(product);
            }
            rs.close();
            rs=statement.executeQuery("SELECT FOUND_ROWS()");
            if (rs.next()){
                this.noOfRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }finally {
            try {
                if (statement!=null){
                    statement.close();
                }
                if (connection!=null){
                    connection.close();
                }
            } catch (SQLException e) {
                printSQLException(e);
            }
        }
        return listProdcut;
    }
    public int getNoOfRecord(){
        return noOfRecord;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }


}

<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: Quoc Nhat--%>
<%--  Date: 9/21/2022--%>
<%--  Time: 9:12 AM--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: Admin--%>
<%--  Date: 07/08/2022--%>
<%--  Time: 12:44 CH--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Product Management</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<h1>Product User</h1>--%>
<%--<div>--%>
<%--    <form method="post">--%>
<%--        <table border="1" cellpadding="5">--%>
<%--            <tr>--%>
<%--                <td style="display: none">--%>
<%--                    <input type="text" name="userID" id="productID" size="45" value="${product.getProductID()}"/>--%>
<%--                </td>--%>
<%--                <th>Product Name: </th>--%>
<%--                <td>--%>
<%--                    <input type="text" name="userName" id="productName" size="45" value="${product.getProductName()}"/>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <th>Product Description: </th>--%>
<%--                <td>--%>
<%--                    <input type="text" name="password" id="productDescription" size="45" value="${product.getProductDescription()}"/>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <th>Price: </th>--%>
<%--                <td>--%>
<%--                    <input type="text" name="fullName" id="price" size="45" value="${product.getPrice()}"/>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <th>Quantity:</th>--%>
<%--                <td>--%>
<%--                    <input type="number" name="age" id="quantity" size="45" value="${product.getQuantity()}"/>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <th>Type:</th>--%>
<%--                <td>--%>
<%--                    <select name="country" id="">--%>
<%--                        <c:forEach items="${applicationScope.countryList}" var="country">--%>
<%--                            <option value="${country.getIdCountry()}">${country.getCountryName()}</option>--%>
<%--                        </c:forEach>--%>
<%--                    </select>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="2" align="center">--%>
<%--                    <input type="submit" value="save">--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </form>--%>
<%--    <div class="text-danger mt-2 w-100">--%>
<%--        <c:if test="${requestScope.errors!=null}">--%>
<%--            <div class="alert alert-icon alert-danger alert-dismissible fade show mb-0" role="alert">--%>
<%--                <button type="button" class="close" data-dismiss="alert" aria-label="Close">--%>
<%--                    <span aria-hidden="true">×</span>--%>
<%--                </button>--%>
<%--                <h3 class="text-center">Warning</h3>--%>
<%--                <c:forEach items="${errors}" var="String">--%>
<%--                    <ul><h5>${(String.key).toUpperCase()}</h5></ul>--%>
<%--                    <c:forEach items="${String.value}" var="message">--%>
<%--                        <li>${message}</li>--%>
<%--                    </c:forEach>--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </c:if>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
    <%--    <meta charset="UTF-8">--%>
    <title>Product Management</title>
    <jsp:include page="/WEB-INF/layout/head-meta.jsp"></jsp:include>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
          integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        * {
            font-family: "Segoe UI", SegoeUI, "Helvetica Neue", Helvetica, Arial, sans-serif;
        }
    </style>
</head>

<body>

<!-- Begin page -->
<div id="wrapper" style="background-color: #d8dadb">
    <c:choose>
        <c:when test="${logincheck!=null}">
            <c:if test="${typeUser.equalsIgnoreCase('admin')}">
                <jsp:include page="/WEB-INF/layout/top-nav.jsp"></jsp:include>
            </c:if>
            <c:if test="${typeUser.equalsIgnoreCase('user')}">
                <jsp:include page="/WEB-INF/layout/top-nav-user.jsp"></jsp:include>
            </c:if>
        </c:when>
        <c:otherwise>
            <jsp:include page="/WEB-INF/layout/top-nav-nologin.jsp"></jsp:include>
        </c:otherwise>
    </c:choose>
    <!-- Navigation Bar-->
    <!-- End Navigation Bar-->
    <div class="content-page">
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card-box" style="background-color: #FFFFFF">
                            <table class="table"
                                   style="border-collapse: collapse; border-spacing: 0; width: 100%;color: black">
                                <tr class="w-100">
                                    <h3 class="text-white m-3">Product List</h3>
                                    <span class="float-right">
                                        <form method="post" action="/product?action=filter">
                                            <label>Select by Type: </label>
                                                    <select name="typeID">
                                                        <option value="-1">ALL</option>
                                                        <c:forEach items="${applicationScope.listType}" var="type">
                                                            <option value="${type.getTypeID()}">${type.getTypeName()}</option>
                                                        </c:forEach>
                                                     </select>
                                            <input type="submit" value="Submit" class="bg-success text-white"
                                                   style="border-radius: 6px; border: 1px solid lightslategrey">
                                        </form>
                                    </span>
                                </tr>
                                <thead>
                                <tr class="bg-dark text-white">
                                    <th>Product ID</th>
                                    <th>Product Image</th>
                                    <th>Product Name</th>
                                    <th>Product Description</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Type</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody style="color: darkslategray;line-height: 200px;font-size: 14px; font-weight: 500;">
                                <c:forEach var="product" items="${listProduct}" varStatus="i">
                                    <tr>
                                            <%--                                        <td><c:out value="${product.productID}"/></td>--%>
                                        <td><c:out value="${i.count}"/></td>
                                        <td style="height: 180px"><img src="images/${product.getFileName()}" alt="#"
                                                                       style="height: 100%"></td>
                                        <td><c:out value="${product.productName}"/></td>
                                        <td><c:out value="${product.productDescription}"/></td>


<%--                                        <td><fmt:formatNumber value="${product.price}" type="currency"/></td>--%>
                                        <td> <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" /></td>

                                            <%--                                        <td><c:out value="${product.price}"/></td>--%>
                                        <td><c:out value="${product.quantity}"/></td>
                                            <%--                        <td style="display:none;"><c:out value="${product.typeID}"/></td>--%>
                                        <td><c:out value="${product.typeName}"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${typeUser.equalsIgnoreCase('ADMIN')}">
                                                    <a href="/product?action=update&productID=${product.productID}"
                                                       class="w-45 float-left">
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                        <span style="color: #3296d0d4">Edit</span>
                                                    </a>
                                                    <a name="productID"
                                                       href="/product?action=delete&productID=${product.productID}"
                                                       onclick="return confirm('Do you wanna delete this product?')"
                                                       class="float-right w-45">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                        <span style="color: #ff45008c">Delete</span>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${filter.equalsIgnoreCase('filter')}">
                                                            <a href="/product?action=order&productID=${product.productID}&filter=${product.getTypeID()}"
                                                               onclick="return confirm('Do you wanna add this product on shopping cart?')">
                                                                <i class="fe-shopping-cart"></i>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="/product?action=order&productID=${product.productID}"
                                                               onclick="return confirm('Do you wanna add this product on shopping cart?')">
                                                                <i class="fe-shopping-cart"></i>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:choose>
        <c:when test="${filter.equalsIgnoreCase('filter')}">
            <div class="col-12 w-100 mb-5">
                <div class="container-fluid mt-2">
                    <div class="float-right">
                        <c:if test="${currentPages!=1}">
                            <a href="product?action=filter&typeID=${typeProduct}&pages=${currentPages-1}"
                               class="p-2 mr-1 border">Previous</a>
                        </c:if>
                        <c:forEach begin="1" end="${noOfPage}" var="i">
                            <c:choose>
                                <c:when test="${currentPages eq 0}">
                                    <a href="product?action=filte&typeID=${typeProduct}r&pages=${i}"
                                       class="p-2 mr-1 border">${i}</a>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${currentPages==i}">
                                            <a href="product?action=filter&typeID=${typeProduct}&pages=${i}"
                                               class="p-2 mr-1 border"
                                               style="font-weight: bold;font-size: large">${i}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="product?action=filter&typeID=${typeProduct}&pages=${i}"
                                               class="p-2 mr-1 border">${i}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPages<noOfPage}">
                            <a href="product?action=filter&typeID=${typeProduct}&pages=${currentPages+1}"
                               class="p-2 mr-1 border">Next</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="col-12 w-100 mb-5">
                <div class="container-fluid mt-2">
                    <div class="float-right">
                        <c:if test="${currentPage!=1}">
                            <a href="product?page=${currentPage-1}" class="p-2 mr-1 border">Previous</a>
                        </c:if>
                        <c:forEach begin="1" end="${noOfPage}" var="i">
                            <c:choose>
                                <c:when test="${currentPage eq 0}">
                                    <a href="product?page=${i}" class="p-2 mr-1 border">${i}</a>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${currentPage==i}">
                                            <a href="product?page=${i}" class="p-2 mr-1 border"
                                               style="font-weight: bold;font-size: large">${i}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="product?page=${i}" class="p-2 mr-1 border">${i}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage<noOfPage}">
                            <a href="product?page=${currentPage+1}" class="p-2 mr-1 border">Next</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<!-- form comfirm-->
<!--end form comfirm-->
<!-- END wrapper -->
<jsp:include page="/WEB-INF/layout/footer-js.jsp"></jsp:include>
<!-- Code injected by live-server -->

<!-- test-->
<c:if test="${requestScope.success!=null}">
    <script>
        $(document).ready(function () {
            <% String message= (String) request.getAttribute("success"); %>
            var success = "<%= message %>";
            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
            toastr["success"](success)
        });
    </script>
</c:if>
</body>

</html>
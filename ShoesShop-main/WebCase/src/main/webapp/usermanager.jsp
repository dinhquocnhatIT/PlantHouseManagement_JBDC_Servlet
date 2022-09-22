<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <%--    <meta charset="UTF-8">--%>
    <title>Product Management</title>
    <jsp:include page="/WEB-INF/layout/head-meta.jsp"></jsp:include>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<body>
<!-- Begin page -->
<div id="wrapper" style="background-color: #d8dadb">
    <c:choose>
        <c:when test="${logincheck!=null}">
            <c:if test="${typeUser.equalsIgnoreCase('admin')}">
                <jsp:include page="/WEB-INF/layout/top-nav.jsp"></jsp:include>
            </c:if>
        </c:when>
        <c:otherwise>
            <jsp:include page="/WEB-INF/layout/top-nav-user.jsp"></jsp:include>
        </c:otherwise>
    </c:choose>
    <div class="content-page pt-3">
        <div class="content">
            <!-- Start Content-->
            <div class="container-fluid">
                <!-- end page title -->
                <div class="row">
                    <div class="col-lg-4 col-xl-4">
                        <div class="card-box text-center" style="background-color: #FFFFFF;width: 1248px;height: 800px;">
                            <img src="728.jpg" class="avatar-lg img-thumbnail"
                                 alt="profile-image" style="background-color: #ffffff; border: 1px solid #f1f2f2;height: 11rem; width: 11rem">
                            <h3 class="mb-0" style="color: black">${User.getFullName()}</h3>
                            <div class="text-left mt-3">
                                <h1 class="font-13 text-uppercase" style="color: #59acef; text-align: center;font-size: 20px">USER INFORMATION</h1>
                                <p class="text-muted mb-2 font-13"><strong style="color: black;font-size: 16px">User Name :</strong> <span
                                        class="ml-2" style="color: black;font-size: 16px">${User.getUserName()}</span>
                                </p>
                                <p class="text-muted mb-1 font-13"><strong style="color: black;font-size: 16px">Password :</strong> <span
                                        class="ml-2" style="color: black">***********</span>
<%--                                    <a href="/users?action=changepassword" class="float-right" style="color: steelblue">change</a>--%>
                                </p>
                                <p class="text-muted mb-2 font-13"><strong style="color: black;font-size: 16px">Mobile :</strong>
                                    <span class="ml-2" style="color: black;font-size: 16px">${User.getPhoneNumber()}</span>
<%--                                    <a href="#" class="float-right">change</a>--%>
                                </p>
                                <p class="text-muted mb-2 font-13"><strong style="color: black;font-size: 16px">Email :</strong> <span
                                        class="ml-2 " style="color: black;font-size: 16px">${User.getEmail()}</span>
<%--                                    <a href="#" class="float-right">change</a>--%>
                                </p>
                                <p class="text-muted mb-1 font-13"><strong style="color: black;font-size: 16px">Location :</strong> <span
                                        class="ml-2" style="color: black;font-size: 16px">${Address}</span>
                                </p>
                            </div>
<%--                            <a href="/product?action=update&productID=${product.productID}"--%>
<%--                               class="w-45 float-left">--%>
<%--                                <i class="fa-solid fa-pen-to-square"></i>--%>
<%--                                <span style="color: #3296d0d4">Edit</span>--%>
<%--                            </a>--%>
<%--                            <a name="productID"--%>
<%--                               href="/product?action=delete&productID=${product.productID}"--%>
<%--                               onclick="return confirm('Do you wanna delete this product?')"--%>
<%--                               class="float-right w-45">--%>
<%--                                <i class="fa-solid fa-trash-can"></i>--%>
<%--                                <span style="color: #ff45008c">Delete</span>--%>
<%--                            </a>--%>

                        </div> <!-- end card-box -->

                    </div> <!-- end col-->

                    <c:if test="${password!=null}">
                        <div class="col-lg-8 col-xl-8">
                            <div class="card-box">
                                <form class="mt-2 mb-3" method="post">
                                    <div class="input-icon">Password: </div>
                                    <div class="form-items">
                                        <input type="password" class="form-control" placeholder="input now password" name="password"></input>
                                        <div>${errorspw}</div>
                                    </div>
                                    <div class="input-icon">New Password: </div>
                                    <div class="form-items">
                                        <input type="password" class="form-control" placeholder="input now password" name="newpassword"></input>
                                        <div>${errorspw2}</div>
                                    </div>
                                    <div class="input-icon">Retype New Password: </div>
                                    <div class="form-items">
                                        <input type="password" class="form-control" placeholder="input now password" name="newpasswordreaplay"></input>
                                        <div>${errorspw2}</div>
                                    </div>
                                    <input type="submit" value="Change Password" class="btn btn-primary mt-2">
                                </form>
                                <div class="mt-2">
                                    <c:if test="${requestScope.errors!=null}">
                                        <div class="alert alert-icon alert-danger alert-dismissible fade show mb-0" role="alert">
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">×</span>
                                            </button>
                                            <h3 class="text-center">Warning</h3>
                                            <c:forEach items="${errors}" var="String">
                                                <ul><h5>${(String.key).toUpperCase()}</h5></ul>
                                                <c:forEach items="${String.value}" var="message">
                                                    <li>${message}</li>
                                                </c:forEach>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                            </div> <!-- end card-box-->
                        </div>
                    </c:if>
                </div>
                <!-- end row-->
            </div> <!-- container -->
        </div> <!-- content -->
    </div>
</div>
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
<!-- Right bar overlay-->

<jsp:include page="/WEB-INF/layout/footer-js.jsp"></jsp:include>
</body>
</html>
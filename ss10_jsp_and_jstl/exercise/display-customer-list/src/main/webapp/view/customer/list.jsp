<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 29/09/2022
  Time: 10:49 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>Danh sách khách hàng</h1>
<table border="1">
    <tr>
        <th>Tên</th>
        <th>Ngày sinh</th>
        <th>Địa chỉ</th>
        <th>Ảnh</th>
    </tr>
    <c:forEach var="customer" items="${customerList}" varStatus="status">
        <tr>
            <td>${customer.getName()}</td>
            <td>${customer.getBirthDay()}</td>
            <td>${customer.getAddress()}</td>
            <td><img src="${customer.getImg()}" alt="ảnh con người" width="100" height="100"></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

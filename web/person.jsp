<%--
  Created by IntelliJ IDEA.
  User: Joshua.McCann
  Date: 7/13/2017
  Time: 10:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>Person Management</title>

  <link rel="stylesheet" href="./static/css/site.css" />
</head>
<body>
  <div class="border">
    <span class="bordertitle">Select Person</span>
    <form name="choosePerson" action="./person" method="post">
      <input type="hidden" name="formName" value="choosePerson" />

      <select name="selectPerson">
        <option value="0">(Select Person)</option>

        <c:forEach var="person" items="${personList}">
          <c:choose>
            <c:when test="${person.personId==personId}">
              <option value="${person.personId}" selected>${person.firstName} ${person.lastName}</option>
            </c:when>
            <c:otherwise>
              <option value="${person.personId}">${person.firstName} ${person.lastName}</option>
            </c:otherwise>
          </c:choose>
        </c:forEach>

      </select>

      ${selectPerson}

      <button type="submit" >Select Person</button>

    </form>
  </div>

  <div class="border">
    <span class="bordertitle">Update Person</span>
    <form name="updatePerson" action="./person" method="post">
      <input type="hidden" name="formName" value="updatePerson" />
      <input type="hidden" name="personId" value="${personId}" />

      <div>
        <input type="text" name="title" value="${title}" placeholder="Title" />
      </div>
      <div>
        <input type="text" name="firstName" value="${firstName}" placeholder="First Name" />
      </div>
      <div>
        <input type="text" name="lastName" value="${lastName}" placeholder="Last Name" />
      </div>
      <div>
        <input type="text" name="displayName" value="${displayName}" placeholder="Display Name" />
      </div>
      <div>
        <input type="text" name="gender" value="${gender}" placeholder="Gender" />
      </div>
      <div>
        <input type="text" name="isDeleted" value="${isDeleted}" placeholder="Is Deleted" />
      </div>

      <button type="submit" >Update Person</button>

      <hr>
      ${updateStatus}

    </form>
  </div>

</body>
</html>

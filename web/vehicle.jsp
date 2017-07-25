<%--
  Created by IntelliJ IDEA.
  User: Joshua.McCann
  Date: 7/14/2017
  Time: 2:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>Vehicle Management</title>

  <link rel="stylesheet" href="./static/css/site.css" />
  <style>
    [class*="col-"] {
      padding: .3em;
    }
    .col-1 > input{
      width: 5.5em;
    }
    .col-2 > input {
      width: 15.5em;
    }
    .col-3 > input {
      width: 4.5em;
    }
    .col-4 > input {
      width: 4.8em;
    }
    .col-5 > select {
      width: 16.5em;
    }
    .col-6 > select {
      width: 16.5em;
    }

    .col-1{
      min-width: 5em;
    }
    .col-2 {
      min-width: 13.5em;
    }
    .col-3 {
      min-width: 4em;
    }
    .col-4 {
      min-width: 4.3em;
    }
    .col-5 {
      min-width: 14em;
    }
    .col-6 {
      min-width: 14em;
    }

  </style>

</head>
<body>
<div class="border">
  <span class="borderTitle">Create Vehicle</span>
  <div class="content">
    <form name="createVehicle" action="./vehicle" method="post" id="0">
      <input type="hidden" name="formName" value="createVehicle" />
      <input type="hidden" name="vehicleId" value="0" />
      <div class="contentRow">
        <select class="make">
          <option value="0" class="visible">(Select Make)</option>
          <c:forEach var="vehicleMake" items="${vehicleMakeList}">
            <option value="${vehicleMake.getVehicleMakeId()}">${vehicleMake.getVehicleMakeName()}</option>
          </c:forEach>
        </select>
      </div>
      <div class="contentRow">
        <select id="model0" name="model" class="model">
          <option value="0" class="visible">(Select Model)</option>
          <c:forEach var="vehicleModel" items="${vehicleModelList}">
            <option value="${vehicleModel.getVehicleModelId()}" class="${vehicleModel.getVehicleMakeId()}">${vehicleModel.getVehicleModelName()}</option>
          </c:forEach>
        </select>
      </div>
      <div class="contentRow">
        <div class = "label">
          <label>Plate:</label>
        </div>
        <div class = "input">
          <input type="text" name="plate" placeholder="License Plate" maxlength="10"/>
        </div>
      </div>
      <div class="contentRow">
        <div class = "label">
          <label>VIN:</label>
        </div>
        <div class = "input">
          <input type="text" name="vin" placeholder="VIN" maxlength="20"/>
        </div>
      </div>
      <div class="contentRow">
        <div class = "label">
          <label>Year:</label>
        </div>
        <div class = "input">
          <input type="text" name="year" placeholder="Year" maxlength="4"/>
        </div>
      </div>
      <div class="contentRow">
        <div class = "label">
          <label>Color:</label>
        </div>
        <div class = "input">
          <input type="text" name="color" placeholder="Color" maxlength="10"/>
        </div>
      </div>
      <div class="contentRow">
        <button type="submit" >Add Vehicle</button>
      </div>
    </form>
    <div>
      <div class="contentRow">
        <hr>
        ${insertStatus}
      </div>
    </div>
  </div>
</div>

<div class="border" style="width: auto; text-align: left;">
  <span class="borderTitle">Modify Vehicles</span>
  <div class="content">
    <div class="contentHead">
      <div class="contentRow">
        <div class="col-1">Plate</div>
        <div class="col-2">VIN</div>
        <div class="col-3">Year</div>
        <div class="col-4">Color</div>
        <div class="col-5">Make</div>
        <div class="col-6">Model</div>
      </div>
    </div>
    <c:forEach var="vehicle" items="${vehicleList}">
      <form name="modifyVehicle${vehicle.getVehicleId()}" action="./vehicle" method="post" id="${vehicle.getVehicleId()}">
        <input type="hidden" name="formName" value="modifyVehicle" />
        <input type="hidden" name="vehicleId" value="${vehicle.getVehicleId()}" />
        <div class="contentRow">
          <div class="col-1">
            <c:choose>
              <c:when test="${vehicle.getLicensePlate()!=null}">
              <input type="text" name="plate" placeholder="${vehicle.getLicensePlate()}" maxlength="10"/>
              </c:when>
              <c:otherwise>
              <input type="text" name="plate" placeholder="No Plate" maxlength="10"/>
              </c:otherwise>
            </c:choose>
          </div>
          <div class="col-2">
            <input type="text" name="vin" placeholder="${vehicle.getVIN()}" maxlength="20"/>
          </div>
          <div class="col-3">
            <input type="text" name="year" placeholder="${vehicle.getYear()}" maxlength="4"/>
          </div>
          <div class="col-4">
            <input type="text" name="color" placeholder="${vehicle.getColor()}" maxlength="10"/>
          </div>
          <div class="col-5">
            <select class="make">
              <option value="0" class="visible">(Select Model)</option>
              <c:forEach var="vehicleMake" items="${vehicleMakeList}">
                <c:choose>
                  <c:when test="${vehicle.getVehicleMakeId()==vehicleMake.getVehicleMakeId()}">
                  <option value="${vehicleMake.getVehicleMakeId()}" selected>${vehicleMake.getVehicleMakeName()}</option>
                  </c:when>
                  <c:otherwise>
                  <option value="${vehicleMake.getVehicleMakeId()}">${vehicleMake.getVehicleMakeName()}</option>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </select>
          </div>
          <div class="col-6">
            <select id="model${vehicle.getVehicleId()}" name="model" class="model">
              <option value="0" class="visible">(Select Model)</option>
              <c:forEach var="vehicleModel" items="${vehicleModelList}">
                <c:choose>
                  <c:when test="${vehicle.getVehicleModelId()==vehicleModel.getVehicleModelId()}">
                  <option value="${vehicleModel.getVehicleModelId()}" class="${vehicleModel.getVehicleMakeId()}" selected disabled>${vehicleModel.getVehicleModelName()}</option>
                  </c:when>
                  <c:otherwise>
                  <option value="${vehicleModel.getVehicleModelId()}" class="${vehicleModel.getVehicleMakeId()}">${vehicleModel.getVehicleModelName()}</option>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </select>
          </div>
          <div class="col-">
            <button type="submit" name="action" value="update">Update</button>
          </div>
          <div class="col-">
            <button type="submit" name="action" value="delete">Delete</button>
          </div>
        </div>
      </form>
    </c:forEach>
  </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
  $(document).ready(function(){
    $(".model > option").hide();
    $(".model > .visible").show();
    $(".make").each(function(){
      $(".model#model"+$(this).closest("form").attr("id")+" > ."+$(this).val()).show();
    });
    $(".make").change(function(){
      $(".model#model"+$(this).closest("form").attr("id")+" > option").hide();
      $(".model#model"+$(this).closest("form").attr("id")+" > .visible").show();
      $(".model#model"+$(this).closest("form").attr("id")+" > ."+$(this).val()).show();
    });
  });
</script>
</body>
</html>

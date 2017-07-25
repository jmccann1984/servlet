package com.astontech.servlet;

import astontech.dao.VehicleDAO;
import astontech.dao.mysql.VehicleDAOImpl;
import astontech.dao.VehicleMakeDAO;
import astontech.dao.mysql.VehicleMakeDAOImpl;
import astontech.dao.VehicleModelDAO;
import astontech.dao.mysql.VehicleModelDAOImpl;
import com.astontech.bo.Vehicle;
import common.helpers.ServletHelper;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Joshua.McCann on 7/14/2017.
 */
@WebServlet(name = "VehicleServlet")
public class VehicleServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(VehicleServlet.class);
    final static VehicleDAO vehicleDAO = new VehicleDAOImpl();
    final static VehicleMakeDAO vehicleMakeDAO = new VehicleMakeDAOImpl();
    final static VehicleModelDAO vehicleModelDAO = new VehicleModelDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        switch(request.getParameter("formName")) {
            case "createVehicle":
                addVehicle(request);
                break;
            case "modifyVehicle":
                modifyVehicle(request);
                break;
            default:
                break;
        }

        request.setAttribute("vehicleList", vehicleDAO.getVehicleList());
        request.setAttribute("vehicleModelList", vehicleModelDAO.getVehicleModelList());
        request.setAttribute("vehicleMakeList", vehicleMakeDAO.getVehicleMakeList());
        request.getRequestDispatcher("./vehicle.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("vehicleList", vehicleDAO.getVehicleList());
        request.setAttribute("vehicleModelList", vehicleModelDAO.getVehicleModelList());
        request.setAttribute("vehicleMakeList", vehicleMakeDAO.getVehicleMakeList());
        request.getRequestDispatcher("./vehicle.jsp").forward(request, response);
    }

    private static void addVehicle(HttpServletRequest request){
        ServletHelper.logRequestParams(request);

        Vehicle vehicle = new Vehicle();
        requestToVehicle(request, vehicle);

        if(vehicleDAO.insertVehicle(vehicle)!=0){
            request.setAttribute("insertStatus", "Vehicle Record Inserted into Database Successfully");
        } else {
            request.setAttribute("insertStatus", "Vehicle Record Failed Insertion");
        }

    }

    private static void modifyVehicle(HttpServletRequest request){
        switch(request.getParameter("action")){
            case "update":
                Vehicle vehicle = new Vehicle();
                requestToVehicle(request, vehicle);
                if(vehicleDAO.updateVehicle(vehicle)){
                    logger.info("Record Updated");
                } else {
                    logger.error("Record not updated");
                }
                break;
            case "delete":
                if(vehicleDAO.deleteVehicle(Integer.parseInt(request.getParameter("vehicleId")))){
                    logger.info("Record deleted");
                } else {
                    logger.error("Record not deleted");
                }
                break;
            default: break;
        }
    }

    private static void requestToVehicle(HttpServletRequest request, Vehicle vehicle){
        if(!request.getParameter("vehicleId").isEmpty())
            vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
        if(!request.getParameter("plate").isEmpty())
            vehicle.setLicensePlate(request.getParameter("plate"));
        if(!request.getParameter("vin").isEmpty())
            vehicle.setVIN(request.getParameter("vin"));
        if(!request.getParameter("year").isEmpty())
            vehicle.setYear(Integer.parseInt(request.getParameter("year")));
        if(!request.getParameter("color").isEmpty())
            vehicle.setColor(request.getParameter("color"));
        if(request.getParameter("model")!=null)
            vehicle.setVehicleModel(vehicleModelDAO.getVehicleModelById(Integer.parseInt(request.getParameter("model"))));
        logger.info(vehicle.ToString());
    }
}

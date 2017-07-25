package com.astontech.servlet;

import astontech.dao.PersonDAO;
import astontech.dao.mysql.PersonDAOImpl;
import com.astontech.bo.Person;
import common.helpers.ServletHelper;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Joshua.McCann on 7/13/2017.
 */
public class PersonServlet extends javax.servlet.http.HttpServlet {

    final static Logger logger = Logger.getLogger(PersonServlet.class);
    final static PersonDAO personDAO = new PersonDAOImpl();

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

        switch(request.getParameter("formName")) {
            case "choosePerson":
                choosePerson(request);
                break;
            case "updatePerson":
                updatePerson(request);
                break;
            default: break;
        }

        request.setAttribute("personList", personDAO.getPersonList());
        request.getRequestDispatcher("./person.jsp").forward(request, response);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

        request.setAttribute("personList", personDAO.getPersonList());
        request.setAttribute("selectPerson", generatePersonDropDownHTML(0));
        request.getRequestDispatcher("./person.jsp").forward(request, response);
    }

    private static void choosePerson(HttpServletRequest request) {
        logger.info("Form #1 - Form Name=" + request.getParameter("formName"));
        ServletHelper.logRequestParams(request);

        int id = Integer.parseInt(request.getParameter("selectPerson"));
        Person selectedPerson = personDAO.getPersonById(id);
        personToRequest(request, selectedPerson);
        request.setAttribute("selectPerson", generatePersonDropDownHTML(id));

    }

    private static void updatePerson(HttpServletRequest request) {
        logger.info("Form #2 - Form Name=" + request.getParameter("formName"));

        Person updatePerson = new Person();
        requestToPerson(request, updatePerson);

        ServletHelper.logRequestParams(request);
        if(personDAO.updatePerson(updatePerson)){
            request.setAttribute("updateStatus", "Person Updated in Database Successfully!");
        } else {
            request.setAttribute("updateStatus", "Person Update FAILED!!!");
        }

        personToRequest(request, updatePerson);

        updatePerson = personDAO.getPersonById(updatePerson.getPersonId());
        personToRequest(request, updatePerson);
        request.setAttribute("selectPerson", generatePersonDropDownHTML(Integer.parseInt(request.getParameter("personId"))));
    }

    private static String generatePersonDropDownHTML(int id) {
        StringBuilder strBld = new StringBuilder();

        strBld.append("<select name='selectPerson'>");
        if (id == 0) {
            strBld.append("<option value='0' selected disabled>(Select Person)</option>");
        } else {
            strBld.append("<option value='0' disabled>(Select Person)</option>");
        }
        for(Person person : personDAO.getPersonList()){
            strBld.append("<option value='").append(person.getPersonId()).append("'");
            if(person.getPersonId()==id)
                strBld.append(" selected ");
            strBld.append(">").append(person.getFullName()).append("</option>");
        }
        strBld.append("</select>");
        return strBld.toString();
    }

    private static void requestToPerson(HttpServletRequest request, Person person){

        person.setPersonId(Integer.parseInt(request.getParameter("personId")));
        person.setTitle(request.getParameter("title"));
        person.setFirstName(request.getParameter("firstName"));
        person.setLastName(request.getParameter("lastName"));
        person.setDisplayFirstName(request.getParameter("displayName"));
        person.setGender(request.getParameter("gender").toUpperCase().charAt(0));
        person.setIsDeleted(Byte.parseByte(request.getParameter("isDeleted")));
        logger.info(person.ToString());

    }

    private static void personToRequest(HttpServletRequest request, Person person){
        request.setAttribute("personId", person.getPersonId());
        request.setAttribute("title", person.getTitle());
        request.setAttribute("firstName", person.getFirstName());
        request.setAttribute("lastName", person.getLastName());
        request.setAttribute("displayName", person.getDisplayFirstName());
        request.setAttribute("gender", person.getGender());
        request.setAttribute("isDeleted", person.getIsDeleted());
    }
}

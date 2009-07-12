package de.berlios.jhelpdesk.web.manager.users;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import de.berlios.jhelpdesk.dao.UserDAO;

public class ShowAllUsersController implements Controller {

	// private static Log log = LogFactory.getLog(ShowAllUsersController.class);
	private UserDAO userDAO;

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("manager/users/showAll");
		mav.addObject("users", userDAO.getAllUser());
		return mav;
	}

	/** @param userDAO the userDAO to set */
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
}
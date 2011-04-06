package de.berlios.jhelpdesk.dao;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
        "classpath:helpdesk-datasource.xml", // baza testowa
        "classpath:helpdesk-annotation.xml"})
public class UserDAOTest {

    private final static Long ADMIN_ID = 1L;

    @Autowired
    private UserDAO userDAO;

    @Test
    public void testGetByIdWithNonexistingUser() throws Exception {
        Assert.assertNull(userDAO.getById(-1L));
    }

    @Test
    public void testGetByIdWithExistingUser() throws Exception {
        User user = userDAO.getById(ADMIN_ID); // 1 -> admin
        Assert.assertNotNull(user);
        Assert.assertEquals(ADMIN_ID, user.getUserId());
    }

    @Test
    public void testGetByEmailWithNonExistingUser() throws Exception {
        User user = userDAO.getByEmail("non_existing_user@non-existing-host.com");
        Assert.assertNull(user);
    }

    @Test
    public void testGetByEmailWithExistingUser() throws Exception {
        User user = userDAO.getByEmail("admin@localhost.localdomain");
        Assert.assertNotNull(user);
        Assert.assertEquals(ADMIN_ID, user.getUserId());
    }

    // TODO: do przetestowania jeszcze domyślne wartości preferencji użytkownika

    @Test
    public void testDefaultsForNewlyCreatedUser() throws Exception {
        User user = new User(null, "NU_FIRSTNAME", "NU_LASTNAME");
        user.setPassword("topsecret");
        user.setActive(false);
        user.setEmail("new_user@localhost.localdomain");
        user.setMobile("666789456");
        user.setPhone("22789346523");
        user.setUserRole(Role.CLIENT);
        userDAO.saveOrUpdate(user);
        Assert.assertNotNull(user.getUserId());
    }
}

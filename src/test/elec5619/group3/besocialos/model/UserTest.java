package elec5619.group3.besocialos.model;

import elec5619.group3.besocialos.model.User;
import junit.framework.TestCase;

public class UserTest extends TestCase{
    private User user;

    public void setUp(){
        user = new User();
    }

    public void testSetAndGetId() {
        Long testId = 460430593L;
        assertNull(user.getId());
        user.setId(testId);
        assertEquals(testId, user.getId());
    }

    public void testSetAndGetName() {
        String testName = "Humphrey";
        assertNull(user.getName());
        user.setName(testName);
        assertEquals(testName, user.getName());
    }
    public void testSetAndGetEmail() {
        String testEmail = "usydmpe@gmail.com";
        assertNull(user.getEmail());
        user.setEmail(testEmail);
        assertEquals(testEmail, user.getEmail());
    }
}
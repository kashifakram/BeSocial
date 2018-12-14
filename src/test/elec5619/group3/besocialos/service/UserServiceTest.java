package elec5619.group3.besocialos.service;

import elec5619.group3.besocialos.config.Config;
import elec5619.group3.besocialos.config.HibernateConfig;
import elec5619.group3.besocialos.config.WebMVCConfig;
import elec5619.group3.besocialos.domain.PostDao;
import elec5619.group3.besocialos.domain.UserDao;
import elec5619.group3.besocialos.model.Post;
import elec5619.group3.besocialos.model.User;
import junit.framework.TestCase;
import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.junit.*;

import java.sql.Connection;
import java.sql.Statement;
import java.util.List;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.junit.Before;
import org.junit.Test;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { HibernateConfig.class, WebMVCConfig.class })
@WebAppConfiguration
public class UserServiceTest {

    public UserServiceTest(){
        Config.getConfig().setTest();
    }

    @Autowired
    private UserService userService;

    private User user;
    @Before
    @Transactional
    public void setUp() throws Exception {
        user = new User();
        user.setName("Alice");
        user.setEmail("alice@example.com");
//        userService.save(user);
    }

    @Test
    @Transactional
    public void save() {
        user.setGoogleId("usydmpe@gmail.com");
        userService.save(user);
        assertTrue(userService.list().contains(user));
    }

    @Test
    @Transactional
    public void saveIfNotExist() {
        userService.saveIfNotExist(user);
        assertTrue(userService.list().contains(user));
    }

    @Test
    @Transactional
    public void getUserByGoogleId() {
        user.setGoogleId("usydmpe@gmail.com");
        userService.save(user);
        assertEquals(user, userService.getUserByGoogleId("usydmpe@gmail.com"));
    }
}
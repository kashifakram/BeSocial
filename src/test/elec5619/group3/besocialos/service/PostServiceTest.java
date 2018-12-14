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
public class PostServiceTest {

    public PostServiceTest(){
        Config.getConfig().setTest();
    }
    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    private Post post;
    private User user;
    @Before
    public void setUp() throws Exception {
        user = new User();
        user.setName("Alice");
        user.setEmail("alice@example.com");
        user.setGoogleId("usydmep@gmail.com");
        userService.save(user);

        post = new Post();
        post.setId(123456L);
        post.setUser(user);
        post.setText("Hello World");
    }

    @Test
    @Transactional
    public void testEmptyPostList() {
        assertTrue(postService.list().isEmpty());
    }


    @Test
    @Transactional
    public void testSaveAndList() {
        postService.save(post, "usydmep@gmail.com");
        assertTrue(postService.list().contains(post));
    }
}
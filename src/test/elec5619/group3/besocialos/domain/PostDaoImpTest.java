package elec5619.group3.besocialos.domain;

import elec5619.group3.besocialos.config.Config;
import elec5619.group3.besocialos.config.HibernateConfig;
import elec5619.group3.besocialos.config.WebMVCConfig;
import elec5619.group3.besocialos.model.Post;
import elec5619.group3.besocialos.model.User;
import elec5619.group3.besocialos.domain.PostDao;
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
public class PostDaoImpTest extends TestCase {
    public PostDaoImpTest(){
        Config.getConfig().setTest();
    }

    @Autowired
    private PostDao postDao;

    @Autowired
    private UserDao userDao;

    private Post post;
    private User user;

    @Before
    public void setup() {
        user = new User();
        user.setName("Alice");
        user.setEmail("alice@example.com");
        userDao.save(user);

        post = new Post();
        post.setId(123456L);
        post.setUser(user);
        post.setText("Hello World");
    }

    @Test
    @Transactional
    public void testEmptyPostList() {
        assertTrue(postDao.list().isEmpty());
    }

    @Test
    @Transactional
    public void testSaveAndList() {
        postDao.save(post);
        assertTrue(postDao.list().contains(post));
    }

//    @Transactional
//    void saveNewPost(){
//
//    }
}
//public class PostDaoImpTest {
//
//    private Post post;
//    private PostDaoImp postdao;
//    @Before
//    public void setUp() throws Exception {
//        postdao = new PostDaoImp();
//        post = new Post();
//        post.setId(123456L);
//        post.setUser(new User());
//        post.setText("Hello World");
//
//        org.apache.tomcat.dbcp.dbcp2.BasicDataSource dataSource = new BasicDataSource();
//        dataSource.setDriverClassName("org.h2.Driver");
//        dataSource.setUrl("jdbc:h2:mem:testdb;MODE=MYSQL;DB_CLOSE_DELAY=-1");
//        dataSource.setUsername("root");
//        dataSource.setPassword("besocialosroot");
//
//        Connection conn = dataSource.getConnection();
//        Statement st = conn.createStatement();
//
//        st.execute("runscript from CREATE TABLE `post` (\n" +
//                "  `id` bigint(20) NOT NULL AUTO_INCREMENT,\n" +
//                "  `text` longtext NOT NULL,\n" +
//                "  `user_id` bigint(20) DEFAULT NULL,\n" +
//                "  PRIMARY KEY (`id`),\n" +
//                "  KEY `FK72mt33dhhs48hf9gcqrq4fxte` (`user_id`),\n" +
//                "  CONSTRAINT `FK72mt33dhhs48hf9gcqrq4fxte` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)\n" +
//                ") ENGINE=InnoDB DEFAULT CHARSET=latin1\n");
//
//        st.close();
//        conn.close();
//    }
//
//
//    @Test
//    public void testListAndSave() {
//        assertTrue(postdao.list().isEmpty());
//        postdao.save(post);
//        assertTrue(postdao.list().contains(post));
//
//    }
//}
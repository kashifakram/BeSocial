package elec5619.group3.besocialos.model;

import javafx.geometry.Pos;
import elec5619.group3.besocialos.model.Post;
import elec5619.group3.besocialos.model.User;
import junit.framework.TestCase;
import org.junit.Test;

import static org.junit.Assert.*;

public class PostTest extends TestCase {

    private Post post;
    private User user;
    @Test
    public void setUp(){
        post = new Post();
    }

    @Test
    public void testIDSetAndGet(){
        Long testId = 12345678L;
        assertNull(post.getId());
        post.setId(testId);
        assertEquals(testId, post.getId());
    }

    @Test
    public void setUser(){
        user = new User();
        user.setId(123456L);
        user.setName("Ning");
        user.setEmail("nzha@uni.sydney.edu.au");
    }

    @Test
    public void testUserSetAndGet() {
        user = new User();
        setUser();
        User testUser = user;
        assertNull(post.getUser());
        post.setUser(user);
        assertEquals(testUser, post.getUser());

    }

    @Test
    public void testTextSetandGet() {
        String testText = "Helloworld";
        assertNull(post.getText());
        post.setText(testText);
        assertEquals(testText, post.getText());
    }
}
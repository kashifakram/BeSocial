package elec5619.group3.besocialos.service;

import elec5619.group3.besocialos.domain.PostDao;
import elec5619.group3.besocialos.model.Post;
import elec5619.group3.besocialos.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PostService {

    @Autowired
    private PostDao postDao;

    @Autowired
    private UserService userService;

    @Transactional
    public void save(Post post, String googleId) {
        User user = userService.getUserByGoogleId(googleId);
        if(user != null){
            post.setUser(user);
            postDao.save(post);
        }
    }

    @Transactional(readOnly = true)
    public List<Post> list() {
        return postDao.list();
    }
}
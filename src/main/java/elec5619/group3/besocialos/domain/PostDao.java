package elec5619.group3.besocialos.domain;

import elec5619.group3.besocialos.model.Post;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.TypedQuery;
import java.util.List;

@Repository
public class PostDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void save(Post post) {
        sessionFactory.getCurrentSession().save(post);
    }

    public List<Post> list() {
        @SuppressWarnings("unchecked")
        TypedQuery<Post> query = sessionFactory.getCurrentSession().createQuery("from Post");
        return query.getResultList();
    }
}
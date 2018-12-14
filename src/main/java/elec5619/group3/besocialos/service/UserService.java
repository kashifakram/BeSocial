package elec5619.group3.besocialos.service;

import elec5619.group3.besocialos.domain.UserDao;
import elec5619.group3.besocialos.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    @Transactional
    public void save(User user) {
        userDao.save(user);
    }

    @Transactional
    public void update(User user) {
        userDao.update(user);
    }

    @Transactional
    public void saveIfNotExist(User user) {
        if(getUserByGoogleId(user.getGoogleId()) == null){
            save(user);
        }
    }

    @Transactional(readOnly = true)
    public List<User> list() {
        return userDao.list();
    }

    @Transactional(readOnly = true)
    public User getUserByGoogleId(String googleId) {
        for(User u : list()){
            if(u.getGoogleId().equals(googleId)){
                return u;
            }
        }
        return null;
    }
    @Transactional(readOnly = true)
    public User getUserByGoogleToken(String googleToken) {
        System.out.println("Looking for user with google token: " + googleToken);
        for(User u : list()){
            String token = u.getGoogleToken();
            if(token != null){
                System.out.println("Checking user with google token: " + u.getGoogleToken());
            }
            if(token != null && token.equals(googleToken)){
                return u;
            }
        }
        return null;
    }

    @Transactional
    public void addTwitter(String id, String token, String secret, String googleToken) {
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            u.setTwitterId(id);
            u.setTwitterToken(token);
            u.setTwitterSecret(secret);
            update(u);
        }
    }

    @Transactional
    public void removeTwitter(String googleToken) {
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            u.setTwitterId(null);
            u.setTwitterToken(null);
            u.setTwitterSecret(null);
            update(u);
        }
    }

    @Transactional
    public void addLinkedIn(String id, String token, String googleToken) {
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            u.setLinkedInId(id);
            u.setLinkedInToken(token);
            update(u);
        }
    }

    @Transactional
    public void removeLinkedIn(String googleToken) {
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            u.setLinkedInId(null);
            u.setLinkedInToken(null);
            update(u);
        }
    }


    @Transactional(readOnly = true)
    public String getUserTwitterToken(String googleToken){
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            return u.getTwitterToken();
        }
        return null;
    }

    @Transactional(readOnly = true)
    public String getUserTwitterSecret(String googleToken){
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            return u.getTwitterSecret();
        }
        return null;
    }

    @Transactional(readOnly = true)
    public String getUserLinkedInToken(String googleToken){
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            return u.getLinkedInToken();
        }
        return null;
    }


    @Transactional(readOnly = true)
    public List<String> getSocialFlags(String googleToken){
        User u = getUserByGoogleToken(googleToken);
        if(u != null){
            List<String> flags = new ArrayList<>();
            if(u.getTwitterId() != null){
                flags.add("twitter");
            }
            if(u.getLinkedInId() != null){
                flags.add("linkedIn");
            }
            return flags;
        }
        return null;
    }
}

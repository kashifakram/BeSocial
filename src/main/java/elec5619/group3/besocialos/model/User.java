package elec5619.group3.besocialos.model;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    @Size(max = 20, min = 3, message = "{user.name.invalid}")
    @NotEmpty(message="Please Enter your name")
    private String name;

    @Column(name = "email", unique = true)
    @Email(message = "{user.email.invalid}")
    @NotEmpty(message="Please Enter your email")
    private String email;

    @Column(name = "googleId", unique = true)
    private String googleId;

    @Column(name = "googleToken")
    private String googleToken;

    @Column(name = "twitterId", unique = true)
    private String twitterId;

    @Column(name = "twitterToken")
    private String twitterToken;

    @Column(name = "twitterSecret")
    private String twitterSecret;

    @Column(name = "linkedInId", unique = true)
    private String linkedInId;

    @Column(name = "linkedInToken")
    private String linkedInToken;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGoogleId() {
        return googleId;
    }

    public void setGoogleId(String googleId){
        this.googleId = googleId;
    }

    public String getGoogleToken() {
        return googleToken;
    }

    public void setGoogleToken(String googleToken) {
        this.googleToken = googleToken;
    }

    public String getTwitterId() {
        return twitterId;
    }

    public void setTwitterId(String twitterId) {
        this.twitterId = twitterId;
    }

    public String getTwitterToken() {
        return twitterToken;
    }

    public void setTwitterToken(String twitterToken) {
        this.twitterToken = twitterToken;
    }

    public String getTwitterSecret() {
        return twitterSecret;
    }

    public void setTwitterSecret(String twitterSecret) {
        this.twitterSecret = twitterSecret;
    }

    public String getLinkedInId() {
        return linkedInId;
    }

    public void setLinkedInId(String linkedInId) {
        this.linkedInId = linkedInId;
    }

    public String getLinkedInToken() {
        return linkedInToken;
    }

    public void setLinkedInToken(String linkedInToken) {
        this.linkedInToken = linkedInToken;
    }
}
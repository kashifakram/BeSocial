<%--
  Created by IntelliJ IDEA.
  User: kakra
  Date: 28/10/2018
  Time: 3:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<!--<script src="assets/js/tw.js"></script>-->

<script src="https://www.gstatic.com/firebasejs/5.5.6/firebase.js"></script>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
    // Initialize Firebase
    var config = {
        apiKey: "AIzaSyBPN5V_xxW01y1BKtEbBcSgVoMCg1MSsuI",
        authDomain: "twitter-55161.firebaseapp.com",
        databaseURL: "https://twitter-55161.firebaseio.com",
        projectId: "twitter-55161",
        storageBucket: "twitter-55161.appspot.com",
        messagingSenderId: "767995000297"
    };
    firebase.initializeApp(config);



    let provider = new firebase.auth.FacebookAuthProvider();
    provider.addScope('email');

    let fb_result;
    let access_Token;
    let fb_user_posts;
    let user_id;
    let user_photo_url;
    function fbSignIn(){
        firebase.auth().signInWithPopup(provider).then(function(result) {
            // This gives you a Facebook Access Token. You can use it to access the Facebook API.
            access_Token = result.credential.accessToken;
            // The signed-in user info.
            fb_result = result;
            user_photo_url = fb_result.user.photoURL;
            let tokens = user_photo_url.split("/");
            user_id = tokens[3];
            console.log(user_id);
            console.log(fb_result.user);
            console.log("Acccess Token of FB " + access_Token);
            // ...
        }).catch(function(error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // The email of the user's account used.
            var email = error.email;
            // The firebase.auth.AuthCredential type that was used.
            var credential = error.credential;
            // ...
        });

    }

    function requestFBPosts() {
        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if(this.status === 200 && this.readyState === 4){
                fb_user_posts = this.response;
                alert("User POSTS " + fb_user_posts);
                document.getElementById("load_tweets").innerText = fb_user_posts;
            }
        };

        xhttp.open("GET", 'https://graph.facebook.com/' + user_id + '/feed?access_token=' + access_Token);
        xhttp.send();
    }


    function signOutFB() {
        firebase.auth().signOut().then(function() {
            alert('You are signed out successfully...');
        }).catch(function(error) {
            alert('Error in signing you out...');
            // An error happened.
        });

    }

</script>

<body>

<button onclick="fbSignIn()">FB Sign In</button>
<button onclick="requestFBPosts()">Load Posts</button>
<button onclick="signOutFB()">Sign Out of FB</button>


<br />

<div id="tw_timeline">
    <a id="load_tweets" class="twitter-timeline">Tweets by @iamkashifakram</a>
</div>

<!--<script>-->
<!--let tw_token = '1052101380771536896-xgpJkVhlTP3JgQgEJbr7byGuskIU1H';-->
<!--let tw_login_url = 'https://api.twitter.com/oauth/'+tw_token;-->
<!--let xhttp = new XMLHttpRequest();-->
<!--xhttp.onreadystatechange = function () {-->
<!--if(xhttp.readyState === 4 && xhttp.status === 200){-->
<!--alert('twitter access token success');-->
<!--}-->
<!--};-->

<!--xhttp.open("POST", tw_login_url);-->
<!--xhttp.send();-->

<!--</script>-->

<script>



</script>

</body>
</html>

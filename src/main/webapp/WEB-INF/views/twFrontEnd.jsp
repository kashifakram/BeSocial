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

    let provider = new firebase.auth.TwitterAuthProvider();
    let tw_result;
    function twitterSignIn(){
        firebase.auth().signInWithPopup(provider).then(function(result){
            // let token = result.credential.accessTokenl;
            // let secret = result.credential.sec
            tw_result = result;
            console.log("user details are following " + tw_result.user);
            document.getElementById("load_tweets").setAttribute("href", "https://twitter.com/" + tw_result.user.screenName);
        }).catch(function (error) {
            let errCode = error.code;
            let errorMessage = error.message;
            let email = error.email;
            let credential = error.credential;
        })

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

<button onclick="twitterSignIn()">Twitter Sign In</button>
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
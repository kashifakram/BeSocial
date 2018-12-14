<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
    <meta charset="UTF-8">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <title>Spring5 MVC Hibernate Demo</title>
    <style type="text/css">
        .error {
            color: red;
        }
        table {
            width: 50%;
            border-collapse: collapse;
            border-spacing: 0px;
        }
        table td {
            border: 1px solid #565454;
            padding: 20px;
        }
    </style>
</head>
<body>
<h1>Input Form</h1>
<form:form action="addUser" method="post" modelAttribute="user">
    <table>
        <tr>
            <td>Name</td>
            <td>
                <form:input path="name" /> <br />
                <form:errors path="name" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td>Email</td>
            <td>
                <form:input path="email" /> <br />
                <form:errors path="email" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td colspan="2"><button type="submit">Submit</button></td>
        </tr>
        <tr>
            <td colspan="2"><div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div></td>
        </tr>
        <tr>
            <td colspan="2">
                <%--<a href="#" onclick='toLogin()'><img src="Connect_logo_5.png"></a>--%>
                <div id="fb-root"
                     style="
                    background: #4267b2;
                    border-radius: 5px;
                    color: white;
                    height: 40px;
                    text-align: center;
                    width: 250px;">
                    Login with facebook
                    <div
                            class="fb-login-button"
                            data-max-rows="1"
                            data-size="middle"
                            data-button-type="continue_with"
                            data-use-continue-as="false"
                            data-show-faces="false"
                            data-auto-logout-link="false"
                            onclick="checkLoginState();"
                    ></div>
                </div>
            </td>
        </tr>
    </table>
</form:form>



<h2>Users List</h2>
<table>
    <tr>
        <td><strong>Name</strong></td>
        <td><strong>Email</strong></td>
    </tr>
    <c:forEach items="${users}" var="user">
        <tr>
            <td>${user.name}</td>
            <td>${user.email}</td>
        </tr>
    </c:forEach>
</table>


<script>
    function onSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // ?????????????
        console.log('Full Name: ' + profile.getName());
        console.log('Given Name: ' + profile.getGivenName());
        console.log('Family Name: ' + profile.getFamilyName());
        console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());

        // ????id_token????
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
    };


    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            // Logged into your app and Facebook.
            testAPI();
        } else {
            // The person is not logged into your app or we are unable to tell.
            document.getElementById('status').innerHTML = 'Please log ' +
                'into this app.';
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }

    window.fbAsyncInit = function() {
        FB.init({
            appId      : '{your-app-id}',
            cookie     : true,  // enable cookies to allow the server to access
                                // the session
            xfbml      : true,  // parse social plugins on this page
            version    : 'v3.1' // use graph api version 3.1
        });

        // Now that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus().  This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide.  They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        //    your app or not.
        //
        // These three cases are handled in the callback function.

        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });

    };

    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = 'https://connect.facebook.net/en_US/sdk.js';
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML =
                'Thanks for logging in, ' + response.name + '!';
        });
    }

    // function toLogin()
    // {
    //     //????????????????????????
    //     //???????QQ??????????????????????????????
    //     var A=window.open("oauth/index.php","TencentLogin",
    //         "width=450,height=320,menubar=0,scrollbars=1,
    //     resizable=1,status=1,titlebar=0,toolbar=0,location=1");
    // }
</script>
<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
</fb:login-button>
<div id="fb-login-button"></div>
<div class="fb-login-button" data-max-rows="1" data-size="large" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"></div>
</body>
</html>
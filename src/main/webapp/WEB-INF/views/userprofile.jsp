<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id"
          content="488598562191-7a4alsqvmi81bhpk5pu752e73k02fg7r.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <style>

        /* Resetting all elements margins, paddings etc */

        * {
            box-sizing: border-box;
        }

        html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {

            margin: 0;
            padding: 0;
            border: 0;
            vertical-align: baseline;
        }

        article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section {
            display: block;
        }

        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, serif;
        }

        /* Style tab links */
        .tablinks {
            display: none;
            background-color: #555;
            color: white;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            font-size: 1.5em;
            width: 100%;
        }

        .tablinks:hover {
            background-color: #777;
        }


        /* Create two unequal columns that floats next to each other */
        .column {
            float: left;

        }

        /* Clear floats after the columns */
        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        body {
            background-color: #9b4f90;
            line-height: 1;
            -webkit-text-size-adjust: none;
        }

        .leftMenu {
            background-color: #555555;
            position: fixed;
            margin-left: 0;
            left: 0;
            height: 100%;
            width: 15%;
            overflow: hidden;
        }

        .mainDiv {
            position: relative;
            padding: 0.2%;
            width: 85%;
            height: 100%;
            float: right;
        }

        .topWrapper {
            position: relative;
            width: 100%;
            height: 100%;
        }

        .leftMenu .nava {
            display: block;
            text-align: center;
            padding: 16px;
            transition: all 0.3s ease;
            color: white;
            font-size: 48px;
        }

        .leftMenu .navspan {
            font-size: 12px;
            color: #FFFFFF;
        }

        .leftMenu a:hover {
            background-color: #bbbbbb;
        }

        .active {
            background-color: #4CAF50;
        }

        .last {
            position: absolute;
            bottom: 3%;
            left: 40%;
        }

        .contents {
            position: absolute;
            overflow: hidden;
            border: 2px solid #ccc;
            background-color: #f1f1f1;
            width: 100%;
            padding: 0.5%;
            margin-top: 8%;
            margin-left: 0.5%;
        }

        /* Style the tab content (and add height:100% for full page content) */
        .tabcontent {
            color: black;
            display: none;
            padding: 1% 1%;
            /*height: 100%;*/
            width: 100%;
            height: 100%;
            border: 2px solid black;
            border-top: none;
        }


        .tab {
            position: absolute;
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            width: 100%;
            padding: 0.7%;
            margin: 0.5%;
            /*left: 5%;*/
        }

        /* Style the buttons inside the tab */
        .tab button {
            background-color: #9b4f90;
            /*float: left;*/
            border: none;
            outline: none;
            cursor: pointer;
            padding: 1% 1%;
            transition: 0.3s;
            font-size: 1.2em;
            font-weight: bolder;
            color: white;
            width: 15%;
            margin: 0.5%;
        }

        /* Change background color of buttons on hover */
        .tab button:hover {
            background-color: #ddd;
        }

        /* Create an active/current tablink class */
        .tab button.active {
            background-color: #ccc;
        }

        /* Style the close button */
        .topright {
            float: right;
            cursor: pointer;
            font-size: 28px;
        }

        .toprightbtn {
            position: absolute;
            top: 5px;
            right: 5px;
            float: right;
            cursor: pointer;
            font-size: 2.5em;
        }

        .toprightbtn:hover {
            color: red;
        }

        html, body {
            height: 100%;
            width: 100%;
        }

        img {
            height: 150px;
            width: 225px;
        }

        canvas {
            border: 1px solid black;
        }

        .trans {
            transform: scale(1);
        }
    </style>

    <title>User Profile</title>

</head>
<body>
<script>
    window.fbAsyncInit = function() {
        FB.init({
            appId            : '264033027592250',
            autoLogAppEvents : true,
            xfbml            : true,
            version          : 'v3.1'
        });
    };

    function fbLogin() {
        FB.login(function(response) {
            if (response.authResponse) {
                console.log('Welcome!  Fetching your information.... ');
                FB.api('/me', function(response) {
                    console.log('Good to see you, ' + response.name + '.');
                });
            } else {
                console.log('User cancelled login or did not fully authorize.');
            }
        });
    }

    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>

<div class="row">
    <div id="leftMenu" class="leftMenu" style="height: 100%">
        <a href="#" title="Profile" class="nava"><i class="fa fa-user"></i></a>
        <a href="#" title="Open Facebook" class="nava" onclick="displayTabButton('fbOpen')"><i
                class="fa fa-facebook-square"></i></a>
        <a href="#" title="Open Twitter" class="nava" onclick="displayTabButton('twOpen')"><i
                class="fa fa-twitter-square"></i></a>
        <a href="#" title="Open Google Plus" class="nava" onclick="displayTabButton('gpOpen')"><i
                class="fa fa-google-plus-square"></i></a>
        <a href="#" title="Open Linked In" class="nava" onclick="displayTabButton('liOpen')"><i
                class="fa fa-linkedin-square"></i></a>
        <a href="#" title="Open Youtube" class="nava" onclick="displayTabButton('ytOpen')"><i
                class="fa fa-youtube-square"></i></a>
        <a href="#" title="post" class="nava"><i class="fa fa-globe"></i></a>
        <br>
        <a title="logout" id="logout" class="nava"><i class="fa fa-sign-out"></i></a>
        <a href="#" title="Profile" class="nava"><i class="fa fa-windows"></i></a>

    </div>

    <div id="main" class="mainDiv">

        <div style="padding: 0.5%; color: white; margin: 0.5%; width: 100%; background: #3388aa;">
            <h2>WelCome:  <span id="uname"></span> </h2>
            <h3><span id="email"></span> </h3>
            <p style="font-size: 1.1em; margin-top: 1%;" class="toprightbtn">Logout</p>
        </div>

        <div class="tab">
            <button class="tablinks" onclick="openPlatform(event, 'fbOpenContent')" id="fbOpen">
                Facebook
            </button>
            <button class="tablinks" onclick="openPlatform(event, 'twOpenContent')" id="twOpen">
                Twitter
            </button>
            <button class="tablinks" onclick="openPlatform(event, 'liOpenContent')" id="liOpen">
                LinkedIn
            </button>
            <button class="tablinks" onclick="openPlatform(event, 'ytOpenContent')" id="ytOpen">
                YouTube
            </button>
            <button class="tablinks" onclick="openPlatform(event, 'gpOpenContent')" id="gpOpen">
                Google Plus
            </button>
        </div>

        <div class="contents">
            <div id="twOpenContent" class="tabcontent">
                <span onclick="this.parentElement.style.display='none'" class="toprightbtn">&times</span>
                <h3 id="twStatus" class="headingConnectionStatus">Sorry you are not connected to twitter!</h3>
                <button id="twConnectButton" class="btnConnection">Connect Now</button>
            </div>

            <div id="liOpenContent" class="tabcontent">
                <span onclick="this.parentElement.style.display='none'" class="toprightbtn">&times</span>
                <h3 id="liStatus" class="headingConnectionStatus">Sorry you are not connected to linked in!</h3>
                <button id="liConnectButton" class="btnConnection">Connect Now</button>
            </div>

            <div id="gpOpenContent" class="tabcontent">
                <span onclick="this.parentElement.style.display='none'" class="toprightbtn">&times</span>
                <h3 id="gpStatus" class="headingConnectionStatus">Sorry you are not connected to google plus!</h3>
                <button id="gpConnectButton" class="btnConnection">Connect Now</button>
            </div>

            <div id="fbOpenContent" class="tabcontent">
                <span onclick="this.parentElement.style.display='none'" class="toprightbtn">&times</span>
                <h3 id="fbStatus" class="headingConnectionStatus">Sorry you are not connected to facebook!</h3>
                <button id="fbConnectButton" class="btnConnection">Connect Now</button>
            </div>

            <div id="ytOpenContent" class="tabcontent">
                <span onclick="this.parentElement.style.display='none'" class="toprightbtn">&times</span>
                <h3 id="ytStatus" class="headingConnectionStatus">Sorry you are not connected to facebook!</h3>
                <button id="ytConnectButton" class="btnConnection">Connect Now</button>
            </div>

        </div>

    </div>
</div>

<script>

    let logout = document.getElementById("logout");
    logout.addEventListener("click", function (e) {
        e.preventDefault();
        signOut();
    });

    function signOut() {
        window.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://besocialos-env.nacx3rnutf.ap-southeast-2.elasticbeanstalk.com";
    }

    let uname = document.getElementById("uname");
    let email = document.getElementById("email");
    let query_strings = new URLSearchParams(window.location.search);
    uname.innerHTML = query_strings.get('name');
    email.innerHTML = query_strings.get('email');

    var btns = document.getElementsByClassName("tablinks");
    for (var i = 0; i < btns.length; i++)
        btns[i].style.display = 'none';

    function openPlatform(evt, platformName) {
        let i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(platformName).style.display = "block";
        evt.currentTarget.className += " active";
    }

    function displayTabButton(tabName) {
        let n = document.getElementById(tabName);
        let tabContentName = tabName + 'Content';

        let tabContent = document.getElementById(tabContentName);

        let allContents = document.getElementsByClassName("tabcontent");
        for (i = 0; i < allContents.length; i++) {
            allContents[i].style.display = "none";
        }

        console.log(tabContent);
        if (n.style.display !== 'none') {
            n.style.display = "none";
            if(tabContent.style.display !== 'none'){
                tabContent.style.display = 'none';
            }
        }
        else {
            n.style.display = "inline";
            if(tabContent.style.display === 'none'){
                tabContent.style.display = 'block';
                // tabContent.className += " active";

            }
        }
    }

    let fbConnected = false;
    let ytConnected = false;
    let liConnected = false;
    let gpConnected = false;
    let twConnected = false;

    let conStatuses = document.getElementsByClassName("headingConnectionStatus");
    for(let i = 0; i < conStatuses.length; i++)
        conStatuses[i].style.display = 'none';

    let conBtns = document.getElementsByClassName("btnConnection");
    for(let i = 0; i < conBtns.length; i++)
        conBtns[i].style.display = 'none';

    if(!fbConnected){
       document.getElementById("fbStatus").style.display = 'block';
       let btn = document.getElementById("fbConnectButton");
       btn.style.display = 'block';
       btn.addEventListener('click', connectFB);
    }

    if(!ytConnected){
        document.getElementById("ytStatus").style.display = 'block';
        let btn = document.getElementById("ytConnectButton");
        btn.style.display = 'block';
        btn.addEventListener('click', connectYT);
    }

    if(!liConnected){
        document.getElementById("liStatus").style.display = 'block';
        let btn = document.getElementById("liConnectButton");
        btn.style.display = 'block';
        btn.addEventListener('click', connectLI);
    }

    if(!gpConnected){
        document.getElementById("gpStatus").style.display = 'block';
        let btn = document.getElementById("gpConnectButton");
        btn.style.display = 'block';
        btn.addEventListener('click', connectGP);
    }

    if(!twConnected){
        document.getElementById("twStatus").style.display = 'block';
        let btn = document.getElementById("twConnectButton");
        btn.style.display = 'block';
        btn.addEventListener('click', connectTW);
    }

    function connectFB() {
        alert('Connection FB');
    }

    function connectYT() {
        alert('Connection YT');
    }

    function connectLI() {
        alert('Connection LI');
    }

    function connectTW() {
        alert('Connection TW');
    }

    function connectGP() {
        alert('Connection GP');
    }

    function addFBPost() {
        let mainDiv = document.createElement("div");

    }

</script>

</body>
</html>
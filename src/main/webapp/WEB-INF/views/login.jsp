<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>BE Social Login</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">

    <style>
        .bg-purple {
            background-color: #9b4f90;
        }

        .full-page {
            margin: 0;
            padding: 0;
            height: 100vh;
            min-height: 100vh;
            max-height: 100vh;
            width: 100vw;
            min-width: 100vw;
            max-width: 100vw;
        }

        .timeText{
            font-size: 6em;
            font-weight: bolder;
            color: white;
            text-align: center;
            line-height: 1;
        }

        .dateText{
            font-size: 2em;
            font-weight: bold;
            color: white;
            text-align: center;
        }
    </style>


</head>

<body onload="startTime()">

<div class="d-flex align-items-center flex-column justify-content-center full-page bg-purple">
    <div>
        <p id="currentTime" class="timeText"></p>
        <p id="currentDate" class="dateText"></p>
        <div align="center">
            <a href="${pageContext.request.contextPath}/google/login"><img id="loginButton" src="imgs/google-sign-in.png"></a>
        </div>
    </div>
</div>


<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

<script>

    Date.prototype.today = function () {
        return ((this.getDate() < 10)?"0":"") + this.getDate() +"-"+(((this.getMonth()+1) < 10)?"0":"") + (this.getMonth()+1) +"-"+ this.getFullYear();
    };

    // For the time now
    Date.prototype.timeNow = function () {
        return ((this.getHours() < 10)?"0":"") + this.getHours() +":"+ ((this.getMinutes() < 10)?"0":"") + this.getMinutes() +":"+ ((this.getSeconds() < 10)?"0":"") + this.getSeconds();
    };

    var date = new Date();
    document.getElementById("currentDate").innerHTML = date.today();


    function startTime() {
        var dt = new Date();
        document.getElementById("currentTime").innerHTML = dt.timeNow();
        var t = setTimeout(startTime, 1000);
    }
</script>

</body>
</html>
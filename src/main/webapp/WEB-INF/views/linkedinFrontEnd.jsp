<%--
  Created by IntelliJ IDEA.
  User: kakra
  Date: 28/10/2018
  Time: 3:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script type="text/javascript" src="//platform.linkedin.com/in.js">
        api_key: 86nvxlniw8o5l3
        authorize: true
        onLoad: OnLinkedInAuth
        }

    </script>


    <script type="text/javascript">

        let li_member, li_id;

        function OnLinkedInAuth() {
            IN.API.Profile("me").result(ShowProfileData);
        }

        function ShowProfileData(profiles) {
            li_member = profiles.values[0];
            li_id = li_member.id;
            let firstName = li_member.firstName;
            let lastName = li_member.lastName;
            let photo = li_member.pictureUrl;
            let headline = li_member.headline;

            console.log(li_member);

            //use information captured above
        }


        function getLinkedInFeeds() {
            let feeds_owner_urn = 'urn:li:person:'+li_id;
            let feeds_url = 'https://api.linkedin.com/v2/shares?q=owners&owners=' + feeds_owner_urn + '&sharesPerOwner=100';
            let xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if(this.readyState === 4 && this.status === 2000){
                    alert("Received Response from Linked In");
                }

            };
            xhttp.open("GET", feeds_url);
            xhttp.send();

        }

        function getLinkedInFeedsURL() {
            let feeds_owner_urn = 'urn:li:person:'+li_id;
            let feeds_url = 'https://api.linkedin.com/v2/shares?q=owners&owners=' + feeds_owner_urn + '&sharesPerOwner=100';
            // window.location.href = feeds_url;
            $.getJSON(feeds_url, function(data) {
                console.log(data);
            });
            // console.log(res);
        }



    </script>


    <style>
        .box{
            background-color: #4CAF50;
            color: #FFFFFF;
            width: 50%;
            height: 100%;
            border: 2px solid #8a4680;
            padding: 5px;
            margin: auto;
        }
    </style>
</head>
<body>

<div class="box">
    <button onclick="getLinkedInFeedsURL()">Retrieve Posts</button>
    <br><br>
    <span class="admin-text-title">Post Text</span>
    <br />
    <textarea id="fwc1" rows="10" cols="24" required maxlength="240" style="resize: none"
              onkeyup="v_show_length(240, 'fwc1', 'fwc_counter');v_keyup_length_max(240, 'fwc1');"></textarea>
    <br />
    <span id="fwc_counter">0</span>/240&nbsp;Characters
    <br /><br />
    Linkedin: <input type="checkbox" id="li" class="shareCheck">
    <br />
    Twitter: <input type="checkbox" id="tw">
    <button onclick="shareContent()">Post</button>

</div>


<script>

    function v_keyup_length_max(max, elementid) {
        var this_v = document.getElementById(elementid).value;
        if(this_v.length > max) {
            document.getElementById(elementid).value = this_v.substr(0, max)
        }
    }

    function v_show_length(max, elementid, counterid) {
        var thisvalue = document.getElementById(elementid).value
        if(max > 0) {
            if(thisvalue.length > max) {
                document.getElementById(elementid).innerHTML = thisvalue.substr(0, max)
            }
        }
        document.getElementById(counterid).innerHTML = thisvalue.length
        return true;
    }

    // Setup an event listener to make an API call once auth is complete
    function onLinkedInLoad() {
        IN.Event.on(IN, "auth", shareContent);
    }

    // Handle the successful return from the API call
    function onSuccess(data) {
        console.log(data);
        alert('Post has been successfuly shared on your linked in account!');
    }

    // Handle an error response from the API call
    function onError(error) {
        console.log(error);
    }

    // Use the API call wrapper to share content on LinkedIn
    function shareContent() {
        let liChecked = document.getElementById("li").checked;

        if(liChecked){
            // Build the JSON payload containing the content to be shared
            let post_data = document.getElementById("fwc1").value;
            let payload = {
                "comment": post_data,
                "visibility": {
                    "code": "anyone"
                }
            };

            IN.API.Raw("/people/~/shares?format=json")
                .method("POST")
                .body(JSON.stringify(payload))
                .result(onSuccess)
                .error(onError);
        } else {
            alert('Please click linked share check box to share...');
        }

    }

</script>
</body>
</html>
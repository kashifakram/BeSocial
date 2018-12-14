<%--
  Created by IntelliJ IDEA.
  User: kakra
  Date: 1/11/2018
  Time: 6:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Build Your Social Page</title>

    <!--<link rel="stylesheet" href="style.css">-->

    <script src="https://www.gstatic.com/firebasejs/5.5.6/firebase.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>

        let tw_result;
        let tw_uname;
        let tw_sname;

        let config = {
            apiKey: "AIzaSyBPN5V_xxW01y1BKtEbBcSgVoMCg1MSsuI",
            authDomain: "twitter-55161.firebaseapp.com",
            databaseURL: "https://twitter-55161.firebaseio.com",
            projectId: "twitter-55161",
            storageBucket: "twitter-55161.appspot.com",
            messagingSenderId: "767995000297"
        };
        firebase.initializeApp(config);

        let provider = new firebase.auth.TwitterAuthProvider();

        firebase.auth().signInWithPopup(provider).then(function(result){
            tw_result = result;
            console.log("user details are following " + tw_result.user);
            tw_uname = tw_result.additionalUserInfo.username;
            tw_sname = tw_result.additionalUserInfo.profile.screen_name;
        }).catch(function (error) {
            let errCode = error.code;
            let errorMessage = error.message;
            let email = error.email;
            let credential = error.credential;
        });





        (function(root, factory) {
            if (typeof define === 'function' && define.amd) {
                define([], factory);
            } else if (typeof exports === 'object') {
                module.exports = factory();
            } else {
                factory();
            }
        }(this, function() {

            var domNode = '';
            var maxTweets = 20;
            var parseLinks = true;
            var queue = [];
            var inProgress = false;
            var printTime = true;
            var printUser = true;
            var formatterFunction = null;
            var supportsClassName = true;
            var showRts = true;
            var customCallbackFunction = null;
            var showInteractionLinks = true;
            var showImages = false;
            var useEmoji = false;
            var targetBlank = true;
            var lang = 'en';
            var permalinks = true;
            var dataOnly = false;
            var script = null;
            var scriptAdded = false;

            function handleTweets(tweets) {
                if (customCallbackFunction === null) {
                    var x = tweets.length;
                    var n = 0;
                    var element = document.getElementById(domNode);
                    var html = '<ul>';
                    while (n < x) {
                        html += '<li>' + tweets[n] + '</li>';
                        n++;
                    }
                    html += '</ul>';
                    element.innerHTML = html;
                } else {
                    customCallbackFunction(tweets);
                }
            }

            function strip(data) {
                return data.replace(/<b[^>]*>(.*?)<\/b>/gi, function(a, s) {
                    return s;
                }).replace(/class="(?!(tco-hidden|tco-display|tco-ellipsis))+.*?"|data-query-source=".*?"|dir=".*?"|rel=".*?"/gi, '');
            }

            function targetLinksToNewWindow(el) {
                var links = el.getElementsByTagName('a');
                for (var i = links.length - 1; i >= 0; i--) {
                    links[i].setAttribute('target', '_blank');
                    links[i].setAttribute('rel', 'noopener');
                }
            }

            function getElementsByClassName(node, classname) {
                var a = [];
                var regex = new RegExp('(^| )' + classname + '( |$)');
                var elems = node.getElementsByTagName('*');
                for (var i = 0, j = elems.length; i < j; i++) {
                    if (regex.test(elems[i].className)) {
                        a.push(elems[i]);
                    }
                }
                return a;
            }

            function extractImagesUrl(image_data) {
                if (image_data !== undefined && image_data.innerHTML.indexOf('data-image') >= 0) {
                    var data_src = image_data.innerHTML.match(/data-image=\"([A-z0-9]+:\/\/[A-z0-9]+\.[A-z0-9]+\.[A-z0-9]+\/[A-z0-9]+\/[A-z0-9\-]+)\"/ig);
                    if(data_src != null){
                        for (var i = 0; i < data_src.length; i++) {
                            data_src[i] = data_src[i].match(/data-image=\"([A-z0-9]+:\/\/[A-z0-9]+\.[A-z0-9]+\.[A-z0-9]+\/[A-z0-9]+\/[A-z0-9\-]+)\"/i)[1];
                            data_src[i] = decodeURIComponent(data_src[i]) + '.jpg';
                        }
                    }

                    return data_src;
                }
            }
            var twitterFetcher = {
                fetch: function(config) {
                    if (config.maxTweets === undefined) {
                        config.maxTweets = 20;
                    }
                    if (config.enableLinks === undefined) {
                        config.enableLinks = true;
                    }
                    if (config.showUser === undefined) {
                        config.showUser = true;
                    }
                    if (config.showTime === undefined) {
                        config.showTime = true;
                    }
                    if (config.dateFunction === undefined) {
                        config.dateFunction = 'default';
                    }
                    if (config.showRetweet === undefined) {
                        config.showRetweet = true;
                    }
                    if (config.customCallback === undefined) {
                        config.customCallback = null;
                    }
                    if (config.showInteraction === undefined) {
                        config.showInteraction = true;
                    }
                    if (config.showImages === undefined) {
                        config.showImages = false;
                    }
                    if (config.useEmoji === undefined) {
                        config.useEmoji = false;
                    }
                    if (config.linksInNewWindow === undefined) {
                        config.linksInNewWindow = true;
                    }
                    if (config.showPermalinks === undefined) {
                        config.showPermalinks = true;
                    }
                    if (config.dataOnly === undefined) {
                        config.dataOnly = false;
                    }
                    if (inProgress) {
                        queue.push(config);
                    } else {
                        inProgress = true;
                        domNode = config.domId;
                        maxTweets = config.maxTweets;
                        parseLinks = config.enableLinks;
                        printUser = config.showUser;
                        printTime = config.showTime;
                        showRts = config.showRetweet;
                        formatterFunction = config.dateFunction;
                        customCallbackFunction = config.customCallback;
                        showInteractionLinks = config.showInteraction;
                        showImages = config.showImages;
                        useEmoji = config.useEmoji;
                        targetBlank = config.linksInNewWindow;
                        permalinks = config.showPermalinks;
                        dataOnly = config.dataOnly;
                        var head = document.getElementsByTagName('head')[0];
                        if (script !== null) {
                            head.removeChild(script);
                        }
                        script = document.createElement('script');
                        script.type = 'text/javascript';
                        if (config.list !== undefined) {
                            script.src = 'https://syndication.twitter.com/timeline/list?' + 'callback=__twttrf.callback&dnt=false&list_slug=' +
                                config.list.listSlug + '&screen_name=' + config.list.screenName + '&suppress_response_codes=true&lang=' + (config.lang || lang) + '&rnd=' + Math.random();
                        } else if (config.profile !== undefined) {
                            script.src = 'https://syndication.twitter.com/timeline/profile?' + 'callback=__twttrf.callback&dnt=false' + '&screen_name=' + config.profile.screenName + '&suppress_response_codes=true&lang=' + (config.lang || lang) + '&rnd=' + Math.random();
                        } else if (config.likes !== undefined) {
                            script.src = 'https://syndication.twitter.com/timeline/likes?' + 'callback=__twttrf.callback&dnt=false' + '&screen_name=' + config.likes.screenName + '&suppress_response_codes=true&lang=' + (config.lang || lang) + '&rnd=' + Math.random();
                        } else {
                            script.src = 'https://cdn.syndication.twimg.com/widgets/timelines/' +
                                config.id + '?&lang=' + (config.lang || lang) + '&callback=__twttrf.callback&' + 'suppress_response_codes=true&rnd=' + Math.random();
                        }
                        head.appendChild(script);
                    }
                },
                callback: function(data) {
                    if (data === undefined || data.body === undefined) {
                        inProgress = false;
                        if (queue.length > 0) {
                            twitterFetcher.fetch(queue[0]);
                            queue.splice(0, 1);
                        }
                        return;
                    }
                    if (!useEmoji) {
                        data.body = data.body.replace(/(<img[^c]*class="Emoji[^>]*>)|(<img[^c]*class="u-block[^>]*>)/g, '');
                    }
                    if (!showImages) {
                        data.body = data.body.replace(/(<img[^c]*class="NaturalImage-image[^>]*>|(<img[^c]*class="CroppedImage-image[^>]*>))/g, '');
                    }
                    if (!printUser) {
                        data.body = data.body.replace(/(<img[^c]*class="Avatar"[^>]*>)/g, '');
                    }
                    var div = document.createElement('div');
                    div.innerHTML = data.body;
                    if (typeof(div.getElementsByClassName) === 'undefined') {
                        supportsClassName = false;
                    }

                    function swapDataSrc(element) {
                        var avatarImg = element.getElementsByTagName('img')[0];
                        if (avatarImg) {
                            avatarImg.src = avatarImg.getAttribute('data-src-2x');
                        } else {
                            var screenName = element.getElementsByTagName('a')[0].getAttribute('href').split('twitter.com/')[1];
                            var img = document.createElement('img');
                            img.setAttribute('src', 'https://twitter.com/' + screenName + '/profile_image?size=bigger');
                            element.prepend(img);
                        }
                        return element;
                    }
                    var tweets = [];
                    var authors = [];
                    var times = [];
                    var images = [];
                    var rts = [];
                    var tids = [];
                    var permalinksURL = [];
                    var x = 0;
                    if (supportsClassName) {
                        var tmp = div.getElementsByClassName('timeline-Tweet');
                        while (x < tmp.length) {
                            if (tmp[x].getElementsByClassName('timeline-Tweet-retweetCredit').length > 0) {
                                rts.push(true);
                            } else {
                                rts.push(false);
                            }
                            if (!rts[x] || rts[x] && showRts) {
                                tweets.push(tmp[x].getElementsByClassName('timeline-Tweet-text')[0]);
                                tids.push(tmp[x].getAttribute('data-tweet-id'));
                                if (printUser) {
                                    authors.push(swapDataSrc(tmp[x].getElementsByClassName('timeline-Tweet-author')[0]));
                                }
                                times.push(tmp[x].getElementsByClassName('dt-updated')[0]);
                                permalinksURL.push(tmp[x].getElementsByClassName('timeline-Tweet-timestamp')[0]);
                                if (tmp[x].getElementsByClassName('timeline-Tweet-media')[0] !== undefined) {
                                    images.push(tmp[x].getElementsByClassName('timeline-Tweet-media')[0]);
                                } else {
                                    images.push(undefined);
                                }
                            }
                            x++;
                        }
                    } else {
                        var tmp = getElementsByClassName(div, 'timeline-Tweet');
                        while (x < tmp.length) {
                            if (getElementsByClassName(tmp[x], 'timeline-Tweet-retweetCredit').length > 0) {
                                rts.push(true);
                            } else {
                                rts.push(false);
                            }
                            if (!rts[x] || rts[x] && showRts) {
                                tweets.push(getElementsByClassName(tmp[x], 'timeline-Tweet-text')[0]);
                                tids.push(tmp[x].getAttribute('data-tweet-id'));
                                if (printUser) {
                                    authors.push(swapDataSrc(getElementsByClassName(tmp[x], 'timeline-Tweet-author')[0]));
                                }
                                times.push(getElementsByClassName(tmp[x], 'dt-updated')[0]);
                                permalinksURL.push(getElementsByClassName(tmp[x], 'timeline-Tweet-timestamp')[0]);
                                if (getElementsByClassName(tmp[x], 'timeline-Tweet-media')[0] !== undefined) {
                                    images.push(getElementsByClassName(tmp[x], 'timeline-Tweet-media')[0]);
                                } else {
                                    images.push(undefined);
                                }
                            }
                            x++;
                        }
                    }
                    if (tweets.length > maxTweets) {
                        tweets.splice(maxTweets, (tweets.length - maxTweets));
                        authors.splice(maxTweets, (authors.length - maxTweets));
                        times.splice(maxTweets, (times.length - maxTweets));
                        rts.splice(maxTweets, (rts.length - maxTweets));
                        images.splice(maxTweets, (images.length - maxTweets));
                        permalinksURL.splice(maxTweets, (permalinksURL.length - maxTweets));
                    }
                    var arrayTweets = [];
                    var x = tweets.length;
                    var n = 0;
                    if (dataOnly) {
                        while (n < x) {
                            arrayTweets.push({
                                tweet: tweets[n].innerHTML,
                                author: authors[n] ? authors[n].innerHTML : 'Unknown Author',
                                author_data: {
                                    profile_url: authors[n] ? authors[n].querySelector('[data-scribe="element:user_link"]').href : null,
                                    profile_image: authors[n] ? 'https://twitter.com/' + authors[n].querySelector('[data-scribe="element:screen_name"]').title.split('@')[1] + '/profile_image?size=bigger' : null,
                                    profile_image_2x: authors[n] ? 'https://twitter.com/' + authors[n].querySelector('[data-scribe="element:screen_name"]').title.split('@')[1] + '/profile_image?size=original' : null,
                                    screen_name: authors[n] ? authors[n].querySelector('[data-scribe="element:screen_name"]').title : null,
                                    name: authors[n] ? authors[n].querySelector('[data-scribe="element:name"]').title : null
                                },
                                time: times[n].textContent,
                                timestamp: times[n].getAttribute('datetime').replace('+0000', 'Z').replace(/([\+\-])(\d\d)(\d\d)/, '$1$2:$3'),
                                image: (extractImagesUrl(images[n]) ? extractImagesUrl(images[n])[0] : undefined),
                                images: extractImagesUrl(images[n]),
                                rt: rts[n],
                                tid: tids[n],
                                permalinkURL: (permalinksURL[n] === undefined) ? '' : permalinksURL[n].href
                            });
                            n++;
                        }
                    } else {
                        while (n < x) {
                            if (typeof(formatterFunction) !== 'string') {
                                var datetimeText = times[n].getAttribute('datetime');
                                var newDate = new Date(times[n].getAttribute('datetime').replace(/-/g, '/').replace('T', ' ').split('+')[0]);
                                var dateString = formatterFunction(newDate, datetimeText);
                                times[n].setAttribute('aria-label', dateString);
                                if (tweets[n].textContent) {
                                    if (supportsClassName) {
                                        times[n].textContent = dateString;
                                    } else {
                                        var h = document.createElement('p');
                                        var t = document.createTextNode(dateString);
                                        h.appendChild(t);
                                        h.setAttribute('aria-label', dateString);
                                        times[n] = h;
                                    }
                                } else {
                                    times[n].textContent = dateString;
                                }
                            }
                            var op = '';
                            if (parseLinks) {
                                if (targetBlank) {
                                    targetLinksToNewWindow(tweets[n]);
                                    if (printUser) {
                                        targetLinksToNewWindow(authors[n]);
                                    }
                                }
                                if (printUser) {
                                    op += '<div class="user">' + strip(authors[n].innerHTML) + '</div>';
                                }
                                op += '<p class="tweet">' + strip(tweets[n].innerHTML) + '</p>';
                                if (printTime) {
                                    if (permalinks) {
                                        op += '<p class="timePosted"><a href="' + permalinksURL[n] + '">' + times[n].getAttribute('aria-label') + '</a></p>';
                                    } else {
                                        op += '<p class="timePosted">' +
                                            times[n].getAttribute('aria-label') + '</p>';
                                    }
                                }
                            } else {
                                if (tweets[n].textContent) {
                                    if (printUser) {
                                        op += '<p class="user">' + authors[n].textContent + '</p>';
                                    }
                                    op += '<p class="tweet">' + tweets[n].textContent + '</p>';
                                    if (printTime) {
                                        op += '<p class="timePosted">' + times[n].textContent + '</p>';
                                    }
                                } else {
                                    if (printUser) {
                                        op += '<p class="user">' + authors[n].textContent + '</p>';
                                    }
                                    op += '<p class="tweet">' + tweets[n].textContent + '</p>';
                                    if (printTime) {
                                        op += '<p class="timePosted">' + times[n].textContent + '</p>';
                                    }
                                }
                            }
                            if (showInteractionLinks) {
                                op += '<p class="interact"><a href="https://twitter.com/intent/' + 'tweet?in_reply_to=' + tids[n] + '" class="twitter_reply_icon"' +
                                    (targetBlank ? ' target="_blank" rel="noopener">' : '>') + 'Reply</a><a href="https://twitter.com/intent/retweet?' + 'tweet_id=' + tids[n] + '" class="twitter_retweet_icon"' +
                                    (targetBlank ? ' target="_blank" rel="noopener">' : '>') + 'Retweet</a>' + '<a href="https://twitter.com/intent/favorite?tweet_id=' +
                                    tids[n] + '" class="twitter_fav_icon"' +
                                    (targetBlank ? ' target="_blank" rel="noopener">' : '>') + 'Favorite</a></p>';
                            }
                            if (showImages && images[n] !== undefined && extractImagesUrl(images[n]) !== undefined) {
                                var extractedImages = extractImagesUrl(images[n]);
                                if (extractedImages != null) {
                                    for (var i = 0; i < extractedImages.length; i++) {
                                        op += '<div class="media">' + '<img src="' + extractedImages[i] + '" alt="Image from tweet" />' + '</div>';
                                    }
                                }
                            }
                            if (showImages) {
                                arrayTweets.push(op);
                            } else if (!showImages && tweets[n].textContent.length) {
                                arrayTweets.push(op);
                            }
                            n++;
                        }
                    }
                    handleTweets(arrayTweets);
                    inProgress = false;
                    if (queue.length > 0) {
                        twitterFetcher.fetch(queue[0]);
                        queue.splice(0, 1);
                    }
                }
            };
            window.__twttrf = twitterFetcher;
            window.twitterFetcher = twitterFetcher;
            return twitterFetcher;
        }));
        (function(arr) {
            arr.forEach(function(item) {
                if (item.hasOwnProperty('prepend')) {
                    return;
                }
                Object.defineProperty(item, 'prepend', {
                    configurable: true,
                    enumerable: true,
                    writable: true,
                    value: function prepend() {
                        var argArr = Array.prototype.slice.call(arguments),
                            docFrag = document.createDocumentFragment();
                        argArr.forEach(function(argItem) {
                            var isNode = argItem instanceof Node;
                            docFrag.appendChild(isNode ? argItem : document.createTextNode(String(argItem)));
                        });
                        this.insertBefore(docFrag, this.firstChild);
                    }
                });
            });
        })([Element.prototype, Document.prototype, DocumentFragment.prototype]);


        let name = tw_sname;

        let text = '{ "profile": {  "screenName":' +
            '"${screenname}"' + '},' + '"domId": "example1",' +
            '"maxTweets": 1,' +
            '"enableLinks": true,'+
            '"showUser": true,'+
            '"showTime": true,'+
            '"showImages": true,'+
            '"lang": "en"}';


        let configProfile = JSON.parse(text);


        twitterFetcher.fetch(configProfile);


        let configLikes = {
            "likes": {
                "screenName": 'iamkashifakram'
            },
            "domId": 'example2',
            "maxTweets": 3,
            "enableLinks": true,
            "showUser": true,
            "showTime": true,
            "showImages": true,
            "lang": 'en'
        };
        twitterFetcher.fetch(configLikes);


        var configList = {
            "list": {
                "listSlug": 'inspiration',
                "screenName": 'iamkashifakram'
            },
            "domId": 'example3',
            "maxTweets": 3,
            "enableLinks": true,
            "showUser": true,
            "showTime": true,
            "showImages": true,
            "lang": 'en'
        };
        twitterFetcher.fetch(configList);

    </script>

    <style>
        /*
* Example style!
* You can do whatever the hell you want on your site :-)
*/

        h2 {
            clear:both;
        }

        p, a {
            font-size:9pt;
            margin:10px 0 0 0;
            color:#3d3d3d;
        }

        a, a:visited {
            color:#427fed;
        }

        a:hover {
            color:#82afff;
        }

        ul li {
            list-style:none;
            overflow:hidden;
            border:1px solid #dedede;
            margin:5px;
            padding:5px;
        }

        ul li:hover {
            background-color:#f0f3fb;
        }

        .user, .tweet, .timePosted {
            float:left;
        }

        .user {
            width:25%;
        }

        .tweet {
            width:50%;
        }

        .timePosted {
            width:15%;
        }

        .user {
            clear:left;
        }

        .user a {
            width: 100px;
        }

        .user span span {
            width:100px;
            display:block;
            margin-top:10px;
        }

        .user img, .user a > span {
            float:left;
        }

        .user div {
            clear: left;
        }

        .interact {
            float:left;
            width:10%;
            margin-top:-7px;
        }

        .interact a {
            margin-left:5px;
            float:left;
        }

        .user a > span {
            margin-left:10px;
        }

        .media img {
            max-width:250px;
            max-height:250px;
        }

        #linkage {
            position:fixed;
            top:0px;
            right:0px;
            background-color:#3d3d3d;
            color:#ffffff;
            text-decoration:none;
            padding:5px;
            width:10%;
            font-family:arial;
        }
    </style>

</head>

<body>
<h2>Query 1: My latest tweet</h2>
<div id="example1"></div>
<h2>Query 2: Last 3 posts I like</h2>
<div id="example2"></div>
<h2>Query 3: Recent 3 posts from a custom list</h2>
<div id="example3"></div>

</body>

</html>

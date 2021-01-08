<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/25
  Time: 4:37 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 결제</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <link rel="stylesheet" href="/css/reset.css">

    <%-- Bootstrap, JQuery Library --%>
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/css/content_logis.css">

    <script src='/js/nprogress.js'></script>
    <link rel='stylesheet' href='/css/nprogress.css'/>

    <script type="text/javascript">
        $(document).ready(function () {
           $("#btnHome").click(function (key) {
               location.href = "/user/warehouse/paycoTest";
           });
        });
    </script>
    <style>
        body {
            background-color: white;
        }

        #wrap {
            width: 720px;
            margin: 0 auto;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .div-center-box {
            display: flex;
            width: 60%;
            height: 40vh;
            flex-direction: column;
            border: 1px solid lightgrey;
            border-radius: 8px;
            justify-content: center;
            align-items: center;
        }

        .span-paying {
            font-size: 2rem;
            font-weight: 800;
        }

    </style>
</head>
<body>
<div id="wrap">
    <div class="div-center-box">
        <div style="width:100%; text-align: center;">
            <span class="span-paying">결제가 취소되었습니다.</span>
        </div>
        <div style="margin-top: 5%; width:100%; text-align: center;">
            <input id="btnHome" type="button" class="btn btn-logis-primary" value="메인으로" style="width: 40%;">
        </div>
    </div>
</div>
</body>
</html>

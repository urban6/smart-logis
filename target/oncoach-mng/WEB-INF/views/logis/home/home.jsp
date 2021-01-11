<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2021/01/07
  Time: 4:47 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.9, user-scalable=no">
    <title>SMART GIMHAE</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/superslides.css">
    <script src="/js/jquery.min.js"></script>

    <script src="/js/all.js" type="text/javascript"></script>
    <script src="/js/jquery.easing.1.3.js"></script>
    <script src="/js/jquery.animate-enhanced.min.js"></script>
    <script src="/js/hammer.min.js"></script>
    <script src="/js/jquery.superslides.js" type="text/javascript" charset="utf-8"></script>
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>

    <script src="/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // 창고 대여
            $("#warehouseApply").click(function (key) {
                movePage("POST", "/user/warehouse/apply");
            });

            // 내가빌린 창고 조회
            $("#warehouseSearch").click(function (key) {
                movePage("POST", "/user/warehouse/search");
            });

            // 물류 배송신청
            $("#logisApply").click(function (key) {
                checkUsingWarehouse();
            });

            // 물류 배송신청
            $("#logisNormalApply").click(function (key) {
                movePage("POST", "/user/logis/normalApply");
            });

            // 물류 배송조회
            $("#logisSearch").click(function (key) {
                movePage("POST", "/user/logis/search");
            });

            // 창고등록
            $("#warehouseLend").click(function (key) {
                movePage("POST", "/user/warehouse/lend");
            });

            // 내가빌려준 창고 조회
            $("#rentWarehouseSearch").click(function () {
                rentWarehouseSearch();
            });
        });

        function movePage(method, action) {
            const form = document.createElement('form');
            form.setAttribute('method', method);
            form.setAttribute('action', action);
            document.body.appendChild(form);
            form.submit();
        }

        // 창고 등록을 했을 경우에만 현황을 볼 수 있도록 한다.
        function rentWarehouseSearch() {
            $.ajax("/user/warehouse/findWarehouseUid",
                {
                    method: 'POST',
                    data: {},
                    dataType: 'JSON'
                }
            ).done(function (data) {
                console.log(data.code);
                if (data.code == 0) {
                    const warehouse = document.createElement('input');
                    warehouse.setAttribute("name", "warehouseUid");
                    warehouse.setAttribute("value", data.warehouseUid);

                    const form = document.createElement('form');
                    form.setAttribute('method', 'POST');
                    form.setAttribute('action', '/user/warehouse/rentSearch');
                    form.appendChild(warehouse);
                    document.body.appendChild(form);
                    form.submit();
                } else {
                    alert("등록된 창고가 업습니다. 창고를 먼저 등록해 주세요.");
                }
            }).fail(function (e) {
                alert("잠시 후 다시 시도해 주세요.");
                console.log(e);
            });
        }

        // 창고 대여를 했을 경우에만 창고 입고신청을 할 수 있도록 해야한다.
        function checkUsingWarehouse() {
            $.ajax("/user/logis/checkUsingWarehouse",
                {
                     method: 'POST',
                     data: {},
                     dataType: 'JSON'
                }
            ).done(function (data) {
                if (data.result) {
                    movePage("POST", "/user/logis/apply");
                } else {
                    alert("창고를 먼저 대여해 주세요.");
                }
            }).fail(function (e) {
                alert("잠시 후 다시 시도해 주세요.");
                console.log(e);
            });
        }
    </script>
</head>
<body>
<div class="intro">
    <img src="/img/logo.png" alt=""><br>
    <div class="menu">
        <div class="menu_50">
            <div class="menu_cell bg_tr">
                <h2>빌리시는 분</h2><br>
                <div class="menu_cell_50">
                    <div id="warehouseApply" class="icon_a"><img src="/img/icon_02.png" alt=""></div>
                    <br>창고 대여
                </div>
                <div class="menu_cell_50">
                    <div id="warehouseSearch" class="icon_a"><img src="/img/icon_04.png" alt=""></div>
                    <br>창고 대여 현황
                </div>
            </div>
            <div class="menu_cell bg_tr">
                <h2>공유하시는 분</h2><br>
                <div class="menu_cell_50">
                    <div id="warehouseLend" class="icon_a"><img src="/img/icon_01.png" alt=""></div>
                    <br>창고 등록
                </div>
                <div class="menu_cell_50">
                    <div id="rentWarehouseSearch" class="icon_a"><img src="/img/icon_03.png" alt=""></div>
                    <br>창고 임대 현황
                </div>
            </div>
        </div>
        <div class="menu_50">
            <div class="menu_cell bg_tr">
                <h2></h2><br>
                <div class="menu_cell_50">
                    <div id="logisApply" class="icon_a"><img src="/img/icon_05.png" alt=""></div>
                    <br>창고 입고신청
                </div>
                <div class="menu_cell_50">
                    <div id="logisNormalApply" class="icon_a"><img src="/img/icon_05.png" alt=""></div>
                    <br>일반 배송신청
                </div>
            </div>
            <div class="menu_cell bg_tr">
                <br>
                <div id="logisSearch" class="icon_a_2"><img src="/img/icon_06.png" alt=""></div>
                <h2>물류 배송조회</h2>
            </div>
        </div>
    </div>
</div>
<div class="embs">
    <img src="/img/emb.png" alt=""> <img src="/img/emb2.png" alt="">
</div>
<footer>
    Copyright ⓒ 2021 <span>Gimhae City</span>, All Rights Reserved.
</footer>
</body>
</html>

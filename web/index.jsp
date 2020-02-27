<%--
  Created by IntelliJ IDEA.
  User: lifubao
  Date: 2020/2/21
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
    <%--引入jquery--%>
    <script type="text/javascript" src="js/jquery-1.12.4.js"></script>
    <script type="text/javascript">
    $(function () {

    });
    function sendRequest() {
      $.ajax({
        url : "/ajax.do"
        ,type : "get"
        ,dataType : "text"
        ,data : {id : 1, username : "admin"}
        ,beforeSend : function () {
          console.log("发送请求之前。。");
        }
        ,success : function (data) {
          console.log("请求成功");
          //返回的data是一个json格式的字符串
          //var userJson = JSON.parse(data);//将json字符串转换成json对象
          var userListJson = JSON.parse(data);//将json字符串转换成json对象
          console.log(userListJson);

          var respContent = $("#respContent");
          $.each(userListJson,function (index,user) {
            respContent.append("<h1>"+user.username+"</h1>");
          });


        }
        ,error : function (error) {//发生任何错误都会返回错误方法
          console.log(error);
        }
      });
    }
    function sendGet() {
      $.get({
        url : "/ajax.do"
        ,data : {id : 1, username : "admin"}
        ,dataType : "text"
        ,beforeSend : function () {
          console.log("发送请求之前。。");
        }
        ,success : function (data) {
          console.log("请求成功");
          console.log(data);

        }
        ,error : function (error) {//发生任何错误都会返回错误方法
          console.log(error);
        }
      });
    }
    </script>
  </head>
  <body>
    <button onclick="sendRequest()">发送ajax请求</button>
    <button onclick="sendGet()">发送get请求</button>

  <div id="respContent">

  </div>
  </body>
</html>

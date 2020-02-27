# AJAX: 局部刷新  异步请求

## 1、什么是Ajax

Ajax：一种不用刷新整个页面便可与服务器通讯的办法

Web的传统模型。客户端向服务器发送一个请求，服务器返回整个页面，如此反复

在Ajax模型中，数据在客户端与服务器之间独立传输。服务器不再返回整个页面

## 2、Ajax应用程序

1. 通过异步模式，提升了用户体验

2. 优化了浏览器和服务器之间的传输，减少不必要的数据往返，减少了带宽占用

3. Ajax引擎在客户端运行，承担了一部分本来由服务器承担的工作，从而减少了大用户量下的服务器负载。

## 3、Ajax的缺陷

1. 由 Javascript 和 AJAX 引擎导致的浏览器的兼容

2. 页面局部刷新，导致后退等功能失效。

3. 对流媒体的支持没有FLASH、Java Applet好。

4. 一些手持设备（如手机、PDA等）支持性差



## 4、Ajax实现

### Ajax参数

> url :请求路径
>
> type：请求方式
>
> dataType：响应数据的类型
>
> data:请求的参数数据  一般都是以json的形式来发送
>
> success：表示请求成功之后 执行的回调函数   返回的状态码为200
>
> error：表示请求失败之后执行的回调函数  
>
> beforeSend:请求之前执行。

### $.ajax()

```javascript
function  sendRequst(){
    $.ajax({
        url: "/ajax.do",
        type: "get",
        dataType: "json",
        data: {id:1,username:"admin"},
        success: function (data) {
            console.log(data)
        }
    })
}
```

### $.get() (或$.post())

$.get() 方法使用 GET 方式来进行异步请求. 它的结构是: $.get(url\[, data]\[, callback][, type]);

```javas
function sendGet() {
       // $.get({
    $.post({
            url:"/ajax.do",
            data:{"id": 1,"username":"zhangsan"},
            dataType: "text",
            success:function(data){
                console.log("请求成功")
            }
        })
}
```



## 5、服务端响应：

响应的数据格式 ：可以响应文本  可以响应html  

### 服务端响应json 

```java
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("text/html;charSet=utf-8");
    String id = req.getParameter("id");
    String username = req.getParameter("username");
    System.out.println("接受到ajax请求 :" + id + "---" + username);
    //服务端响应ajax请求的响应方式
    PrintWriter out = resp.getWriter();
    out.println("服务端响应");

}
```

### 服务端响应json

将Java对象转换为json  fastjson ---ali  GSon  --google 

```java
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("text/html;charSet=utf-8");
    String id = req.getParameter("id");
    String username = req.getParameter("username");
    System.out.println("接受到ajax请求 :" + id + "---" + username);
    //服务端响应ajax请求的响应方式
    PrintWriter out = resp.getWriter();
    User user = new User("张三",22);
    // 将JAVAbean 转换为了json字符串
   String userStr = JSON.toJSONString(user);
    System.out.println(userStr);
    out.println(userStr);

}
```



```js
$.post({
    url:"/ajax.do",
    data:{"id": 1,"username":"zhangsan"},
    dataType: "text",
    success:function(data){
        var respData = data;//返回来的是一个json字符串  json格式的字符串
        var user = JSON.parse(respData);//将json字符串转换为json对象
        $("#respContent").html("<h1 style='color: red'>" + user.username+"</h1>")
    }
})
```



#### 响应List

```java
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setContentType("text/html;charSet=utf-8");
    String id = req.getParameter("id");
    String username = req.getParameter("username");
    System.out.println("接受到ajax请求 :" + id + "---" + username);
    //服务端响应ajax请求的响应方式
    PrintWriter out = resp.getWriter();
    User user1 = new User("张三1",21);
    User user2 = new User("张三2",22);
    User user3 = new User("张三3",23);
    List<User> userList = new ArrayList<>();
    userList.add(user1);
    userList.add(user2);
    userList.add(user3);
    // 将JAVAbean 转换为了json字符串
   String listUser = JSON.toJSONString(userList);
    System.out.println(listUser);
    out.println(listUser);

}
```



```js
function sendGet() {
    // $.get({
    $.post({
        url:"/ajax.do",
        data:{"id": 1,"username":"zhangsan"},
        dataType: "text",
        success:function(data){
            var userList = JSON.parse(data);//将json字符串转换为json对象
            console.log(userList);
            var htmlStr="";
            $.each(userList,function (index,user) {
                htmlStr+= "<h1 style='color: red'>" + user.username+"</h1>";
            })
            $("#respContent").html(htmlStr);
        }
    })
}
```


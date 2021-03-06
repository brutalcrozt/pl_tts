<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import = "java.util.logging.Logger" %>
<%@page import = "java.util.logging.Level" %>
<%@page import="m.DrinksQ"%>
<%@page import="m.Drink"%>
<%@page import="m.Page" %>
<%@page import="m.Formater" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  Logger logger = Logger.getLogger(this.getClass().getName());
  Page webPage= new Page("Daftar Minuman");
  Page.Web_Library jq = webPage.new Web_Library();
  jq.css_location = "";
  jq.js_location = "../node_modules/jquery/dist/jquery.min.js";
  webPage.libs.add(jq);
  Page.Web_Library jqUi = webPage.new Web_Library();
  jqUi.css_location = "../node_modules/jquery-ui-dist/jquery-ui.min.css";
  jqUi.js_location = "../node_modules/jquery-ui-dist/jquery-ui.min.js";
  webPage.libs.add(jqUi);
  Page.Web_Library bs = webPage.new Web_Library();
  bs.css_location = "../node_modules/bootstrap/dist/css/bootstrap.min.css";
  bs.js_location = "../node_modules/bootstrap/dist/js/bootstrap.bundle.min.js";
  webPage.libs.add(bs);
  request.setAttribute("webPage", webPage);
  String baseUrl= request.getContextPath();
%>
<!DOCTYPE html>
<html>
  <jsp:include page="./header/head.title.jsp"/>
  <style>
    tr td img {
      max-width: 400px;
    }
  </style>
  <body>
    <%
      try {
        ArrayList<Drink> drinks = DrinksQ.selectAll();
    %>
    <h2>Daftar minuman</h2>
    <div class="atas">
      <table class="list table">
        <thead class="thead-dark">
          <tr>
            <th>Name</th>
            <th>Price</th>
            <th>Deskripsi</th>
            <th>Gambar</th>
            <th>Aksi</th>
          </tr>
        </thead>
        <%
          if (!drinks.isEmpty()) {
            for (Drink d : drinks) {
              String dashedName= Formater.toDashCase(d.getName());
              out.print("<td>" + d.getName() + "</td>");
              out.print("<td>" + d.getPrice() + "</td>");
              out.print("<td>" + d.getDescription() + "</td>");
              out.print("<td><img src='" + 
                      baseUrl+ "/images/upload/"+
                      d.getPicture_url() + "'/></td>");
              out.print("<td>");
              out.print("<a href='"+ baseUrl+"/add/drink/"+ dashedName+"'>edit</a> | ");
              out.print("<a href='"+ baseUrl+"/delete/drink/"+ dashedName+ "' class='btn btn-danger'>hapus</a>");
              out.print("</td>");
              out.print("</tr>");
            }
          } else {
            out.print("<tr>");
            out.print("<td colspan='6'>Data Tidak Ditemukan</td>");
            out.print("</tr>");
          }
        %>
      </table>
    </div>
    <%
      } catch (Exception E) {
        out.print(E.getMessage());
        logger.log(Level.SEVERE, E.getMessage());
        logger.log(Level.SEVERE, E.getStackTrace().toString());
        E.printStackTrace();
      }
    %>
  </body>
</html>
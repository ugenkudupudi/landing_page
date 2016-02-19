<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<title>hire, cloud pro - TCaaS</title>
<body>
<c:catch var="insert_exception">
<sql:update var="update" dataSource="jdbc/TEST">
INSERT INTO betausers VALUES (?,?,?,?);
<sql:param value='${param["email"]}' />
<sql:param value='${param["user_name"]}' />
<sql:param value='${param["user_type"]}' />
<sql:param value='${param["cname"]}' />
</sql:update>
</c:catch>

<c:choose>
<c:when test="${insert_exception == null }">
<!-- 1st if condition -->
<script language="javascript">
window.location.href = "mesg.htm?type=success&message=Please HELP us reach out to your friends by sharing us on social media";
</script>

</c:when>

<c:when test="${fn:contains(insert_exception,'Duplicate entry')}">
<!-- 2nd if condition -->
<script language="javascript">
window.location.href = "mesg.htm?type=error&message=<%= request.getParameter("email")%> is already registering with us.";
</script>

</c:when>

<c:when test="${insert_exception != null }">
<!-- 3rd if condition -->
<!-- Error ${insert_exception.message}  -->
<script language="javascript">
window.location.href = "mesg.htm?type=error&message=Invalid inputs received";
</script>
</c:when>
</c:choose>

</body>
</html>

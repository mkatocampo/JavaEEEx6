<%-- 
    Document   : teams
    Created on : Jan 26, 2021, 11:17:19 AM
    Author     : Chris.Cusack
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="edu.nbcc.student.Student"%>
<%@page import="java.util.Vector"%>
<%@taglib uri="WEB-INF/tlds/studentDropdown.tld" prefix="s"%>
<%@include file="WEB-INF/jspf/declarativemethods.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dev Teams</title>
<%@include file="WEB-INF/jspf/header.jspf"%>
<style>
.container {
	padding: 20px;
}

.student-select {
	width: 275px;
}

.blue {
	color: blue;
}
</style>
</head>
<body>
	<%@include file="WEB-INF/jspf/navigation.jspf"%>
	<h1>Dev Teams</h1>
	<div class="container">
		  
        <% 
        int student1 = 0;
        int student2 = 0;
        
        Student stu1 = null;
        Student stu2 = null;
        
        errors = new Vector<String>();   
        boolean submitted = false;
        Vector<Student> team = new Vector<Student>();
        
        if (request.getParameter("btnSubmit") != null) {
        		student1 = Integer.parseInt(request.getParameter("dd1"));
        		student2 = Integer.parseInt(request.getParameter("dd2"));        		
        		stu1 = Student.getStudent(student1);
        		stu2 = Student.getStudent(student2);
        		
        		if (Student.isStudentOnTeam(team,stu1)) {
    				errors.add("Student " + stu1.getFirstName() + " is already added");
    			} else{
    				team.add(stu1);
    			}
        		
        		if (Student.isStudentOnTeam(team,stu2)) {
    				errors.add("Student " + stu2.getFirstName() + " is already added");
    			} else{
    				team.add(stu2);
    			}
        		
        		Vector<Vector<Student>> studentTeams;
        		
        		if (session.getAttribute("teams") != null) {        			
        			studentTeams = (Vector<Vector<Student>>)session.getAttribute("teams");
        		} else {
        			studentTeams = new Vector<Vector<Student>>();
        		}
        		
        		for (Vector<Student> t :studentTeams) {
        			if (Student.isStudentOnTeam(t,stu1)) {
        				errors.add("Error adding " + stu1.getFirstName() + " A student cannot be added twice");
        			}
        			if (Student.isStudentOnTeam(t,stu2)) {
        				errors.add("Error adding " + stu2.getFirstName() + " A Student cannot be added twice");
        			}
        		}        		
        	
        		if (errors.isEmpty()) {
	        		studentTeams.add(team);
	        		session.setAttribute("teams", studentTeams);
        		}
        		
        		submitted = true;
        	}%>
        	
     	<% if (!submitted || !errors.isEmpty())  {%>
		<form method="post">
			<br /> <br /> <label>Student 1</label>
			<s:studentdropdown name="dd1" className="select 1" />
			<br /> <label>Student 2</label>
			<s:studentdropdown name="dd2" className="select 2" selectedIndex="1" />
			<br />
			<button class="btn btn-primary" name="btnSubmit">Create Team</button>
		</form>
		
		<% if (!errors.isEmpty()){%>
		<ul>
		<%for (String err: errors) {%>
		<li> <%=err %> </li>
		<%} %>
		</ul>
		
		<%} %>
		
		<%} else { %>
		   <table>
		<% for (Student student: team)  {%>
        <tr>
        	<td> <%=student.getId() %></td>
        	<td> <%=student.getFirstName()%></td>
        	<td> <%=student.getLastName() %></td>
        </tr>
        <%} %>
         </table>
         <a href="teams.jsp">Create</a>
         <%} %>
	</div>
	
	<%@include file="WEB-INF/jspf/footer.jspf"%>
</body>
</html>

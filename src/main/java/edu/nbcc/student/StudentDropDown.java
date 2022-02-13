/**
 * 
 */
package edu.nbcc.student;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * @author Arun.John
 *
 */
public class StudentDropDown extends SimpleTagSupport {
	private String name;
	private String className;
	private int selectedIndex;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}

	/**
	 * @param className the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
	}

	/**
	 * @return the selectedIndex
	 */
	public int getSelectedIndex() {
		return selectedIndex;
	}

	/**
	 * @param selectedIndex the selectedIndex to set
	 */
	public void setSelectedIndex(int selectedIndex) {
		this.selectedIndex = selectedIndex;
	}

	@Override
	public void doTag() throws IOException {
		try {
			JspWriter out = getJspContext().getOut();
			StringBuilder strB = new StringBuilder();			
			strB.append("<select name='");
			strB.append(getName());
			strB.append("'");
			if (getClassName() != null && !getClassName().equals("")) {
				strB.append(" class='");
				strB.append(getClassName());
				strB.append("'");
			}
			strB.append(">");
			int i = 0;
			for (Student student : Student.getStudents()) {
				strB.append("<option value='");
				strB.append(student.getId());
				strB.append("'");
				if (i == getSelectedIndex()) {
					strB.append("selected");
				}
				strB.append(">");
				strB.append(student.getFirstName() + " " + student.getLastName());
				strB.append("</option>");
				i++;
			}
			strB.append("</select>");
			out.print(strB.toString());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
	}
}

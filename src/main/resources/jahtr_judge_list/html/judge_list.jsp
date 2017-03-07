<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="judgeStyle.css"/>

<jcr:jqom var="judges">
  <query:selector nodeTypeName="jahtr:judge_form"/>
  <query:descendantNode path="/sites/bger/contents/judges"/>
  <c:if test="${not empty param.order}">
    <query:sortBy propertyName="${param.order}" order="${param.type}"/>
  </c:if>
</jcr:jqom>


<form action="<c:url value='${url.base}${currentNode.path}'/>.myAction.do" method="post" 
      id="${currentNode.identifier}">
  <input type="hidden" name="jcrRedirectTo" value="<c:url value='${url.base}${renderContext.mainResource.node.path}'/>"/>
  <input type="submit" value="swap names" />
</form>


<table>
  <tr style="font-weight: bold">
    <td>
      <fmt:message key="lastName"/> 
    </td>
    <td>
      <fmt:message key="firstName"/> 
    </td>
    <td>
      <fmt:message key="officeIn"/> 
    </td>
    <td>
      <fmt:message key="officeOut"/> 
    </td>
    <td>
      <fmt:message key="court"/> 
    </td>
    <td>
      <fmt:message key="canton"/> 
    </td>
    <td>
      <fmt:message key="party"/> 
    </td>
    <td>
      <fmt:message key="yearsBirthDeath"/> 
    </td>
  </tr>
  <tr>
    <td colspan="2">
    <a href="${url.context}?order=lastName&type=asc"/>
      <img src="${url.currentModule}/images/asc.gif"/>
    </a>
    <a href="${url.context}?order=lastName&type=desc"/>
      <img src="${url.currentModule}/images/desc.gif"/>
    </td>
    <td colspan="3">
    <a href="${url.context}?order=officeIn&type=asc"/>
      <img src="${url.currentModule}/images/asc.gif"/>
    </a>
    <a href="${url.context}?order=officeIn&type=desc"/>
      <img src="${url.currentModule}/images/desc.gif"/>
    </td>
	<td colspan="3">
    <a href="${url.context}?order=canton&type=asc"/>
      <img src="${url.currentModule}/images/asc.gif"/>
    </a>
    <a href="${url.context}?order=canton&type=desc"/>
      <img src="${url.currentModule}/images/desc.gif"/>
    </td>
  </tr>
<c:forEach items="${judges.nodes}" var="judge">
  <c:set var="firstName" value="${judge.properties.firstName.string}"/>
  <c:set var="lastName" value="${judge.properties.lastName.string}"/>
  
  <fmt:formatDate pattern="yyyy" value="${judge.properties.officeIn.date.time}" var="officeIn"/>
  <fmt:formatDate pattern="yyyy" value="${judge.properties.officeOut.date.time}" var="officeOut"/>
  <fmt:formatDate pattern="yyyy" value="${judge.properties.yearOfBirth.date.time}" var="birth"/>
  <fmt:formatDate pattern="yyyy" value="${judge.properties.yearOfDeath.date.time}" var="death"/>
  <tr>
    <td>
      <c:set var="judgePageUrl" value="${url.base}/sites/bger/judge.html?fn=${firstName}&ln=${lastName}"/>
      <a href="${judgePageUrl}" onclick="window.open('${judgePageUrl}', 'newwindow', 'width=800, height=500'); return false;"> 
        ${lastName}
      </a>
      </td>
    <td>
      ${firstName}
    </td>
    <td>
      ${officeIn}
    </td>
    <td>
      ${officeOut}
    </td>
    <td>
      ${judge.properties.court.string}
    </td>
    <td>
      ${judge.properties.canton.string}
    </td>
    <td>
      ${judge.properties.party.string}
    </td>
    <td>
      ${birth} - ${death}
    </td>
  </tr>
</c:forEach>
  
</table>
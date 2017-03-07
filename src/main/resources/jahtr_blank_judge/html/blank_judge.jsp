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
  <query:equalTo propertyName="firstName" value="${param.fn}"/>
  <query:equalTo propertyName="lastName" value="${param.ln}"/>
</jcr:jqom>
<div>
<c:forEach items="${judges.nodes}" var="judge">
  <fmt:formatDate pattern="yyyy" value="${judge.properties.yearOfBirth.date.time}" var="birth"/>
  <fmt:formatDate pattern="yyyy" value="${judge.properties.yearOfDeath.date.time}" var="death"/>
  <h3 style="font: 24px bold; margin: 0 20px;">
  ${judge.properties.firstName.string}
  <span> </span>
  ${judge.properties.lastName.string} 
  <span> </span>
  ${birth} - 
  <c:choose>
  <c:when test="${empty death}">
    <c:out value="*"/>
  </c:when>
  <c:otherwise>
    <c:out value="${death}"/>
  </c:otherwise>
  </c:choose>
</h3> 
  <div class="profile-photo" style="float: left; padding: 0 10px 0 20px">
  <img src="${judge.properties.photo.node.url}"/>
</div>
  <div class="judge-bio" style="margin:10px; width: 750px;">
  ${judge.properties.biography.string}
</div>
  </div>
  </c:forEach>

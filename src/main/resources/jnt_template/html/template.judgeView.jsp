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
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>${fn:escapeXml(renderContext.mainResource.node.displayableName)}</title>

<link type="text/css" rel="stylesheet" media="screen" href="${url.currentModule}/css/styles.css" />
<c:if test="${renderContext.editMode or renderContext.editModeConfigName eq 'studiomode'}">
    <link type="text/css" rel="stylesheet" media="screen" href="${url.currentModule}/css/edit.css" />
</c:if>
</head>

<body>
    <div class="bodywrapper">
        <a class="hiddenanchor" name="start"></a>
        <div class="head">
            <div class="line line_head">
                <div class="unit size1of3">
                    <div class="mod modLogo" data-connectors="MasterSlave1Master">
                        <div class="inner">
                            <a href="/" target="_top" title="Retour à la page d'accueil" accesskey="0">
                                <img src="${url.currentModule}/images/schweizerisches-bundesgericht-logo.gif" width="300" height="189" alt="Logo Tribunal fédéral" />
                            </a>
                        </div>
                    </div>
                </div>
                <div class="unit size2of3 lastUnit grid_left">
                    <div class="line">
                        <template:area path="top-header"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="page">
        <div class="bgimgcontainer">
            <div class="bgimg bginit"></div>
            <!-- more images -->
            <div class="bgimg bgnew section0" style="display: none; background-image: url(&quot;bg1.jpg&quot;);"></div>
            <div class="bgimg bgnew section1" style="display: none; background-image: url(&quot;bg2.jpg&quot;);"></div>
            <div class="bgimg bgnew section2" style="display: none; background-image: url(&quot;bg3.jpg&quot;);"></div>
        </div>
        <div class="body">
            <template:area path="pagecontent" />
        </div>
    </div>

    <c:if test="${renderContext.editMode}">
        <template:addResources type="css" resources="edit.css" />
    </c:if>

    <template:theme />

</body>
</html>
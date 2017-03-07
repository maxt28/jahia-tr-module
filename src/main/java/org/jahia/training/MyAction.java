package org.jahia.training;

import org.jahia.bin.Action;
import org.jahia.bin.ActionResult;
import org.jahia.services.content.*;
import org.jahia.services.content.decorator.JCRUserNode;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.jahia.services.usermanager.JahiaUser;
import org.jahia.services.usermanager.JahiaUserManagerService;

import javax.jcr.Property;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.jcr.query.Query;

import java.util.List;
import java.util.Map;

public class MyAction extends Action {
  
    @Override
    public ActionResult doExecute(HttpServletRequest req,
                                  RenderContext renderContext,
                                  final Resource resource, JCRSessionWrapper session,
                                  final Map<String, List<String>> parameters,
                                  URLResolver urlResolver) throws Exception {
    JCRNodeWrapper judgeList = session.getNodeByUUID(resource.getNode().getIdentifier());
        
    final String query = "SELECT * FROM [jahtr:judge_form] WHERE ISDESCENDANTNODE('/sites/bger/contents/judges')";
    final QueryManagerWrapper queryManager = session.getWorkspace().getQueryManager();
    final JCRNodeIteratorWrapper nodes = queryManager.createQuery(query, Query.JCR_SQL2).execute().getNodes();
    while (nodes.hasNext()) {
        JCRNodeWrapper judge = (JCRNodeWrapper) nodes.next();
        String firstName = judge.getPropertyAsString("firstName");
        String lastName = judge.getPropertyAsString("lastName");
        judge.setProperty("lastName", firstName);
        judge.setProperty("firstName", lastName);
    }
    session.save();
    return new ActionResult(HttpServletResponse.SC_OK);
    }
}
package org.jahia.training;

import org.jahia.services.SpringContextSingleton;
import org.jahia.services.content.*;
import org.jahia.services.scheduler.BackgroundJob;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.jcr.RepositoryException;
import javax.jcr.query.Query;


public class BackgroundService extends BackgroundJob {


    private UserService userService;


    public BackgroundService(){
        userService = (UserService) SpringContextSingleton.getBean("userService");
    }

    @Override
    public void executeJahiaJob(JobExecutionContext jobExecutionContext) throws Exception {
        JCRTemplate.getInstance().doExecuteWithSystemSession(new JCRCallback() {
            @Override
            public Boolean doInJCR(final JCRSessionWrapper session) throws RepositoryException {
                final String query = "SELECT * FROM [jahtr:journalist_form]";
                final QueryManagerWrapper queryManager = session.getWorkspace().getQueryManager();
                final JCRNodeIteratorWrapper nodes = queryManager.createQuery(query, Query.JCR_SQL2).execute().getNodes();
                while (nodes.hasNext()) {
                    JCRNodeWrapper node = (JCRNodeWrapper) nodes.next();
                    System.out.println(node.getName());
                    boolean enabled = Boolean.valueOf(node.getPropertyAsString("enabled"));
                    if(!enabled){
                        node.remove();
                        session.save();
                    }
                }
                return true;
            }
        });
    }
}


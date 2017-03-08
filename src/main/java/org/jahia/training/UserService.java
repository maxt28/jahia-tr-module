package org.jahia.training;

import org.jahia.api.Constants;
import org.jahia.services.content.*;
import org.jahia.services.content.decorator.JCRUserNode;
import org.jahia.services.content.rules.AddedNodeFact;
import org.jahia.services.content.rules.ChangedPropertyFact;
import org.jahia.services.content.rules.PublishedNodeFact;
import org.jahia.services.content.rules.DeletedNodeFact;
import org.jahia.services.usermanager.JahiaUserManagerService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.query.Query;
import java.util.*;

import org.jahia.services.content.JCRPublicationService;

public class UserService {


    private final List<String> properties = new ArrayList<>(Arrays.asList("title", "academicTitle",
            "name", "surname", "address", "npa", "place", "numPhone", "numCellphone", "email", "password" , "enabled"));

    @Autowired
    private JahiaUserManagerService jahiaUserManagerService;


    public void createUser(final JCRNodeWrapper node) throws RepositoryException {
        final String name = node.getName();
        final String password = node.getPropertyAsString("password");
        final Properties userProps = new Properties();
        for (final String property : properties) {
            String value = node.getPropertyAsString(property);
            if(value == null){
                value = "";
            }
            userProps.put(property, value);
        }
        if (JCRSessionFactory.getInstance().getCurrentUser() == null) {
            JCRSessionFactory.getInstance().setCurrentUser(JahiaUserManagerService.getInstance()
                    .lookupRootUser().getJahiaUser());
        }
        JCRTemplate.getInstance().doExecuteWithSystemSession(new JCRCallback() {
            @Override
            public Boolean doInJCR(final JCRSessionWrapper session) throws RepositoryException {
                final JCRUserNode user = jahiaUserManagerService.createUser(name, password, userProps, session);
                node.setProperty("relatedUser", user);
                session.save();
                publish(user);
                publish(node.getIdentifier());
                session.save();
                return true;
            }
        });

    }
    public void deleteUser(final PublishedNodeFact node) throws RepositoryException {
        deleteUser(node.getName(), node.getIdentifier());
    }

    public void deleteUser(final DeletedNodeFact node) throws RepositoryException {
        deleteUser(node.getName(), node.getIdentifier());
    }

    public void deleteUser(final String name, final String id) throws RepositoryException {
        JCRTemplate.getInstance().doExecuteWithSystemSession(new JCRCallback() {
            @Override
            public Boolean doInJCR(final JCRSessionWrapper session) throws RepositoryException {
                JCRUserNode user = getUserByName(name, session);
                jahiaUserManagerService.deleteUser(user.getPath(), session);
                session.save();
                return true;
            }
        });
    }


    public JCRUserNode getUserByName(String name, JCRSessionWrapper session) throws RepositoryException {
        final String query = "SELECT * FROM [jnt:user] WHERE [j:nodename]='" + name + "'";
        final QueryManagerWrapper queryManager = session.getWorkspace().getQueryManager();
        final JCRNodeIteratorWrapper nodes = queryManager.createQuery(query, Query.JCR_SQL2).execute().getNodes();
        if (nodes.hasNext()) {
            JCRUserNode user = (JCRUserNode) nodes.next();
            return user;
        }
        return null;
    }

    public void updateUser(final ChangedPropertyFact property, final AddedNodeFact node) throws RepositoryException {
        property.getStringValue();
        property.getName();
        JCRTemplate.getInstance().doExecuteWithSystemSession(new JCRCallback() {
            @Override
            public Boolean doInJCR(final JCRSessionWrapper session) throws RepositoryException {
                JCRUserNode user = getUserByName(node.getName(), session);
                user.setProperty(property.getName() ,property.getStringValue());
                if (user != null) {
                    publish(user);
                }
                if (node != null) {
                    publish(node.getNode());
                }
                session.save();
                return true;
            }
        });
    }

    public void publish(final Node node) throws RepositoryException {
        publish(node.getIdentifier());
    }

    public void publish(final String nodeUUID) throws RepositoryException {
        JCRPublicationService.getInstance().publishByMainId(nodeUUID,
                Constants.EDIT_WORKSPACE,
                Constants.LIVE_WORKSPACE,
                null,
                true,
                Collections.singletonList("") );
    }

    public void setJahiaUserManagerService(JahiaUserManagerService jahiaUserManagerService) {
        this.jahiaUserManagerService = jahiaUserManagerService;
    }
}

//
//  SampleData.swift
//  Example
//
//  Created by Nathan Tannar on 2/6/18.
//  Copyright © 2018 Nathan Tannar. All rights reserved.
//

import UIKit

class SampleData {
    
    class Conversation {
        
        let title: String
        
        var messages: [Message]
        
        var users: [User]
        
        var lastMessage: Message? { return messages.last }
        
        init(users: [User], messages: [Message]) {
            self.users = users
            self.messages = messages
            self.title = Lorem.words(nbWords: 4).capitalized
        }
    }
    
    class Message {
        
        let text: String
        let user: User
        
        init(user: User, text: String) {
            self.user = user
            self.text = text
        }
    }
    
    class User {
        
        let id: String = UUID().uuidString
        let image: UIImage
        let name: String
        
        init(name: String, image: UIImage) {
            self.image = image
            self.name = name
        }
    }
    
    static var shared = SampleData()
    
    let users = [User(name: "Avatar", image: #imageLiteral(resourceName: "avatar")), User(name: "Ninja", image: #imageLiteral(resourceName: "ninja")), User(name: "Anonymous", image: #imageLiteral(resourceName: "anonymous")), User(name: "Rick Sanchez", image: #imageLiteral(resourceName: "rick")), User(name: "Nathan Tannar", image: #imageLiteral(resourceName: "nathan"))]
    
    var currentUser: User { return users.last! }
    
    private init() {}
    
    func getConversations(count: Int) -> [Conversation] {
        
        var conversations = [Conversation]()
        for _ in 0..<count {
            
            var messages = [Message]()
            for i in 0..<30 {
                let user = users[i % users.count]
                if i % 2 == 0 {
                    let message = Message(user: user, text: Lorem.sentence())
                    messages.append(message)
                } else {
                    let message = Message(user: user, text: Lorem.paragraph())
                    messages.append(message)
                }
            }
            let newConversation = Conversation(users: users, messages: messages)
            conversations.append(newConversation)
        }
        return conversations
    }
}

import InputBarAccessoryView

  // MARK: - Mock Data
extension AutocompleteEntitySuggestion {
  public static let salesforceTopicsMockData: [AutocompleteEntitySuggestion] = [
    AutocompleteEntitySuggestion(
      id: "apex-development",
      type: .topic,
      name: "This is a very long topic name to test the word wrapping functionality",
      description: "Server-side programming language for Salesforce platform",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "lightning-web-components",
      type: .topic,
      name: "This is a very long topic name to test the word wrapping functionality",
      description: nil,
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "salesforce-flow",
      type: .topic,
      name: "Salesforce Flow",
      description: "Automate business processes with declarative tools",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "soql-sosl",
      type: .topic,
      name: "SOQL & SOSL",
      description: "Salesforce Object Query Language and Search Language",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "trigger-development",
      type: .topic,
      name: "Trigger Development",
      description: "Apex code that executes before or after DML operations",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "custom-objects",
      type: .topic,
      name: "Custom Objects",
      description: "Creating and managing custom database tables",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "workflow-rules",
      type: .topic,
      name: "Workflow Rules",
      description: "Automated actions based on field updates",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "validation-rules",
      type: .topic,
      name: "Validation Rules",
      description: "Data quality enforcement at record level",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "permission-sets",
      type: .topic,
      name: "Permission Sets",
      description: "Extend user permissions beyond profiles",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "data-loader",
      type: .topic,
      name: "Data Loader",
      description: "Bulk import and export of Salesforce data",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "lightning-experience",
      type: .topic,
      name: "Lightning Experience",
      description: "Modern Salesforce user interface",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "communities-cloud",
      type: .topic,
      name: "Communities Cloud",
      description: "Build branded spaces for customers and partners",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "marketing-cloud",
      type: .topic,
      name: "Marketing Cloud",
      description: "Digital marketing automation and analytics",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "service-cloud",
      type: .topic,
      name: "Service Cloud",
      description: "Customer service and support platform",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "sales-cloud",
      type: .topic,
      name: "Sales Cloud",
      description: "Sales force automation and CRM",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "integration-apis",
      type: .topic,
      name: "Integration & APIs",
      description: "Connect Salesforce with external systems",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "report-dashboards",
      type: .topic,
      name: "Reports & Dashboards",
      description: "Data visualization and business intelligence",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "mobile-development",
      type: .topic,
      name: "Mobile Development",
      description: "Salesforce mobile app development",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "cpq-configuration",
      type: .topic,
      name: "CPQ Configuration",
      description: "Configure, Price, Quote automation",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "field-service",
      type: .topic,
      name: "Field Service",
      description: "Mobile workforce management and scheduling",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "commerce-cloud",
      type: .topic,
      name: "Commerce Cloud",
      description: "E-commerce platform and solutions",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "einstein-analytics",
      type: .topic,
      name: "Einstein Analytics",
      description: "AI-powered business intelligence platform",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "pardot-marketing",
      type: .topic,
      name: "Pardot Marketing",
      description: "B2B marketing automation platform",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "community-management",
      type: .topic,
      name: "Community Management",
      description: "Managing and moderating online communities",
      photoUrl: nil
    ),
    AutocompleteEntitySuggestion(
      id: "trailhead-learning",
      type: .topic,
      name: "Trailhead Learning",
      description: "Salesforce's free online learning platform",
      photoUrl: nil
    )
  ]
}

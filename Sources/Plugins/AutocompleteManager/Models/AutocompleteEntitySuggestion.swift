//
//  AutocompleteEntitySuggestion.swift
//  InputBarAccessoryView
//
//  Created by Yuchen Nie on 10/29/25.
//

import Foundation

public struct AutocompleteEntitySuggestion: Hashable {
  let id: String
  let type: EntitySuggestionType
  let name: String
  var description: String?
  let photoUrl: String?
  var privateGroup = false
  
  public init(
    id: String,
    type: EntitySuggestionType,
    name: String,
    description: String? = nil,
    photoUrl: String?,
    privateGroup: Bool = false
  ) {
    self.id = id
    self.type = type
    self.name = name
    self.description = description
    self.photoUrl = photoUrl
    self.privateGroup = privateGroup
  }
  
  public var autoCompletion: AutocompleteCompletion {
    let value = type == .topic ? name : id
    let context: [String: Any] = [
      CommunityEntitySuggestionContext.value.rawValue: value,
      CommunityEntitySuggestionContext.type.rawValue: type.rawValue,
    ]
    return AutocompleteCompletion(text: name, context: context)
  }
  
  public enum EntitySuggestionType: String {
    case topic = "TOPIC"
    case user = "USER"
    case group = "GROUP"
    case mention = "MENTION"
  }
  
  public enum CommunityEntitySuggestionContext: String {
    case type
    case value
  }
}

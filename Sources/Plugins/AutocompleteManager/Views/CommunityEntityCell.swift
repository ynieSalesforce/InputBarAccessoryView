//
//  CommunityEntityCell.swift
//  InputBarAccessoryView
//
//  Created by Yuchen Nie on 10/28/25.
//

import Foundation
import UIKit
import SnapKit

open class AutocompleteSuggestionEntityCell: UITableViewCell {
  static let autoCompleteAvatarSize: CGFloat = 32
  static let actionIconSize: CGFloat = autoCompleteAvatarSize / 2
  private var suggestion: AutocompleteEntitySuggestion?
  
  public static var reuseIdentifier: String {
    String(describing: AutocompleteSuggestionEntityCell.self)
  }
  
  fileprivate lazy var iconImageContainer: UIView = {
    let view = UIView()
    view.layer.cornerRadius = AutocompleteSuggestionEntityCell.autoCompleteAvatarSize / 2
    view.clipsToBounds = true
    contentView.addSubview(view)
    return view
  }()
  
  fileprivate lazy var iconImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    iconImageContainer.addSubview(imageView)
    return imageView
  }()
  
  fileprivate lazy var textContainer: UIView = {
    let view = UIView()
    contentView.addSubview(view)
    return view
  }()
  
  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = .label
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    textContainer.addSubview(label)
    return label
  }()
  
  fileprivate lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.textColor = .secondaryLabel
    label.numberOfLines = 0
    textContainer.addSubview(label)
    return label
  }()
  
  public func configure(suggestion: AutocompleteEntitySuggestion) {
    titleLabel.text = suggestion.name
    subtitleLabel.text = suggestion.description
    self.suggestion = suggestion
    
    switch suggestion.type {
    case .user:
      setAvatarImage()
    default:
      setTopicIconImage()
    }
    
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  public func configure(title: String) {
    titleLabel.text = title
    subtitleLabel.text = nil
    suggestion = nil
    
    setTopicIconImage()
    
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  private func setAvatarImage() {
      // Handles user case
    iconImage.image = UIImage.init(named: "AstroAvatar")
    iconImage.tintColor = .systemBackground
    iconImageContainer.backgroundColor = .systemBackground
  }
  
  private func setTopicIconImage() {
      // Handles topic case
    iconImage.image = .imageWithPointSize(
      systemName: "number",
      pointSize: AutocompleteSuggestionEntityCell.actionIconSize
    )
    
    iconImage.tintColor = .white
    iconImageContainer.backgroundColor = .systemBlue
  }
  
  open override func updateConstraints() {
    contentView.backgroundColor = .systemBackground
    
    iconImageContainer.snp.updateConstraints { make in
      make.height.width.equalTo(AutocompleteSuggestionEntityCell.autoCompleteAvatarSize).priority(.high)
      make.centerY.equalTo(contentView)
      make.leading.equalTo(contentView).offset(16)
    }
    
    iconImage.snp.updateConstraints { make in
      make.center.equalTo(iconImageContainer)
      if let suggestion = suggestion, suggestion.type == .user {
        make.height.width.equalTo(AutocompleteSuggestionEntityCell.autoCompleteAvatarSize)
      } else {
        make.height.width.equalTo(AutocompleteSuggestionEntityCell.actionIconSize)
      }
    }
    
    textContainer.snp.updateConstraints { make in
      make.leading.equalTo(iconImageContainer.snp.trailing).offset(16).priority(.high)
      make.trailing.equalTo(contentView).inset(16)
      make.top.equalTo(contentView).offset(8)
      make.bottom.equalTo(contentView).inset(8)
      make.height.greaterThanOrEqualTo(AutocompleteSuggestionEntityCell.autoCompleteAvatarSize).priority(.high)
    }
    
    titleLabel.snp.remakeConstraints { make in
      make.leading.equalTo(textContainer)
      make.trailing.equalTo(textContainer).inset(2)
      if let subtitleText = subtitleLabel.text,
          !subtitleText.isEmpty {
        make.top.equalTo(textContainer)
      } else {
        make.top.equalTo(textContainer)
        make.bottom.equalTo(textContainer)
        make.centerY.equalTo(textContainer)
      }
    }
    
    subtitleLabel.snp.remakeConstraints { make in
      make.leading.equalTo(textContainer)
      make.trailing.equalTo(textContainer)
      if let subtitleText = subtitleLabel.text,
         !subtitleText.isEmpty {
        make.top.equalTo(titleLabel.snp.bottom).offset(4)
        make.bottom.equalTo(textContainer)
      } else {
        make.centerY.equalTo(textContainer)
      }
    }
    super.updateConstraints()
  }
}

fileprivate extension UIImage {
  static func imageWithPointSize(systemName: String, pointSize: CGFloat) -> UIImage? {
    let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize)
    return UIImage(systemName: systemName, withConfiguration: symbolConfiguration)
  }
}

fileprivate class ImageLoader {
  fileprivate func loadImage(from url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data) else {
      throw ImageLoadingError.invalidImageData
    }
    return image
  }
  
  fileprivate enum ImageLoadingError: Error {
    case invalidImageData
  }
}

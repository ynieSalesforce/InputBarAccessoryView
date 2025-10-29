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
  private let imageLoader: ImageLoader = .init()
  
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
  
  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = .label
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    contentView.addSubview(label)
    return label
  }()
  
  fileprivate lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.textColor = .secondaryLabel
    label.numberOfLines = 0
    contentView.addSubview(label)
    return label
  }()
  
  public func configure(suggestion: AutocompleteEntitySuggestion) {
    titleLabel.text = suggestion.name
    subtitleLabel.text = suggestion.description
    self.suggestion = suggestion
    
    switch suggestion.type {
    case .user:
      setAvatarImage(from: suggestion.photoUrl)
    default:
      setTopicIconImage()
    }
    
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  public func configure(title: String, type: AutocompleteEntitySuggestion.EntitySuggestionType = .topic) {
    titleLabel.text = title
    subtitleLabel.text = nil
    suggestion = nil
    
    switch type {
    case .user:
      setAvatarImage()
    default:
      setTopicIconImage()
    }
    
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  private func setAvatarImage(from imageURL: String? = nil) {
      // Handles user case
    iconImage.image = imageLoader.loadImageFromPackage(named: "AstroAvatar")
    iconImage.tintColor = .systemBackground
    iconImageContainer.backgroundColor = .systemBackground
    guard let urlString = imageURL, let imageUrl = URL(string: urlString) else { return }
    Task {
      do {
        let image = try await imageLoader.loadImage(from: imageUrl)
        DispatchQueue.main.async {
          self.iconImage.image = image
        }
      }
    }
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
    
    titleLabel.snp.remakeConstraints { make in
      make.leading.equalTo(iconImageContainer.snp.trailing).offset(16).priority(.required)
      make.trailing.equalTo(contentView).inset(16)
      if let subtitleText = subtitleLabel.text,
         !subtitleText.isEmpty {
        make.top.equalTo(contentView).offset(8)
      } else {
        make.top.equalTo(contentView).offset(8)
        make.bottom.equalTo(contentView).inset(8)
        make.height.greaterThanOrEqualTo(AutocompleteSuggestionEntityCell.autoCompleteAvatarSize)
      }
    }
    
    subtitleLabel.snp.remakeConstraints { make in
      if let subtitleText = subtitleLabel.text,
         !subtitleText.isEmpty {
        make.leading.equalTo(iconImageContainer.snp.trailing).offset(16).priority(.required)
        make.trailing.equalTo(contentView).inset(16)
        make.top.equalTo(titleLabel.snp.bottom).offset(4).priority(.required)
        make.bottom.equalTo(contentView).inset(8)
      } else {
        make.centerY.equalTo(contentView)
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
  
  fileprivate func loadImageFromPackage(named name: String) -> UIImage? {
    return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
  }
}

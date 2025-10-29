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
  static let actionIconSize: CGFloat = 22
  
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
 
  public func configure(title: String, subtitle: String) {
    contentView.backgroundColor = .systemBackground
    titleLabel.text = title
    subtitleLabel.text = subtitle
    
    // Handles topic case
    iconImage.image = .imageWithPointSize(
      systemName: "number",
      pointSize: AutocompleteSuggestionEntityCell.actionIconSize
    )
    
    iconImage.tintColor = .white
    iconImageContainer.backgroundColor = .systemBlue
    
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  open override func updateConstraints() {
    iconImageContainer.snp.updateConstraints { make in
      make.height.width.equalTo(AutocompleteSuggestionEntityCell.autoCompleteAvatarSize)
      make.centerY.equalTo(contentView)
      make.leading.equalTo(contentView).offset(16)
    }
    
    iconImage.snp.updateConstraints { make in
      make.center.equalTo(iconImageContainer)
    }
    
    titleLabel.snp.updateConstraints { make in
      make.leading.equalTo(iconImageContainer.snp.trailing).offset(16)
      make.top.equalTo(contentView).offset(8)
      make.trailing.equalTo(contentView).inset(16)
    }
    
    subtitleLabel.snp.updateConstraints { make in
      make.leading.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.trailing.equalTo(titleLabel)
      make.bottom.equalTo(contentView).inset(8)
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

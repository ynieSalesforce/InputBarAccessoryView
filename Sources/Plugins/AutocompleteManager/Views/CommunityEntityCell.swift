//
//  CommunityEntityCell.swift
//  InputBarAccessoryView
//
//  Created by Yuchen Nie on 10/28/25.
//

import Foundation
import UIKit
import SnapKit

open class CommunityEntityCell: UITableViewCell {
  static var reuseIdentifier: String {
    String(describing: CommunityEntityCell.self)
  }
  
  fileprivate lazy var iconImage: UIImageView = {
    let image = UIImage(systemName: "number")
    let imageView = UIImageView(image: image)
    imageView.tintColor = .systemGray2
    imageView.contentMode = .scaleAspectFit
    contentView.addSubview(imageView)
    return imageView
  }()
  
  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.numberOfLines = 0
    contentView.addSubview(titleLabel)
    return label
  }()
  
  fileprivate lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.numberOfLines = 0
    contentView.addSubview(subtitleLabel)
    return label
  }()
 
  func configure(title: String, subtitle: String) {
    titleLabel.text = title
    subtitleLabel.text = subtitle
    
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  open override func updateConstraints() {
    iconImage.snp.updateConstraints { make in
      make.height.width.equalTo(24)
      make.top.equalTo(contentView).offset(16)
      make.leading.equalTo(contentView).offset(16)
    }
    
    titleLabel.snp.updateConstraints { make in
      make.leading.equalTo(iconImage.snp.trailing).offset(16)
      make.top.equalTo(iconImage)
      make.trailing.equalTo(contentView).inset(16)
    }
    
    subtitleLabel.snp.updateConstraints { make in
      make.leading.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.trailing.equalTo(titleLabel)
      make.bottom.equalTo(contentView).inset(16)
    }
    super.updateConstraints()
  }
  
}

//
//  WarmupCell.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import UIKit

final class WarmupCell: UICollectionViewCell {
  // MARK: - Variables
  
  var serverInfo: Server? {
    didSet {
      configure()
    }
  }
  
  private lazy var backgroundImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isAccessibilityElement = false
    imageView.alpha = 0.7
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    label.textColor = .black
    label.numberOfLines = 2
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 10
    return stackView
  }()
  
  // MARK: - Constructor
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetupViews and Constraints
  
  private func setupViews() {
    backgroundColor = .clear
    addSubview(backgroundImage)
    addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    backgroundImage.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(22)
      make.leading.trailing.equalToSuperview().inset(8)
    }
  }
  
  // MARK: - Configure
  
  private func configure() {
    titleLabel.text = serverInfo?.name
    backgroundImage.setImage(url: serverInfo?.mapImage)
  }
}

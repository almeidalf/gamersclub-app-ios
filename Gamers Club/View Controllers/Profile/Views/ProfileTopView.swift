//
//  PerfilView.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 02/04/22.
//

import UIKit
import SnapKit

final class ProfileTopView: UIView {
  // MARK: - Variables
  
  var profileData: UserMe? {
    didSet {
      configure()
    }
  }
  
  private lazy var content = UIView()
  
  private lazy var backgroundProfile: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isAccessibilityElement = false
    return imageView
  }()
  
  private lazy var profileImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isAccessibilityElement = false
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 50
    return imageView
  }()
  
  private lazy var stackProfileView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.alignment = .fill
    stackView.spacing = 10
    return stackView
  }()
  
  private lazy var profileNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
  }()
  
  private lazy var gcIdLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
  }()
  
  private lazy var stackHorizontalView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.alignment = .fill
    stackView.spacing = 10
    return stackView
  }()
  
  private lazy var gcLevelLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
  }()
  
  // MARK: - Constructor
  
  init() {
    super.init(frame: .zero)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetupViews
  
  private func setupViews() {
    addSubview(content)
    content.addSubview(backgroundProfile)
    backgroundProfile.addSubview(profileImage)
    content.addSubview(stackProfileView)
    stackProfileView.addArrangedSubview(profileNameLabel)
    stackProfileView.addArrangedSubview(gcIdLabel)
    content.addSubview(stackHorizontalView)
    stackHorizontalView.addArrangedSubview(gcLevelLabel)
  }
  
  private func setupConstraints() {
    content.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    backgroundProfile.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalTo(100)
    }
    
    profileImage.snp.makeConstraints { make in
      make.centerX.equalTo(backgroundProfile.snp.centerX)
      make.bottom.equalTo(backgroundProfile.snp.bottom).offset(40)
      make.size.equalTo(100)
    }
    
    stackProfileView.snp.makeConstraints { make in
      make.top.equalTo(profileImage.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(50)
    }
    
    stackHorizontalView.snp.makeConstraints { make in
      make.top.equalTo(stackProfileView.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(30)
    }
  }
  
  // MARK: - Configure
  
  private func configure() {
    guard let id = profileData?.id else { return }
    backgroundProfile.setImage(url: profileData?.background, completeURL: true)
    profileImage.setImage(url: profileData?.avatar, completeURL: true)
    profileNameLabel.text = profileData?.nick
    gcIdLabel.text = "GC ID: \(id)"
    gcLevelLabel.text = profileData?.level?.description
  }
}


//
//  WarmupCell.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import UIKit

protocol WarmupDelegate: AnyObject {
  func sharedIPServer(_ ip: String)
}

final class WarmupCell: UICollectionViewCell {
  // MARK: - Variables
  
  weak var delegate: WarmupDelegate?
  
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
  
  private lazy var mapNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 30
    return stackView
  }()
  
  private(set) lazy var copyAddressButton: UIButton = {
    let button = UIButton()
    button.titleEdgeInsets.left = 8
    button.setImage(UIImage(named: "copy"), for: .normal)
    button.backgroundColor = .clear
    button.contentHorizontalAlignment = .center
    button.isAccessibilityElement = true
    return button
  }()
  
  private(set) lazy var shareButton: UIButton = {
    let button = UIButton()
    button.titleEdgeInsets.left = 8
    button.setImage(UIImage(named: "share"), for: .normal)
    button.backgroundColor = .clear
    button.contentHorizontalAlignment = .center
    button.isAccessibilityElement = true
    button.addTarget(self, action: #selector(sharedIP), for: .touchUpInside)
    return button
  }()
  
  private lazy var playersSlots = PlayersView()
  
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
    addSubview(mapNameLabel)
    addSubview(stackView)
    addSubview(playersSlots)
    stackView.addArrangedSubview(copyAddressButton)
    stackView.addArrangedSubview(shareButton)
  }
  
  private func setupConstraints() {
    backgroundImage.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(22)
      make.leading.trailing.equalToSuperview().inset(8)
    }
    
    mapNameLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview().inset(22)
    }
    
    stackView.snp.makeConstraints { make in
      make.trailing.bottom.equalToSuperview().inset(15)
      make.width.equalTo(75)
      make.height.equalTo(25)
    }
    
    playersSlots.snp.makeConstraints { make in
      make.leading.bottom.equalToSuperview().inset(15)
    }
  }
  
  // MARK: - Configure
  
  private func configure() {
    titleLabel.text = serverInfo?.name
    backgroundImage.setImage(url: serverInfo?.mapImage)
    playersSlots.playersOnlineLabel.text = serverInfo?.slotsUsed
    playersSlots.totalSlotsLabel.text = serverInfo?.slots
    mapNameLabel.text = serverInfo?.mapName
  }
  
  @objc private func sharedIP() {
    guard let serverIp = serverInfo?.ip, let port = serverInfo?.port else { return }
    let ip = "\(serverIp):\(port)"
    delegate?.sharedIPServer(ip)
  }
}

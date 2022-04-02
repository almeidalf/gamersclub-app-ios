//
//  PlayersView.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 31/03/22.
//

import UIKit

final class PlayersView: UIView {
  // MARK: - Variables
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.alignment = .fill
    stackView.spacing = 4
    return stackView
  }()
  
  private(set) lazy var playersOnlineLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
  }()
  
  private lazy var dividerLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.text = "/"
    label.accessibilityLabel = label.text
    return label
  }()
  
  private(set) lazy var totalSlotsLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .black
    label.numberOfLines = 1
    label.isAccessibilityElement = true
    label.accessibilityLabel = label.text
    return label
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
    backgroundColor = .white
    clipsToBounds = true
    layer.cornerRadius = 4
    addSubview(stackView)
    stackView.addArrangedSubview(playersOnlineLabel)
    stackView.addArrangedSubview(dividerLabel)
    stackView.addArrangedSubview(totalSlotsLabel)
  }
  
  private func setupConstraints() {
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

//
//  PlayNowView.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit
import SnapKit

final class HomeView: UIView {
  // MARK: - Variables
  
  private lazy var content = UIView()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 30
    return stackView
  }()
  
  private(set) lazy var lobbyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Lobby - Em construção!", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .systemYellow
    return button
  }()
  
  private(set) lazy var oneOnOneButton: UIButton = {
    let button = UIButton()
    button.setTitle("Desafio 1X1 - Em construção!", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .systemGreen
    return button
  }()
  
  private(set) lazy var warmupButton: UIButton = {
    let button = UIButton()
    button.setTitle("WARMUP", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .systemRed
    return button
  }()
  
  private(set) lazy var forFunButton: UIButton = {
    let button = UIButton()
    button.setTitle("4FUN - Em Construção!", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .systemBlue
    return button
  }()
  
  private(set) lazy var rankedButton: UIButton = {
    let button = UIButton()
    button.setTitle("Ranked - Em Construção!", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .systemOrange
    return button
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
    content.addSubview(stackView)
    stackView.addArrangedSubview(lobbyButton)
    stackView.addArrangedSubview(oneOnOneButton)
    stackView.addArrangedSubview(warmupButton)
    stackView.addArrangedSubview(forFunButton)
    stackView.addArrangedSubview(rankedButton)
  }
  
  private func setupConstraints() {
    content.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    stackView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }
}

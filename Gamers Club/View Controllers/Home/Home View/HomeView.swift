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
  
  private(set) lazy var warmupButton: UIButton = {
    let button = UIButton()
    button.setTitle("WARMUP", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .brown
    return button
  }()
  
  private(set) lazy var forFunButton: UIButton = {
    let button = UIButton()
    button.setTitle("4FUN", for: .normal)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    button.backgroundColor = .brown
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
    content.addSubview(warmupButton)
    content.addSubview(forFunButton)
  }
  
  private func setupConstraints() {
    content.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    warmupButton.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(45)
    }
    
    forFunButton.snp.makeConstraints { make in
      make.top.equalTo(warmupButton.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(45)
    }
  }
}

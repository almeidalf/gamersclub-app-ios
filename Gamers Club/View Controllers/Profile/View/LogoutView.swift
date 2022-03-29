//
//  LogoutView.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit
import SnapKit

final class LogoutView: UIView {
  // MARK: - Variables
  
  private lazy var content = UIView()
  
  private(set) lazy var logoutButton: UIButton = {
    let button = UIButton()
    button.setTitle("Logout", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = .black
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
    content.addSubview(logoutButton)
  }
  
  private func setupConstraints() {
    content.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    logoutButton.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(45)
    }
  }
}

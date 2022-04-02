//
//  ViewController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 08/03/22.
//

import UIKit
import WebKit
import SnapKit

class HomeWebview: UIViewController {
  // MARK: - Variables
  
  weak var coordinator: WebViewSteamCoordinator?
  private let urlGC = URL(string: "https://gamersclub.com.br")!
  private let urlSteam = URL(string: "https://steamcommunity.com/openid/login?openid.ns=http://specs.openid.net/auth/2.0&openid.mode=checkid_setup&openid.return_to=https://gamersclub.com.br/auth/callback?redirect=/&openid.realm=https://gamersclub.com.br/&openid.identity=http://specs.openid.net/auth/2.0/identifier_select&openid.claimed_id=http://specs.openid.net/auth/2.0/identifier_select")!
  
  private(set) lazy var homeView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private lazy var webView: WKWebView = {
    let web = WKWebView()
    return web
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.isHidden = true
    activityIndicator.color = .gray
    activityIndicator.backgroundColor = .clear
    activityIndicator.style = .whiteLarge
    return activityIndicator
  }()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar(withBackButton: false)
    setupViews()
    webView.load(URLRequest(url: urlSteam))
    webView.uiDelegate = self
    webView.navigationDelegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func setupViews() {
    title = "Login GC pela STEAM"
    view.addSubview(homeView)
    homeView.addSubview(webView)
    homeView.addSubview(activityIndicator)
    
    homeView.snp.makeConstraints { $0.edges.equalToSuperview() }
    webView.snp.makeConstraints { $0.edges.equalToSuperview() }
    activityIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func showActivityIndicator() {
    UIView.animate(withDuration: 0.2) {
      self.activityIndicator.isHidden = false
      self.activityIndicator.alpha = 1
      self.activityIndicator.startAnimating()
    }
  }
  
  func hideActivityIndicator() {
    UIView.animate(withDuration: 0.2) {
      self.activityIndicator.isHidden = true
      self.activityIndicator.alpha = 0
      self.activityIndicator.stopAnimating()
    }
  }
}

extension HomeWebview: WKUIDelegate, WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //load cookie of current domain
    webView.loadDiskCookies(for: urlGC.host!){
      decisionHandler(.allow)
    }
  }
  
  public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    //write cookie for current domain
    webView.writeDiskCookies(for: urlGC.host!){
      self.showActivityIndicator()
      decisionHandler(.allow)
    }
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    let script = "localStorage.getItem(\"ws-gc\")"
    webView.evaluateJavaScript(script) { (token, error) in
      if let error = error {
        print ("Não conseguimos salvar seu token no device \(error)")
        assertionFailure()
      }
      
      guard let value = token as? String else { return self.hideActivityIndicator() }
      let json = Data(value.utf8)
      let sessionUser = try? JSONDecoder().decode(SessionToken.self, from: json)
      Cache.profileSession = sessionUser
      if sessionUser != nil {
        self.hideActivityIndicator()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
          NotificationCenter.default.post(name: .refresh, object: false)
          self.coordinator?.goToHome()
        }
      }
    }
  }
}


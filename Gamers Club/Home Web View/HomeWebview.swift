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
  private let url = URL(string: "https://gamersclub.com.br")!
  
  private(set) lazy var homeView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private lazy var webView: WKWebView = {
    let web = WKWebView()
    return web
  }()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar(withBackButton: false)
    setupViews()
    webView.load(URLRequest(url: url))
    webView.uiDelegate = self
    webView.navigationDelegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func setupViews() {
    view.addSubview(homeView)
    homeView.addSubview(webView)
    
    homeView.snp.makeConstraints { $0.edges.equalToSuperview() }
    webView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}

extension HomeWebview: WKUIDelegate, WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //load cookie of current domain
    webView.loadDiskCookies(for: url.host!){
      decisionHandler(.allow)
    }
  }
  
  public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    //write cookie for current domain
    webView.writeDiskCookies(for: url.host!){
      decisionHandler(.allow)
    }
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    let script = "localStorage.getItem(\"ws-gc\")"
    webView.evaluateJavaScript(script) { (token, error) in
      if let tokenSession = token {
        UserDefaults.standard.setValue(tokenSession, forKey: Constants.sessionToken)
      }
      
      if let error = error {
        print ("Não conseguimos salvar seu token no device \(error)")
        assertionFailure()
      }
    }
  }
}


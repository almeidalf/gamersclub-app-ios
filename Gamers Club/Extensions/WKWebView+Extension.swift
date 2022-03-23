//
//  WKWebView+Extension.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 08/03/22.
//

import WebKit

extension WKWebView {
  
  func writeDiskCookies(for domain: String, completion: @escaping () -> ()) {
    fetchInMemoryCookies(for: domain) { data in
      UserDefaults.standard.setValue(data, forKey: Constants.cookie + domain)
      completion();
    }
  }
  
  
  func loadDiskCookies(for domain: String, completion: @escaping () -> ()) {
    if let diskCookie = UserDefaults.standard.dictionary(forKey: (Constants.cookie + domain)){
      fetchInMemoryCookies(for: domain) { freshCookie in
        
        let mergedCookie = diskCookie.merging(freshCookie) { (_, new) in new }
        
        for (cookieName, cookieConfig) in mergedCookie {
          let cookie = cookieConfig as! Dictionary<String, Any>
          
          if cookieName == "gclubsess" {
            if let gclubsess = cookie["Value"] as? String {
              UserDefaults.standard.setValue(gclubsess, forKey: Constants.gclubsess_SESSION)
            }
          }
        }
        
        completion()
      }
      
    }
    else{
      completion()
    }
  }
  
  func fetchInMemoryCookies(for domain: String, completion: @escaping ([String: Any]) -> ()) {
    var cookieDict = [String: AnyObject]()
    WKWebsiteDataStore.default().httpCookieStore.getAllCookies { (cookies) in
      for cookie in cookies {
        if cookie.domain.contains(domain) {
          cookieDict[cookie.name] = cookie.properties as AnyObject?
        }
      }
      completion(cookieDict)
    }
  }}

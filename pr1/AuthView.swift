//
//  ViewController.swift
//  pr1
//
//  Created by Никита Попов on 30.01.24.
//

import UIKit
import WebKit
import AuthenticationServices

class AuthView: UIViewController {
    static var appId = "51852733"
    var loginButton: UIButton!
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWebView()
        if let url = self.createURL(){
            webView.load(URLRequest(url: url))
        }
    }
    //MARK: - webview add
    private func addWebView(){
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        webView.navigationDelegate = self
        
    }
    
    private func authDone(_ userInfo: CurrentUser){
        let vc = CustomTabBar(currentUser: userInfo)
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
}


extension AuthView: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html" else {
            decisionHandler(.allow)
            return
        }
        
        let fr = url.fragment()
        if let param = fr?.components(separatedBy: "&"){
            let tokenAndID = param.filter{["access_token", "user_id"].contains($0.components(separatedBy: "=").first ?? "")}
            
            let token = tokenAndID.filter{$0.components(separatedBy: "=").first ?? "" == "access_token"}.first?.components(separatedBy: "=").last ?? ""
            print("TOKEN---\(token)")
            let id  = tokenAndID.filter{$0.components(separatedBy: "=").first ?? "" == "user_id"}.first?.components(separatedBy: "=").last ?? ""
            print("ID---\(id)")
            

            let currentUser = CurrentUser(token: token, id: id)
            authDone(currentUser)
        }
        
        decisionHandler(.cancel)
        webView.removeFromSuperview()
    }
    
    private func createURL()-> URL?{
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: "\(AuthView.appId)"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "page"),
            URLQueryItem(name: "scope", value: "friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        guard let url = urlComp.url else { return nil }
        return url
    }
    
}


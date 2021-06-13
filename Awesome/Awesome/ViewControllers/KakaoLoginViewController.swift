//
//  KakaoLoginViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/13.
//
protocol loginURLProtocol {
    func setURL(loginURL : String)
}

import UIKit
import WebKit
class KakaoLoginViewController: UIViewController {
    var webView: WKWebView!
    var loginURL : String = ""
    var delegate : loginURLProtocol?

        override func loadView() {
            super.loadView()
            webView = WKWebView(frame: self.view.frame)
            self.view = self.webView!
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            webview()
        }
    
    
    
    func webview(){
        let sURL = "https://api.wouldyou.in/user/kakao/login"
        let uURL = URL(string: sURL)
        let request = URLRequest(url: uURL!)
        webView.load(request)
        self.webView.navigationDelegate = self

    }
    func ifLoginSuccess() {
        GetKakaoLoginDataService.KakaoLoginData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData):
                if let data = loginData as? [KakaoLoginDataModel] {
                    self.dismiss(animated: true, completion: nil)
                }
            case .requestErr(let message) :
                print("requestERR",message)
            case .pathErr :
                print("pathERR")
            case .serverErr:
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
extension KakaoLoginViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("page finished load")
        loginURL = webView.url?.absoluteString ?? ""
        Constants.LoginURL = loginURL
        ifLoginSuccess()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("page start load")
    }
}

//
//  KakaoLoginViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/13.
//
import UIKit
import WebKit

class KakaoLoginViewController: UIViewController {
    var webView: WKWebView!
    var loginURL : String = ""
    var delegate : isLogin?

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
    func notRedirect(){
        print(Constants.LoginURL)
    }
    
    func ifLoginSuccess() {
        delegate?.isLogin(data: true)
        self.dismiss(animated: true, completion: nil
        )
        
    }
    
    
    
}
extension KakaoLoginViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        let urlString = webView.url?.absoluteString
        Constants.LoginURL = urlString!
        GetKakaoLoginDataService.KakaoLoginData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData):
                self.ifLoginSuccess()
            case .requestErr(let message) :
                print("requestERR")
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

    


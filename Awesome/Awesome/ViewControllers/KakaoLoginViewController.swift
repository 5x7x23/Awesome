//
//  KakaoLoginViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/13.
//
import UIKit
import WebKit

protocol kakaoLogin {
    func kakaoLoginOn(data : Bool)
}

class KakaoLoginViewController: UIViewController {
  
    
    var webView: WKWebView!
    var loginURL : String = ""
    var delegate : kakaoLogin?

        override func loadView() {
            super.loadView()
            webView = WKWebView(frame: self.view.frame)
            self.view = self.webView!
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            webview()
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("카카오 뷰 사라짐")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("카카오 뷰 완전 사라짐")
        guard let presentVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
        presentVC.isLogin(data: true)
    }
    
    func webview(){
        let sURL = Constants.LoginURL
        let uURL = URL(string: sURL)
        let request = URLRequest(url: uURL!)
        webView.load(request)
        self.webView.navigationDelegate = self
    }
    
    func ifLoginSuccess() {
        self.navigationController?.popViewController(animated: true)
        delegate?.kakaoLoginOn(data: true)
    }
    
    func setData(){
        GetKakaoLoginDataService.KakaoLoginData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData) :
                self.ifLoginSuccess()
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "loginSecond")
                defaults.set(loginData, forKey: "userToken")
                self.setAccessToken()
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
    
    func setAccessToken(){
        GetKakaoLoginTokenService.KakaoLoginToken.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData) :
                let defaults = UserDefaults.standard
                defaults.set(loginData , forKey: "accessToken")
                print("엑세스 토큰입니다." , defaults.string(forKey: "accessToken"))
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
extension KakaoLoginViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let urlString = webView.url?.absoluteString
        Constants.LoginURL = urlString!
        setData()
    }
}

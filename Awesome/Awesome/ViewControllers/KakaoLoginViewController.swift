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
    var stopLoading : Bool = false

        override func loadView() {
            super.loadView()
            webView = WKWebView(frame: self.view.frame)
            self.view = self.webView!
            if stopLoading == true{
                return
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            webview()
        }
    override func viewWillDisappear(_ animated: Bool) {
        print("카카오 뷰 사라짐")
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
        loginVC.isLogin(data: true)
    }
    func webview(){
        let sURL = Constants.LoginURL
        let uURL = URL(string: sURL)
        let request = URLRequest(url: uURL!)
        webView.load(request)
        self.webView.navigationDelegate = self
        if stopLoading == true{
            webView.stopLoading()
            print("stop")
        }
    }
    func ifLoginSuccess() {
        stopLoading = true
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        LoginViewController.topViewController()
    }
    func setData(){
        GetKakaoLoginDataService.KakaoLoginData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData) :
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
extension KakaoLoginViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let urlString = webView.url?.absoluteString
        Constants.LoginURL = urlString!
        setData()
    }
}

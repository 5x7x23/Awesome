//
//  GetKakaoLoginDataService.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/13.
//

import Foundation
import Alamofire




struct GetKakaoLoginDataService
{
    static let KakaoLoginData = GetKakaoLoginDataService()

    func getRecommendInfo(completion : @escaping (NetworkResult<Any>) -> Void)
    {
        // completion 클로저를 @escaping closure로 정의합니다.

        let URL = Constants.LoginURL
        let header : HTTPHeaders = ["Content-Type": "application/json"]

        
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)

            
            case .failure: completion(.pathErr)
                print("실패 사유")

                
            }
        }
                                            
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(KakaoLoginDataModel.self, from: data)
        else {return .pathErr}
        // 우선 PersonDataModel 형태로 decode(해독)을 한번 거칩니다. 실패하면 pathErr
        // 해독에 성공하면 Person data를 success에 넣어줍니다.
        
        print("서버에서 받아온 값" , decodedData.code)
        return .success(decodedData.code)

    }
    
}

struct GetKakaoLoginTokenService
{
    static let KakaoLoginToken = GetKakaoLoginTokenService()

    func getRecommendInfo(completion : @escaping (NetworkResult<Any>) -> Void)
    {
        
        let defaults = UserDefaults.standard
        let code : String = defaults.string(forKey: "userToken") ?? ""
        
        // completion 클로저를 @escaping closure로 정의합니다.

        let URL = "https://api.wouldyou.in/user/kakao/callback/?code="+code+"&login=true"
        let header : HTTPHeaders = ["Content-Type": "application/json"]

        
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)

            
            case .failure: completion(.pathErr)
                print("실패 사유")

                
            }
        }
                                            
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(KakaoLoginTokenModel.self, from: data)
        else {return .pathErr}
        // 우선 PersonDataModel 형태로 decode(해독)을 한번 거칩니다. 실패하면 pathErr
        // 해독에 성공하면 Person data를 success에 넣어줍니다.
        
        print("서버에서 받아온 값" , decodedData.accessToken)
        return .success(decodedData.accessToken)

    }
    
}


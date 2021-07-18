import Foundation
import Alamofire

struct AutoLoginService {
    
    static let shared = AutoLoginService()
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    
    
    //userId, region, theme, warning
    private func makeParameter(refreshToken: String) -> Parameters {
        return  [ "refreshToken" : refreshToken]
    }
    
    func postSearchKeywords(refreshToken: String,
                            completion: @escaping (NetworkResult<Any>) -> Void){
        
        let dataRequest = AF.request(Constants.updateLoginToken+type,
                                     method: .post,
                                     parameters: makeParameter(refreshToken: refreshToken),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData{ dataResponse in
            switch dataResponse.result{
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return}
                guard let value = dataResponse.value  else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure(_): completion(.pathErr)
            }
        }
    }
    
    func getPostToken(refreshToken : String,
                        completion: @escaping (NetworkResult<Any>) -> Void){
       
        
        
        let dataRequeat = AF.download(Constants.updateLoginToken,
                                      method: .get,
                                      encoding: JSONEncoding.default,
                                      headers: header)
        
        dataRequeat.responseData{ dataResponse in
            switch dataResponse.result{
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return}
                guard let value = dataResponse.value  else {return}
                let networkResult = self.judgeStatusPostDetail(by: statusCode, value)
                completion(networkResult)
                
            case .failure(_): completion(.pathErr)
            }
        }
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodeData = try? decoder.decode(DetailModel.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200: return .success(decodeData)
        case 400: return .requestErr(decodeData)
        case 500: return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeStatusPostDetail(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodeData = try? decoder.decode(AutoLoginDataModel.self, from: data) else {
            return .pathErr
        }

        switch statusCode {
        case 200: return .success(decodeData)
            print(decodeData.accesstoken)
        case 400: return .requestErr(decodeData)
        case 500: return .serverErr
        default:
            return .networkFail
        }
    }
}

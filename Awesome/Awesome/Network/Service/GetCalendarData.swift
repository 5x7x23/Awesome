import Alamofire
import Foundation




struct GetCalendarDataService
{
    static let CalendarData = GetCalendarDataService()
    let userToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    
    func getRecommendInfo(completion : @escaping (NetworkResult<Any>) -> Void)
    {
        print("유저 토큰", userToken)
        
        // completion 클로저를 @escaping closure로 정의합니다.
        let URL = Constants.calendarURL
        let header : HTTPHeaders = ["Authorization": "Bearer " + userToken]
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                print("dd", statusCode)
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
        
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let decodedData = try? decoder.decode(CalendarDataModel.self, from: data)
        else {return .pathErr}
        // 우선 PersonDataModel 형태로 decode(해독)을 한번 거칩니다. 실패하면 pathErr
        // 해독에 성공하면 Person data를 success에 넣어줍니다.
//        defaults.set(decodedData, forKey: "myCalendar")
        print(decodedData)
    
        return .success(decodedData)

    }
    
}

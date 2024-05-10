//
//  NetworkingManager.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/09.
//

import UIKit
import Moya

final class APINetworkingManager {
    
    /*
     NetworkingManager를 싱글톤 객체로 구현한 이유.
     NetworkingManger는 주로 값을 반환하는 함수가 대부분을 차지함. 즉, 저장 속성보다는 계산 속성이나 메서드와 같은 '기능'에 초점이 맞추어진 상태인데,
     그렇다면? 프로토콜을 정의한 후, 구조체에서 채택함으로써 구현하면 좋을 것 같다는 생각은 듦.
     근데 그럼 구조체로 하지 왜 클래스로 만들어서 싱글톤을 구현했느냐? 하면...
     네트워크를 매번 불러올 수는 없음...뷰가 보일 때마다 계속 네트워크 통신을 하게 되면
     배터리도 빨리 닳고
     데이터도 많이 쓰고,
     서버에도 부하가 걸라며
     서버 비용도 많이 나올 것일 뿐만 아니라,
     API 호출 횟수에 한계도 있을 거고,
     데이터를 가져오는 데 시간차가 생기기 때문에, 부드러운 UI 구현이 힘들 수 있음. -> API로 데이터를 매번 계속 받아오긴 힘들다!
     -> 그래서 캐시 데이터를 저장해야 하는데, 그걸 NetworkingManager 싱글톤 객체에서 하면 어떨까...하는 생각인 것임. 
     (뷰컨트롤러에서 캐시 데이터를 갖고 있어도 되지 않느냐! 할 수도 있지만,
     네트워크 통신을 통해 받아온 캐시 데이터는 해당 뷰컨 외에도 다른 뷰에서도 필요할 수 있으므로...
     NetworkingManager에서 한번에 관리하는 것이 좋을 것 같다는 생각이 든다.)
     만약 NetworkingManager를 구조체로 만들 경우, 여러 개의 인스턴스를 생성하며 함수의 기능을 구현하는 데에는 문제가 없지만, 새로운 인스턴스가 생성되면 캐시데이터를 가져올 수 없음.
     (캐시 데이터를 CoreData에 저장하면 가능은 할 듯.) 그래서 메모리에서 계속 캐시데이터를 갖고 있을 수 있도록 싱글톤 객체를 생성한 것임..
     
     -> 그러면 저장 속성 말고 타입 저장 속성(static let, static var)으로 구현하면 되지 않느냐..!! 라는 질문이 생길 수 있는데,
     타입 저장 속성은 타입에 관한 정보를 갖고 있어야 하는데, 캐시데이터는 타입에 관한 정보라고 생각되진 않아서...우선은 인스턴스 저장 속성으로 구현했음...
     
     추가로, Moya의 공식 사용법?(다음 링크 참고)에서는 다음과 같이 설명하고 있다.
     https://github.com/Moya/Moya/blob/master/docs/Examples/Basic.md
     Always remember to retain the provider somewhere: if you fail to do so, it will be released automatically, potentially before you receive any response. -> 어차피 MoyaProvider도 메모리에 항상 올라와 있어야 한다! 이것만 봐도 딱 싱글톤 객체가 적당할 것 같다는 생각이 든다!!
     
     만약 코어데이터를 사용한다면 앱의 생명 주기와 연관지어도 좋겠다.
     - 싱글톤으로 구현하면서 캐시데이터를 싱글톤 객체에 저장하다가, 앱이 꺼지면서 싱글톤 객체가 메모리에서 내려가기 직전에 코어데이터에 저장.
     (박스오피스 데이터는 어차피 한 번 생성하면 바뀌지 않으므로, 굳이 매번 앱이 실행될 때마다 서버에서 받아올 필요는 없다. 한 번이라도 데이터를 받아온 날짜의 박스오피스 데이터는
     코어데이터에 저장하면 훨씬 빠르게 데이터를 가져올 수 있다.)
     
     - 반대로 앱이 시작하면서 싱글톤 객체가 생성될 때 코어데이터에서 캐시데이터를 가져오는 방식으로 구현
     (한 번에 많은 양의 캐시데이터를 불러오는 게 부담스러울 것 같으면 접근 시마다 코어데이터에 있는지 확인하고 캐시데이터로 복사해 오던가 등등...의 방법으로도 구현할 수 있을 것 같다.)
     */
    
    let moyaProvider = MoyaProvider<KOBISAPI>()
    var cacheBoxOfficeData: [String: [DailyBoxOfficeMovie]] = [:] // 키는 "yyyyMMdd" 포맷의 문자열, 값은 DailyBoxOfficeMovie타입을 요소로 갖는 딕셔너리
    
    static let shared = APINetworkingManager()
    private init() { }
    
    
    /// API를 이용해서 특정 날짜의 박스오피스 데이터를 요청하고 받아오는 함수
    /// - Parameters:
    ///   - dayBeforeToday: 특정 날짜가 오늘로부터 며칠 전인지 정하는 값. 항상 양수가 들어와야 한다. 예를 들어 이 값이  1이면 어제의 박스오피스, 2이면 그저께의 박스오피스를 요청한다.
    ///   - contentsNum: 한 번에 요청할 박스오피스 순위의 값. 최대값은 10. 10보다 큰 값을 입력할 경우, 10개만 받아옴.
    func getAPI(dateDistance: DateDistanceFromToday, contentsNum: Int = 10, completion: @escaping ([DailyBoxOfficeMovie]) -> Void) {
        let currentDate = Date.now
        guard let targetDate = Calendar(identifier: .gregorian).date(byAdding: .day, value: -Int(dateDistance.rawValue), to: currentDate) else { fatalError() }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd" // API에서 요청한 dateFormat
        let dateInString = dateFormatter.string(from: targetDate)
        
        /*
         네트워크 통신 전에 캐시데이터에 있는지 확인
         캐시데이터에 있으면 캐시데이터를 반환 후 네트워크 통신 없이 return
         */
        if self.cacheBoxOfficeData.keys.contains(dateInString) {
            guard let dailyBoxOfficeList = cacheBoxOfficeData[dateInString] else { fatalError() }
            completion(dailyBoxOfficeList)
            return
        }
        
        self.moyaProvider.request(KOBISAPI.getMovieRanking(targetDate: dateInString, number: contentsNum)) { result in
            switch result {
            case .success(let result):
                let responseData = result.data
                do {
                    let decodedNetworkingResult = try JSONDecoder().decode(MovieNetworkingResult.self, from: responseData)
                    
                    // 캐시데이터에 없으면 캐시데이터에 저장
                    if !self.cacheBoxOfficeData.keys.contains(dateInString) {
                        self.cacheBoxOfficeData[dateInString] = decodedNetworkingResult.boxOfficeResult.dailyBoxOfficeList
                    }
                    completion(decodedNetworkingResult.boxOfficeResult.dailyBoxOfficeList)
                    
                } catch {
                    fatalError("decoding data failed")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

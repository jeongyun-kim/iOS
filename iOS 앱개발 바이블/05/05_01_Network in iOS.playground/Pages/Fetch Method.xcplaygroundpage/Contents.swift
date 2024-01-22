//: [Previous](@previous)

import Foundation

enum NetworkError: Error {
  case invalidRequest
  case transportError(Error)
  case responseError(statusCode: Int)
  case noData
  case decodingError(Error)
}

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String    
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

// 네트워크를 담당하는 네트워크 서비스 생성
final class NetworkService {
    
    let session: URLSession // 네트워크를 할 때의 주요 객체 URLSession
    
    // 네트워크 서비스가 생성될 때 저 세션을 받도록 생성자 생성
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    // 깃허브 서버에서 사용자 프로필 정보 받아오는 메소드
    // Result : enum타입, 성공 케이스가 있고 실패 케이스가 있음
    // 성공하면 성공에 맞는 값을, 실패하면 실패에 맞는 값을 넘겨줌
    // Result<성공 케이스, 실패 케이스>
    func fetchProfile(userName: String, completion: @escaping (Result<GithubProfile, Error>)-> Void) {
        // 깃허브 프로필의 링크
        let url = URL(string: "https://api.github.com/users/\(userName)")!

        // url -> 서버에서 받은 내용들(data, response, error)
        // 받아온 데이터를 HTTPURLResponse로 변환하고 성공코드 200대라면 뛰어넘어서 아래 코드로 넘어옴 / 실패하면 출력
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error { // 에러가 있다면 실패에 에러 넘겨주기
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            
            // statusCode가 200대가 아니라면 에러
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else { // 데이터가 nil이라면 에러
                completion(.failure(NetworkError.noData))
                return }
            
            // data => GithubProfile
            // 서버에서 준 임의의 데이터(JSON)를 앱에서 사용할 수 있는 형태로 디코딩
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch let error as NSError { // 디코딩 에러
                    completion(.failure(NetworkError.decodingError(error)))
            }
        }
        // 생성된 데이터 태스크 시작
        task.resume()
    }
}

// network 담당 networkService
// networkService를 이용한 네트워크 작업

let networkService = NetworkService(configuration: .default)

networkService.fetchProfile(userName: "cafielo") { result in
    switch result {
    case .failure(let error):
        print("Error: \(error)")
    case .success(let profile):
        print("Profile: \(profile)")
    }
}

//: [Next](@next)

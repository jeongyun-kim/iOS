//: [Previous](@previous)

import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest
    case responseError(statusCode: Int)
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
    // publisher<데이터타입, 에러타입>
    func fetchProfile(userName: String) -> AnyPublisher<GithubProfile, Error> {
        // 깃허브 프로필의 링크
        let url = URL(string: "https://api.github.com/users/\(userName)")!
        
        let publisher = session
            .dataTaskPublisher(for: url)
        // 서버에서 받은 response 확인 및 data 확인
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
        // 받은 data 디코딩 잘하기
            .decode(type: GithubProfile.self, decoder: JSONDecoder())
            .eraseToAnyPublisher() // 타입을 지우는 역할
        return publisher
    }
}

let networkService = NetworkService(configuration: .default)
// publisher
let subscription = networkService
    .fetchProfile(userName: "cafielo")
    .receive(on: RunLoop.main)
    .print()
    .sink { completion in
        print("completion: \(completion)")
    } receiveValue: { profile in
        print("profile: \(profile)")
    }


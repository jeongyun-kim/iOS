//: [Previous](@previous)

import Foundation

// Codable : encodable + decodable
// App Model => JSON : Encoding
// JSON => App Model : Decoding
struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    // JSON의 키값들
    // avatarUrl로 가져올 때에 JSON에서 avatar_url 키의 값을 가져와줘
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

// configuration -> urlsession -> urlsessionTask

let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration) // 네트워크 할 주체

// 깃허브 프로필의 링크
let url = URL(string: "https://api.github.com/users/cafielo")!

// url -> 서버에서 받은 내용들(data, response, error)
// 받아온 데이터를 HTTPURLResponse로 변환하고 성공코드 200대라면 뛰어넘어서 아래 코드로 넘어옴 / 실패하면 출력
let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
        print("--> response \(response)")
        return
    }
    guard let data = data else { return }
    // data => GithubProfile
    // 서버에서 준 임의의 데이터(JSON)를 앱에서 사용할 수 있는 형태로 디코딩
    do {
        let decoder = JSONDecoder()
        let profile = try decoder.decode(GithubProfile.self, from: data)
        print("profile: \(profile)")
    } catch let error as NSError { // 에러
        print("error! : \(error)")
    }
}
// 생성된 데이터 태스크 시작
task.resume()

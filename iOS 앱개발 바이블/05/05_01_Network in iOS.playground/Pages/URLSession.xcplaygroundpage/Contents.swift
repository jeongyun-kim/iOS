//: [Previous](@previous)

import Foundation

// configuration -> urlsession -> urlsessionTask

let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration) // 네트워크 할 주체

// 깃허브 프로필의 링크
let url = URL(string: "https://api.github.com/users11/cafielo")!

// url -> 서버에서 받은 내용들(data, response, error)
// 받아온 데이터를 HTTPURLResponse로 변환하고 성공코드 200대라면 뛰어넘어서 아래 코드로 넘어옴 / 실패하면 출력
let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
        print("--> response \(response)")
        return
    }
    guard let data = data else { return }
    
    // 가져온 데이터를 utf8로 인코딩 후 확인
    let result = String(data: data, encoding: .utf8)
    print(result)
}
// 생성된 데이터 태스크 시작
task.resume()

//: [Next](@next)

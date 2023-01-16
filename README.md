# 🕸️ WebClient
[![Swift](https://img.shields.io/badge/Swift-5.7-darkorange?style=flat-square)](https://img.shields.io/badge/Swift-5.7-darkorange?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-darkorange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-darkorange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015.0%20or%20lator-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS%2015.0%20or%20lator-yellowgreen?style=flat-square)

Web Client library to get data from an API endpoint.

---
### Usage
```Swift
struct Album: Codable {
    var userId: Int
    var id:     Int
    var title:  String
}

do {
    let host = "https://jsonplaceholder.typicode.com/albums"
    let request = URLRequest(url: URL(string: host)!)

    let albums = try await WebClient.fetch([Album].self, for: request)

    for album in albums {
        print(album.title)
    }

} catch {
    print(error)
}
```

### Requirements
* Xcode 14.2 or later
* iOS 15.0 or later

### Dependencies
* none

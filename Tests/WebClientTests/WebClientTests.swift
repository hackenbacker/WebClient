import XCTest
@testable import WebClient

final class WebClientTests: XCTestCase {
    
    /// Cases in which received data is returned normally.
    /// 正常に受信データを返すケース
    func testGetAlbums() async throws {

        struct Album: Codable {
            var userId: Int
            var id:     Int
            var title:  String
        }

        let expect = expectation(description: "get JSON test")
        Task.detached {
            do {
                let host = "https://jsonplaceholder.typicode.com/albums"
                let request = URLRequest(url: URL(string: host)!)

                let _ = try await WebClient.fetch([Album].self, for: request)
                expect.fulfill()
            } catch {
                print(error)
                XCTFail("Unexpected exception occurred.")
            }
        }
        wait(for: [expect], timeout: 30)
    }

    /// Cases in which the status code is not 200.
    /// status codeが200ではないケース
    func testServerError() async throws {

        struct EmptyResponse: Codable {
            // no properties
        }

        do {
            let host = "https://httpbin.org/status/500"
            let request = URLRequest(url: URL(string: host)!)

            let _ = try await WebClient.fetch(EmptyResponse.self, for: request)
            XCTFail("No exception occurred.")
        } catch {
            if let e = error as? URLError {
                XCTAssertEqual(e.code, URLError.Code.badServerResponse, "Unexpected error code (not badServerResponse).")
            } else {
                print(error)
                XCTFail("Unexpected exception (not URLError) occurred.")
            }
        }
    }

    /// Cases in which an error occurs during decoding.
    /// デコード中にエラーが発生するケース
    func testDecodeError() async throws {

        struct EmptyResponse: Codable {
            // no properties
        }

        do {
            let host = "https://httpbin.org/status/200"
            let request = URLRequest(url: URL(string: host)!)

            let _ = try await WebClient.fetch(EmptyResponse.self, for: request)
            XCTFail("No exception occurred.")
        } catch {
            // Some exception occurred.
        }
    }
}

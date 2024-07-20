import Foundation

extension URLRequest {
    func log() {
        print("===== URLRequest =====")
        if let url = self.url {
            print("URL: \(url)")
        }
        if let method = self.httpMethod {
            print("HTTP Method: \(method)")
        }
        if let headers = self.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = self.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        } else {
            print("Body: None")
        }
        print("=====================")
    }
}

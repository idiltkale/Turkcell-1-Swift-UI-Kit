import Foundation

class APIClient {
    static func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                completion(.success(productResponse.products))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

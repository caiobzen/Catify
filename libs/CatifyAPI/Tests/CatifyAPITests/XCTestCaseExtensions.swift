import XCTest

extension XCTestCase {
    
    func dataFromJsonFile(named fileName: String) -> Data {
        guard let url = Bundle.module.url(forResource: fileName, 
                                          withExtension: "json") else {
            fatalError("Failed to locate \(fileName).json in bundle.")
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            fatalError("Failed to load \(fileName).json from bundle: \(error)")
        }
    }
}

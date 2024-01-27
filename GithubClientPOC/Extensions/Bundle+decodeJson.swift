//
//  Bundle+decodeJson.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 27/01/2024.
//

import Foundation

extension Bundle {
    /// Decode testing/mock json from file in bundle (for `Decodable` types)
    func decode<T: Decodable>(_ type: T.Type, from file: String, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            Log.error("Failed to locate \(file) in bundle.")
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            Log.error("Failed to load \(file) from bundle.")
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            Log.error("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            Log.error("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            Log.error("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            Log.error("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            Log.error("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
        
        return nil
    }
}

//
//  SearchTextDebounce.swift
//  GithubClientPOC
//
//  Created by Konrad Leszczyński on 28/01/2024.
//

import Foundation
import Combine

public final class SearchTextDebounce: ObservableObject {
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    public init(dueTime: TimeInterval = 0.8) {
        $text
            .removeDuplicates()
            .debounce(for: .seconds(dueTime),
                      scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.debouncedText = value
            })
            .store(in: &cancellables)
    }
}

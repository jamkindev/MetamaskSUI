//
//  HomeViewModel.swift
//  MetamaskSUI
//
//  Created by jamkin on 2022/7/7.
//

import SwiftUI

import Combine

struct HomeViewModel: Identifiable {
    let id = UUID()
    let account:String
    let picture: String
    let price: String
    var description: String = ""
}

let homeViewModels: [HomeViewModel] = [
    HomeViewModel(account: "Account1", picture: "airedale-terrier", price: "$0", description: "0x1234...A111"),
    HomeViewModel(account: "Account2", picture: "fox", price: "$1", description: "0xfafw...fw13"),
    HomeViewModel(account: "Account3", picture: "eth-logo", price: "$2", description: "0x321s...J19d")
]

class Model: ObservableObject {
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.load()
            }
        }
    }
    
    @Published var homeViewModel: HomeViewModel = homeViewModels[0]
    
    var idx = 0
    
    func load() {
        // Simulate async task
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            
            // Next HomeViewModel
            self.idx = (self.idx+1) < homeViewModels.count ? (self.idx+1) : 0
            
            self.loading = false
            
            self.homeViewModel = homeViewModels[self.idx]
        }
    }
}

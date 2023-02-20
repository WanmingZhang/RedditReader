//
//  PostListViewModel.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import Foundation

/**
 * VIew model for PostListViewController
 */

class PostListViewModel {
    var apiManager: ListServiceProtocol
    //var list: Observable<Listing> = Observable(Listing(kind: "", data: ListingData(after: "", before: "", children: [], dist: 0, modhash: "")))
    var posts: Observable<[Post]> = Observable([])
    var before: Observable<String?> = Observable(nil)
    var after: Observable<String?> = Observable(nil)
    var errorMsg: Observable<String?> = Observable(nil)
    
    // pass in a protocol type instead of the concrete type so that service and view model are not tightly coupled
    init(_ apiManager: ListServiceProtocol) {
        self.apiManager = apiManager
    }
    
    func getList(type: ListType) {
        let typeStr = type.rawValue
        ListService().getList(Paginator(), type: typeStr) { result in
            switch result {
            case .success(let list):
                self.posts.value = list.data.children
                self.before.value = list.data.before
                self.after.value = list.data.after
                print("sucess: \(self.posts.value.count) \(self.posts.value[0]) before = \(self.before.value ?? ""), after = \(self.after.value ?? "")")
            case .failure(let error):
                self.errorMsg.value = error.localizedDescription
                print("failure: \(error.localizedDescription)")
            }
        }
    }
    
    func loadMoreList(type: ListType) {
        let typeStr = type.rawValue
        let after = self.after.value ?? ""
        let before = self.before.value ?? ""
        let paginator = Paginator(after: after, before: before)
        ListService().getList(paginator, type: typeStr) { result in
            switch result {
            case .success(let newList):
                self.before.value = newList.data.before
                self.after.value = newList.data.after
                self.posts.value.append(contentsOf: newList.data.children)
                print("sucess: \(self.posts.value.count) \(self.posts.value[0]) before = \(self.before.value ?? ""), after = \(self.after.value ?? "")")
            case .failure(let error):
                self.errorMsg.value = error.localizedDescription
                print("failure: \(error.localizedDescription)")
            }
        }
        
    }
    
}

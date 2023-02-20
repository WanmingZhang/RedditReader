//
//  PostListViewController.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import UIKit

class PostListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var isLoading = false
    let spinner = UIActivityIndicatorView()
    let viewModel: PostListViewModel
    let reuseCellId = "PostCell"
    var type: ListType
    
    required init?(coder: NSCoder) {
        let apiManager = ListService()
        let viewModel = PostListViewModel.init(apiManager)
        self.viewModel = viewModel
        self.type = .hot
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBinder()
        callToViewModelToUpdateUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    func configureTableView() {
        tableView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func callToViewModelToUpdateUI() {
        viewModel.getList(type: type)
    }
    
    // binding of view and view model
    func setupBinder() {
        viewModel.posts.bind {[weak self] (_) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("load table number of rows: \(viewModel.posts.value.count)")
        return viewModel.posts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: reuseCellId, for: indexPath) as? PostCell else {
            return cell
        }
        guard viewModel.posts.value.count > 0 else {
            return cell
        }
        
        let post = viewModel.posts.value[indexPath.row]
        postCell.update(with: post.data)
        return postCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let postCount = viewModel.posts.value.count
        if postCount - 1 == indexPath.row && !isLoading {
            print("reached end of page: \(postCount)")
            loadMoreData()
        }
    }

    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            viewModel.loadMoreList(type: type)
        }
    }
}

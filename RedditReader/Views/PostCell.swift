//
//  PostCell.swift
//  RedditReader
//
//  Created by wanming zhang on 2/17/23.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var subReddit: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    let imageFetcher = ImageFetcher()
    var onReuse: () -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureBorder()
    }
    
    override func prepareForReuse() {
        self.thumbnail.image = nil
        onReuse()
    }

    func configureBorder() {
        borderView.layer.borderColor = UIColor.systemGray5.cgColor
        borderView.layer.borderWidth = 2.0
        borderView.layer.cornerRadius = 8.0
    }
    
    func update(with post: ChildData) {
        if let sub = post.subreddit {
            self.subReddit.text = "r/\(sub)"
        }
        self.name.text = post.author
        self.title.text = post.title
        self.loadFlagImage(post)
    }
    
    func loadFlagImage(_ post: ChildData) {
        guard let images = post.preview?.images else {
            return
        }
        guard let urlStr = images[0].resolutions?[0].url else {
            return
        }
        
        guard let url = URL(string: urlStr) else {
            return
        }
        print("thumbnail url = \(urlStr)")
        let token = imageFetcher.fetchImageFromUrl(url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.thumbnail.image = image
            case .failure(let error):
                print("Fetching image error: \(error.localizedDescription)")
            }
        }
        
        if let token = token {
            onReuse = { [weak self] in
                guard let self = self else { return }
                self.imageFetcher.cancelLoad(token)
            }
        }
    }

}

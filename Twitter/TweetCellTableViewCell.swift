//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Yamini Ponugoti on 2/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var favorited:Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    func setFavourite(_ isFavorited:Bool) {
        favorited = isFavorited
        if(favorited){
            likeButton.setImage(UIImage(named:"favor-icon-red"),for:UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named:"favor-icon"),for:UIControl.State.normal)
        }
    }
    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed \(Error)")
            })
        }
        else{
            TwitterAPICaller.client?.unFavTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed \(Error)")
            })
        }
    }
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error in retweeting \(Error)")
        })
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"),for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named:"retweet-icon"),for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

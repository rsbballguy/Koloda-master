//
//  CViewController.swift
//  Koloda
//
//  Created by Rahul Sundararaman on 8/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class CViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["Sports", "Stocks", "Celebrities", "Politics"]
    var images = ["bball.png", "finance.png", "ring.png", "flag.png"]
    var information: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
    }
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 50, bottom: 10, right: 50)
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        
        cell.backgroundColor = UIColor.clearColor() // make cell more visible in our example project
        cell.layer.borderWidth=1.0
        cell.layer.borderColor=UIColor.blackColor().CGColor
        cell.layer.cornerRadius = cell.frame.size.width / 2
        let View=UIView()
        View.backgroundColor=UIColor(patternImage:UIImage(named:self.images[indexPath.item])!)
        cell.backgroundView=View
        cell.tag = indexPath.row
        return cell
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        information = indexPath.item
        performSegueWithIdentifier("goToNext", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let yourNextViewController = (segue.destinationViewController as! BackgroundAnimationViewController)
        yourNextViewController.value = information
    }
}
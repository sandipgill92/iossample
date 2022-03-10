//
//  LoginView.swift
//  AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import UIKit

class LoginView: UIViewController,LoginViewProtocol {
    
    //MARK: - - Outlets and Variables
    var loginViewModel : LoginViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var currentContentOffset:CGFloat = 0.0
    var isScrollDirectionBack = false
    
    //MARK: - - View Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let nib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        self.currentContentOffset = self.collectionView.contentOffset.x
        
    }
    
    @IBAction func next(_ sender: Any) {
        let previewViewController = self.storyboard?.instantiateViewController(identifier: "PreviewViewController") as! PreviewViewController
        self.navigationController?.pushViewController(previewViewController, animated: true)
//        self.collectionView.contentOffset.x += screenWidth/4
//        currentContentOffset = self.collectionView.contentOffset.x
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.collectionView.contentOffset.x -= screenWidth/4
        currentContentOffset = self.collectionView.contentOffset.x
    }
    
}

extension LoginView : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.contentView.backgroundColor = UIColor.random()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0){
            isScrollDirectionBack = true
        }else{
            isScrollDirectionBack = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if isScrollDirectionBack{
            if Int(currentContentOffset) < Int(scrollView.contentOffset.x){
                currentContentOffset -= screenWidth/4
                self.collectionView.contentOffset.x = currentContentOffset
                self.collectionView.isScrollEnabled = false
            }
        }else{
            if Int(currentContentOffset) > Int(scrollView.contentOffset.x){
                currentContentOffset += screenWidth/4
                self.collectionView.contentOffset.x = currentContentOffset
                self.collectionView.isScrollEnabled = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.collectionView.isScrollEnabled = true
        }
    }
    
    
    
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

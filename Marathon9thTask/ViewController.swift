//
//  ViewController.swift
//  Marathon9thTask
//
//  Created by Артем Соколовский on 25.07.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	
	lazy var collectionView: UICollectionView = {
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
		collectionView.showsHorizontalScrollIndicator = false

		return collectionView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(collectionView)
		title = "Collection"
		

	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			   collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
			   collectionView.heightAnchor.constraint(equalTo: view.widthAnchor),
			   collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			   collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		   ])
	}

	 
}

extension ViewController: UICollectionViewDelegate {
	
}

extension ViewController: UICollectionViewDataSource {

	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width * 0.75, height: collectionView.frame.width )
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 9
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
		cell.backgroundColor = .systemGray3
		cell.layer.cornerRadius = 5
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
			return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		 var pageWidth = Float(200 + 30)
		 var currentOffset = Float(scrollView.contentOffset.x)
		 var targetOffset = Float(targetContentOffset.pointee.x)
		 var newTargetOffset = Float(0)

		 if targetOffset > currentOffset {
			 newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
		 } else {
			 newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
		 }

		 if newTargetOffset < 0 {
			 newTargetOffset = 0
		 } else if newTargetOffset > currentOffset {
			 newTargetOffset = currentOffset
		 }

		 scrollView.setContentOffset(CGPointMake(CGFloat(newTargetOffset), 0), animated: true)
	}
	
	
}

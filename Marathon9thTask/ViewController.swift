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
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
		return 19
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
        print(view.layoutMargins.left)
        return UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: collectionView.layoutMargins.right)
        
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		collectionView.contentInset = UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: collectionView.layoutMargins.right)

		let target = targetContentOffset.pointee
		let center = CGPoint(x: target.x + collectionView.bounds.width / 2, y: target.y + collectionView.bounds.height / 2)
		guard let indexPath = collectionView.indexPathForItem(at: center) else { return }
		guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
		let itemSize = attributes.frame.size
		let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0

        let pageWidth = (itemSize.width + spacing)
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        targetContentOffset.pointee.x = round(itemIndex) * pageWidth - (spacing / 2)
 
	}
}

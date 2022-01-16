//
//  CollectionView.swift
//  CompositionalLayout
//
//  Created by Roman Cebula on 15/01/2022.
//

import UIKit

class CollectionView: UIView {
    
    enum Section {
        case main
    }
    
    var numberOfCells: Int = 2 {
        didSet {
//            setNeedsLayout()
//            relayoutCollectionView()
//            collectionView.collectionViewLayout.invalidateLayout()
//            collectionView.backgroundColor = .red
//            collectionView.backgroundView?.backgroundColor = .lightGray
//            collectionView.setCollectionViewLayout(createFlowLayout(), animated: true, completion: nil)
//            collectionView.collectionViewLayout.shouldInvalidateLayout(forBoundsChange: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
//            collectionView.setCollectionViewLayout(createFlowLayout(), animated: true, completion: nil)
//            collectionView.collectionViewLayout.shouldInvalidateLayout(forBoundsChange: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
//            collectionView.collectionViewLayout.finalizeAnimatedBoundsChange()
//            collectionView.collectionViewLayout.finalizeCollectionViewUpdates()
//            collectionView.collectionViewLayout.invalidateLayout()
//            collectionView.reloadData()
//            configureHierarchy()
//            configureDataSource()
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>?
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func relayoutCollectionView() {
//        collectionView.setNeedsLayout()
//        collectionView.setCollectionViewLayout(createFlowLayout(), animated: true, completion: nil)
//        collectionView.collectionViewLayout.invalidateLayout()
//    }
    
    func relayoutCollectionView(with size: CGSize) {
        collectionView.collectionViewLayout.shouldInvalidateLayout(forBoundsChange: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        collectionView.setCollectionViewLayout(createFlowLayout(), animated: true, completion: nil)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView?.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: SimpleCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleCollectionViewCell.reuseIdentifier, for: indexPath) as? SimpleCollectionViewCell else { fatalError("Cannot create cell")}
            cell.contentView.backgroundColor = .yellow
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1.0
            return cell
        })
        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0..<30))
        dataSource?.apply(snapShot)
    }
    
    private func createFlowLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(127))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: numberOfCells)
        let spacing: CGFloat = 10
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}



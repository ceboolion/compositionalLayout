//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Roman Cebula on 15/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let _view = CollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        prepare()
    }
    
    private func prepare() {
        view.addSubview(_view)
        _view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _view.topAnchor.constraint(equalTo: view.topAnchor),
            _view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            _view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("WRC viewWillTransition to size: \(size)")
        print("WRC _view.collectionView.bounds: \(_view.collectionView.bounds)")
        
        if UIDevice.current.orientation == .landscapeRight || UIDevice.current.orientation == .landscapeLeft {
            _view.numberOfCells = 4
            _view.relayoutCollectionView(with: size)
        } else {
            _view.numberOfCells = 3
            _view.relayoutCollectionView(with: size)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        _view.relayoutCollectionView()
//    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        _view.relayoutCollectionView()
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        _view.relayoutCollectionView()
//    }
    
    
}


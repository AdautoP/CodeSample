//
//  CharacterListRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

class CharactersListRootView: BaseView {
    
    private let flowLayout = UICollectionViewFlowLayout() >> {
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.scrollDirection = .horizontal
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout) >> {
        $0.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifer)
        $0.backgroundColor = AppColors.Grays.lightGray
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(collectionView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        collectionView.edgesToSuperview()
    }
    
    override func buildAditionalConfiguration() {
    }
}

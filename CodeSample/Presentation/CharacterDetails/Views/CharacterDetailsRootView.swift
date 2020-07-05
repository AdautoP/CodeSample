//
//  CharacterDetailsRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import UIKit

class CharacterDetailsRootView: BaseView {
    
    private let contentView = BaseView()
    
    private let imageHeaderView = ImageHeaderView()
    
    private lazy var tableView = BaseTableView() >> {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifer)
    }
    
    private var imageHeight = NSLayoutConstraint()
    
    override func buildSubviews() {
        super.buildSubviews()
        
        addSubview(contentView)
        
        contentView.addSubview(imageHeaderView)
        contentView.addSubview(tableView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        
        contentView.edgesToSuperview(usingSafeArea: true)
        
        imageHeaderView.edgesToSuperview(excluding: .bottom)
        imageHeight = imageHeaderView.heightToSuperview(multiplier: 0.3)
        
        tableView.topToBottom(of: imageHeaderView)
        tableView.edgesToSuperview(excluding: .top)
    }
    
    func layout(_ character: Character) {
        imageHeaderView.layout(character.image)
    }
}

extension CharacterDetailsRootView: BaseTableViewDelegate, BaseTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell() >> { $0.textLabel?.text = "\(indexPath.row)" }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard tableView.hasVisibleCells else { return }
        let yOffset = scrollView.contentOffset.y
        
        let minOffset = -(view.frame.height / 3) - 100
        let maxOffset = view.frame.height / 3 + 100
        
        if minOffset...0 ~= yOffset {
            print(yOffset)
            self.imageHeight.constant -= yOffset
            self.layoutIfNeeded()
        } else if 1...maxOffset ~= yOffset {
            self.imageHeight.constant = -yOffset
            self.layoutIfNeeded()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if imageHeight.constant > 0.0 {
            self.imageHeight.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
        }
    }
}

//
//  CharacterListRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

protocol CharactersListRootViewDelegate: AnyObject {
    func fetchMoreItems()
}

class CharactersListRootView: BaseView {
    
    weak var delegate: CharactersListRootViewDelegate?
    
    private var characters = [Character]() {
        didSet { tableView.reloadData() }
    }
    
    private lazy var tableView = BaseTableView() >> {
        $0.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifer)
        $0.backgroundColor = AppColors.Grays.lightGray
        $0.delegate = self
        $0.separatorStyle = .none
    }
    
    @objc func teste() {}
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(tableView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        tableView.edgesToSuperview()
    }
    
    func layout(_ display: Display<CharactersListViewModel.State>) {
        guard let value = display.value else { return }
        switch value {
        case let .success(characters): self.characters += characters
        case .noMorePages: tableView.noMorePages()
        default: break
        }
    }
}

extension CharactersListRootView: BaseTableViewDelegateDataSource {
    func fetchMoreItems() {
        delegate?.fetchMoreItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifer) as? CharacterCell else { return UITableViewCell() }
        cell.bind(characters[indexPath.row])
        return cell
    }
}

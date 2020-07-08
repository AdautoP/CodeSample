//
//  CharacterListRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

protocol CharactersListRootViewDelegate: AnyObject {
    func fetchMoreItems()
    func didSelect(character: Character)
}

class CharactersListRootView: ScreenView {
    
    weak var delegate: CharactersListRootViewDelegate?
    
    private var characters = [Character]() {
        didSet { tableView.reloadData() }
    }
    
    private lazy var tableView = BaseTableView() >> {
        $0.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifer)
        $0.backgroundColor = AppColors.Grays.lightGray
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
    }
    
    override func buildScreen() {
        super.buildScreen()
        render(.contentView(tableView))
    }
    
    func layout(_ display: Display<CharactersListViewModel.State>) {
        guard let value = display.value else { return }
        switch value {
        case let .success(characters): self.characters = characters
        case .noMorePages: tableView.nomeMorePages = true
        default: break
        }
    }
}

extension CharactersListRootView: BaseTableViewDelegate, BaseTableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(character: characters[indexPath.row])
    }
    
    func fetchMoreItems() {
        delegate?.fetchMoreItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifer) as? CharacterCell else { return UITableViewCell() }
        cell.layout(characters[indexPath.row])
        return cell
    }
}

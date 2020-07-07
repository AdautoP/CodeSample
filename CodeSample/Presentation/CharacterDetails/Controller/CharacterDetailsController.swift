//
//  CharacterDetailsController.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import Foundation
import RxCocoa
import RxSwift

class CharacterDetailsController: BaseController {
    private let disposeBag = DisposeBag()
    private let viewModel: CharacterDetailsViewModel
    private let rootView = CharacterDetailsRootView()
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        getEpisodes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.layoutSubviews()
    }
    
    func getEpisodes() {
        viewModel
            .getEpisodes()
            .displayable(retryAction: getEpisodes)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}

extension CharacterDetailsController {
    var state: Binder<Display<CharacterDetailsViewModel.ScreenData>> {
        Binder(self, binding: { controller, display in
            controller.layout(display)
            controller.rootView.layout(display)
        })
    }
}

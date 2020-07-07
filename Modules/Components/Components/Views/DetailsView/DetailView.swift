//
//  DetailView.swift
//  Components
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import AloeStackView
import UIKit

public enum DetailRowType {
    case header(String)
    case name(String)
    case status(StatusRepresentable)
    case vText(title: String, value: String)
    case view(UIView)
}

public class DetailView: AloeStackView {
    
    override public init() {
        super.init()
        rowInset = .init(top: 0, left: 24, bottom: 20, right: 24)
        separatorInset = .zero
        hidesSeparatorsByDefault = true
        automaticallyHidesLastSeparator = true
        backgroundColor = AppColors.Grays.lightGray
        delegate = self
        bounces = false
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func render(_ rows: DetailRowType ...) {
        render(rows)
    }
    
    public func render( _ rows: [DetailRowType]) {
        self.removeAllRows()
        rows.forEach {
            switch $0 {
            case let .header(imageUrl): addHeader(imageUrl)
            case let .name(name): addName(name)
            case let .status(status): addStatus(status)
            case let .vText(title: title, value: value): addVerticalText(title: title, value: value)
            case let .view(view): addView(view)
            }
        }
    }
    
    func addHeader(_ imageUrl: String) {
        let header = ImageHeaderView() >> { $0.layout(imageUrl) }
        addRow(header, inset: .bottom(20))
        header.height(to: self, multiplier: 0.3)
    }
    
    func addName(_ name: String) {
        let nameLabel = UILabel() >> {
            $0.font = .appFont(size: 20, weight: .bold)
            $0.textColor = AppColors.Grays.black
            $0.text = name
        }
        addRow(nameLabel, inset: .horizontal(24))
    }
    
    func addStatus(_ status: StatusRepresentable) {
        let statusView = StatusView() >> { $0.layout(status) }
        addRow(statusView)
    }
    
    func addVerticalText(title: String, value: String) {
        let infoRow = InfoView(info: title) >> { $0.bind(value: value) }
        addRow(infoRow)
    }
    
    func addView(_ view: UIView) {
        addRow(view)
    }
}

extension DetailView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
    }
}

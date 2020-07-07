//
//  DetailView.swift
//  Components
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import AloeStackView
import UIKit

public class DetailView: BaseView {
    
    internal var topStackViewHeight = NSLayoutConstraint()
    
    internal let topStackView = UIStackView() >> {
        $0.backgroundColor = AppColors.Grays.lightGray
        $0.spacing = 0
        $0.distribution = .fill
    }
    
    internal lazy var detailStackView = AloeStackView() >> {
        $0.rowInset = .init(top: 0, left: 24, bottom: 20, right: 24)
        $0.separatorInset = .zero
        $0.hidesSeparatorsByDefault = true
        $0.automaticallyHidesLastSeparator = true
        $0.backgroundColor = AppColors.Grays.lightGray
        $0.delegate = self
        $0.alwaysBounceVertical = true
        $0.bounces = true
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(topStackView)
        addSubview(detailStackView)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        topStackView.edgesToSuperview(excluding: .bottom)
        topStackViewHeight = topStackView.heightToSuperview(multiplier: 0.3)
        
        detailStackView.topToBottom(of: topStackView)
        detailStackView.edgesToSuperview(excluding: .top)
    }
    
    public func render(_ rows: DetailRowType ...) {
        render(rows)
    }
    
    public func render( _ rows: [DetailRowType]) {
        detailStackView.removeAllRows()
        topStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        topStackViewHeight.constant = -self.frame.height / 3
        
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
    
    func addName(_ name: String) {
        let nameLabel = UILabel() >> {
            $0.font = .appFont(size: 20, weight: .bold)
            $0.textColor = AppColors.Grays.black
            $0.text = name
        }
        detailStackView.addRow(nameLabel, inset: .init(top: 24, left: 24, bottom: 0, right: 24))
    }
    
    func addView(_ view: UIView) {
        detailStackView.addRow(view)
    }
    
    public func addRow(_ row: UIView, inset: UIEdgeInsets) {
        detailStackView.addRow(row, inset: inset)
    }
    
    public func addRow(_ row: UIView) {
        detailStackView.addRow(row)
    }
}

extension DetailView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset = scrollView.contentOffset.y
        let constant = topStackViewHeight.constant

        if yOffset < 0 {
            if constant < 50 && constant - yOffset < 50 {
                topStackViewHeight.constant -= yOffset
                layoutIfNeeded()
            }
        } else {
            if yOffset < self.frame.height && constant > -self.frame.height {
                topStackViewHeight.constant -= yOffset
                layoutIfNeeded()
            }
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if topStackViewHeight.constant > 0 {
            self.topStackViewHeight.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
        }
        scrollView.bounces = true
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = false
    }
}

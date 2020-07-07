//
//  DetailView.swift
//  Components
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import AloeStackView
import UIKit

public class DetailView: BaseView {
    
    internal let mainStackView = UIStackView() >> {
        $0.backgroundColor = AppColors.Grays.lightGray
        $0.spacing = 0
        $0.distribution = .fill
        $0.axis = .vertical
    }
    
    private var isAnimating = false
    
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
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(detailStackView)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        mainStackView.edgesToSuperview(usingSafeArea: true)
    }
    
    public func render(_ rows: DetailRowType ...) {
        render(rows)
    }
    
    public func render( _ rows: [DetailRowType]) {
        detailStackView.removeAllRows()
        topStackView.removeFromSuperview()
        topStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
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
            topStackViewHeight.constant -= yOffset
        } else {
            if yOffset < self.frame.height / 3 && constant - yOffset > -self.frame.height / 3 {
                topStackViewHeight.constant -= yOffset
                scrollView.contentOffset.y -= yOffset
            } else {
                topStackViewHeight.constant -= constant - 1 >= -self.frame.height ? 1 : 0
                scrollView.contentOffset.y -= constant - 1 >= -self.frame.height ? 1 : 0
            }
        }
        layoutIfNeeded()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if topStackViewHeight.constant > 0, !isAnimating {
            self.topStackViewHeight.constant = 0
            isAnimating = true
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in self.isAnimating = false })
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if topStackViewHeight.constant > 0, !isAnimating {
            self.topStackViewHeight.constant = 0
            isAnimating = true
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in self.isAnimating = false })
        }
    }
}

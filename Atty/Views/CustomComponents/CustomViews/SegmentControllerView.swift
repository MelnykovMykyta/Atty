//
//  SegmentControllerView.swift
//  Atty
//
//  Created by Nikita Melnikov on 10.11.2023.
//

import Foundation
import SnapKit
import BetterSegmentedControl

class SegmentControllerView: UIView {
    
    var controller: BetterSegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addController(with titles: [String]) {
        
        controller = BetterSegmentedControl()
        controller.segments = LabelSegment.segments(withTitles: titles,
                                                    normalBackgroundColor: DS.Colors.mainViewColor,
                                                    normalFont: UIFont(name: "Manrope-Bold", size: 14),
                                                    normalTextColor: DS.Colors.darkedTextColor,
                                                    selectedBackgroundColor: DS.Colors.selectedSegmentController,
                                                    selectedFont: UIFont(name: "Manrope-Bold", size: 14),
                                                    selectedTextColor: DS.Colors.standartTextColor)
        addSubview(controller)
        
        controller.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        controller.cornerRadius = self.frame.height / 2
        controller.backgroundColor = DS.Colors.mainViewColor
        controller.indicatorViewBackgroundColor = DS.Colors.mainViewColor
        controller.indicatorViewBorderColor = DS.Colors.mainViewColor
    }
}


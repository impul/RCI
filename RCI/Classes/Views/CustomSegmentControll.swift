//
//  CustomSegmentControll.swift
//  RCI
//
//  Created by Impulse on 11.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit

protocol CustomSegmentControllProtocol {
    func selectedItem(atIndex:Int)
}

class CustomSegmentControll: UIView {
    
    var segmentTitles:[String] = []
    var selectedSegmentIndex:Int = 0
    var delegate:CustomSegmentControllProtocol?
    
    func setupSegmentController(titles:[String]) {
        segmentTitles = titles
        buildSegmentControll()
        selectSegment(atIndex: selectedSegmentIndex)
    }
    
    func buildSegmentControll() {
        for (index, title) in segmentTitles.enumerated() {
            let segmentItem = UILabel(frame:frameForIndex(index: index))
            segmentItem.text = title
            segmentItem.textAlignment = .center
            segmentItem.font = UIFont(name: "SFUIText-Regular", size: 14)
            let segmentTup = UITapGestureRecognizer(target: self, action: #selector(self.segmentTup(_:)))
            segmentItem.addGestureRecognizer(segmentTup)
            segmentItem.tag = index
            segmentItem.isUserInteractionEnabled = true
            addSubview(segmentItem)
        }
    }
    
    func segmentTup(_ sender: UITapGestureRecognizer) {
        selectSegment(atIndex: (sender.view?.tag)!)
        delegate?.selectedItem(atIndex: (sender.view?.tag)!)
    }
    
    func selectSegment(atIndex:Int) {
        selectedSegmentIndex = atIndex
        deselectAllItems()
        let itemToSelect = self.subviews[atIndex] as! UILabel
        itemToSelect.backgroundColor = .defaultBlueColor
        itemToSelect.textColor = .white
    }
    
    func deselectAllItems() {
        for item in self.subviews as! [UILabel] {
            item.backgroundColor = .white
            item.textColor = .defaultBlueColor
        }
    }

    func frameForIndex(index:Int) -> CGRect {
        return CGRect(x: frame.size.width/CGFloat(segmentTitles.count) * CGFloat(index), y: 0, width: frame.size.width/CGFloat(segmentTitles.count), height: frame.size.height)
    }
}

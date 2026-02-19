//
//  AutocompleteTableView.swift
//  InputBarAccessoryView
//
//  Copyright © 2017-2020 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 10/4/17.
//

import UIKit

open class AutocompleteTableView: UITableView {
    /// The max visible rows visible in the autocomplete table before the user has to scroll throught them
  open var maxVisibleRows = 3 { didSet { invalidateIntrinsicContentSize() } }
  
  open override var intrinsicContentSize: CGSize {
    get {
      let rowCount = numberOfRows(inSection: 0)
      let visibleRows = rowCount < maxVisibleRows ? rowCount : maxVisibleRows
      
      guard visibleRows > 0 else {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0)
      }
      
      // Ensure the table view has performed layout before querying row rects
      layoutIfNeeded()
      
      var height: CGFloat = 0
      for row in 0..<visibleRows {
        height += self.rectForRow(at: IndexPath(row: row, section: 0)).size.height
      }
      
      if height == 0 {
        // Fallback: use rowHeight or estimatedRowHeight if rectForRow(at:) is not reliable yet
        let defaultRowHeight: CGFloat
        if rowHeight > 0 {
          defaultRowHeight = rowHeight
        } else if estimatedRowHeight > 0 {
          defaultRowHeight = estimatedRowHeight
        } else {
          defaultRowHeight = 44 // reasonable default row height
        }
        height = CGFloat(visibleRows) * defaultRowHeight
      }
      
      return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    set {
    }
  }
}


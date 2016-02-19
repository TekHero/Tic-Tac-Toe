//
//  RoundedEdgesLabel.swift
//  Tic-Tac-Toe
//
//  Created by Brian Lim on 2/17/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit

class RoundedEdgesLabel: UILabel {
    
    override func awakeFromNib() {
        layer.cornerRadius = 5.0
    }

}

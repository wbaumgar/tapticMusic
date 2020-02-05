//
//  queuedSongTableViewCell.swift
//  tapticMusic
//
//  Created by William Baumgardner on 2/4/20.
//  Copyright © 2020 William Baumgardner. All rights reserved.
//

import UIKit

class queuedSongTableViewCell: UITableViewCell {
    var albumnCover   = UIImageView()
    var songTitle     = UILabel()
    var artist        = UILabel()
    private var stack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubview(albumnCover)
        albumnCover.snp.makeConstraints { (make) -> Void in
            make.top.bottom.left.equalToSuperview().inset(8)
            make.width.equalTo(self.snp.height)
        }
        
        addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.snp.makeConstraints {(make) -> Void in
            make.top.bottom.right.equalToSuperview().inset(8)
            make.left.equalTo(albumnCover.snp.right)
        }
        
        songTitle.numberOfLines = 1
        artist.numberOfLines = 1
        stack.addArrangedSubview(songTitle)
        stack.addArrangedSubview(artist)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

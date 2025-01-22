//
//  MensagensTableViewCell.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 22/01/25.
//

import UIKit

class MensagensTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mensagemDireitaLabel: UILabel!
    
    @IBOutlet weak var mensagemEsquerdaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  MensagensViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 22/01/25.
//

import UIKit

class MensagensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewMensagens: UITableView!
    @IBOutlet weak var fotoBotao: UIButton!
    
    @IBOutlet weak var mensagemCaixaTexto: UITextField!
    
    var listaMensagens: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configurações da tableView
        tableViewMensagens.separatorStyle = .none
        tableViewMensagens.backgroundView = UIImageView(image: UIImage(named: "bg"))
        
        //Configura lista de mensagens
        listaMensagens = ["Olá, tudo bem?", "Tudo ótimo meu amigo", "Estou muito doente e precisava falar com você, será que poderia ir na farmácia pegar alguns remédios?", "Posso sim, quais?", "Pode pegar um Resfenol, pode ser aquele dia e noite, sabe qual é?", "Sei sim!!", "Excelente!!Muuuuuuuito obrigadooo!!", "Por nada!! espero que melhore logo"]
        
    }
    
    
    @IBAction func enviarMensagem(_ sender: Any) {
    }
    
    /*Métodos para listagem na tabela */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMensagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celulaDireita = tableView.dequeueReusableCell(withIdentifier: "celulaMensagensDireita", for: indexPath) as! MensagensTableViewCell
        
        let celulaEsquerda = tableView.dequeueReusableCell(withIdentifier: "celulaMensagensEsquerda", for: indexPath) as! MensagensTableViewCell
        
        let indice = indexPath.row
        let mensagem = self.listaMensagens[indice]
        
        if indice % 2 == 0 {
            celulaDireita.mensagemDireitaLabel.text = mensagem
            return celulaDireita
        }else{
            celulaEsquerda.mensagemEsquerdaLabel.text = mensagem
            return celulaEsquerda
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}

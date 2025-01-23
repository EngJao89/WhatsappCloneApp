//
//  MensagensViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 22/01/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MensagensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewMensagens: UITableView!
    @IBOutlet weak var fotoBotao: UIButton!
    
    @IBOutlet weak var mensagemCaixaTexto: UITextField!
    
    var listaMensagens: [Dictionary<String, Any>]! = []
    var idUsuarioLogado: String!
    var contato: Dictionary<String, Any>!
    var mensagensListener: ListenerRegistration!
    
    var auth: Auth!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        db = Firestore.firestore()
        
        //Recuperar id usuario logado
        if let id = auth.currentUser?.uid {
            self.idUsuarioLogado = id
        }
        
        //Configura título da tela
        if let nome = contato["nome"] {
            self.navigationItem.title = nome as? String
        }

        //configurações da tableView
        tableViewMensagens.separatorStyle = .none
        tableViewMensagens.backgroundView = UIImageView(image: UIImage(named: "bg"))
        
        //Configura lista de mensagens
        //listaMensagens = ["Olá, tudo bem?", "Tudo ótimo meu amigo", "Estou muito doente e precisava falar com você, será que poderia ir na farmácia pegar alguns remédios?", "Posso sim, quais?", "Pode pegar um Resfenol, pode ser aquele dia e noite, sabe qual é?", "Sei sim!!", "Excelente!!Muuuuuuuito obrigadooo!!", "Por nada!! espero que melhore logo"]
        
    }
    
    
    @IBAction func enviarMensagem(_ sender: Any) {
        
        if let textoDigitado = mensagemCaixaTexto.text {
            if !textoDigitado.isEmpty {
                if let idUsuarioDestinatario = contato["id"] as? String {
                    
                    let mensagem: Dictionary<String, Any> = [
                        "idUsuario" : idUsuarioLogado!,
                        "texto" : textoDigitado,
                        "data" : FieldValue.serverTimestamp()
                    ]
                
                    //salvar mensagem para remetente
                    salvarMensagem(idRemetente: idUsuarioLogado, idDestinatario: idUsuarioDestinatario, mensagem: mensagem)
                    
                    //salvar mensagem para o destinatário
                    salvarMensagem(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado, mensagem: mensagem)
                    
                }
            }
        }
        
    }
    
    func salvarMensagem(idRemetente: String, idDestinatario: String, mensagem: Dictionary<String, Any>) {
        
        db.collection("mensagens")
            .document( idRemetente )
            .collection( idDestinatario )
            .addDocument(data: mensagem)
        
        //limpar caixa de texto
        mensagemCaixaTexto.text = ""
        
    }
    
    func addListenerRecuperarMensagens() {
        
        if let idDestinatario = contato["id"] as? String {
            mensagensListener = db.collection("mensagens")
            .document( idUsuarioLogado )
            .collection( idDestinatario )
            .order(by: "data", descending: false)
                .addSnapshotListener { (querySnapshot, erro) in
                    
                    //limpa lista
                    self.listaMensagens.removeAll()
                    
                    //Recupera dados
                    if let snapshot = querySnapshot {
                        for document in snapshot.documents {
                            let dados = document.data()
                            self.listaMensagens.append(dados)
                        }
                        self.tableViewMensagens.reloadData()
                    }
                    
            }
        }
        
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
        let dados = self.listaMensagens[indice]
        let texto = dados["texto"] as? String
        let idUsuario = dados["idUsuario"] as? String
        
        if idUsuarioLogado == idUsuario {
            celulaDireita.mensagemDireitaLabel.text = texto
            return celulaDireita
        }else{
            celulaEsquerda.mensagemEsquerdaLabel.text = texto
            return celulaEsquerda
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        addListenerRecuperarMensagens()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        mensagensListener.remove()
        
    }

}

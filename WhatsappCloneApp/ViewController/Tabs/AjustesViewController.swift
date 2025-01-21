//
//  AjustesViewController.swift
//  WhatsappCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 20/01/25.
//

import UIKit
import FirebaseAuth

class AjustesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    var auth: Auth!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        auth = Auth.auth()
        
    }
    
    @IBAction func alterarImagem(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[ UIImagePickerController.InfoKey.originalImage ] as! UIImage
        
        self.imagem.image = imagemRecuperada
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deslogar(_ sender: Any) {
        
        do {
            try auth.signOut()
        } catch  {
            print("Erro ao deslogar usuário!")
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  SYSTEM View Controllers
//
//  Created by Talha Varol on 13.02.2022.
//
import MessageUI
import SafariServices
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    // MARK: - UI Elements
    @IBOutlet var imageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        imageView.image = selectedImage
        // bir viewcontrollerın ekrandan gitmesi için kullanılan fonk. dismiss denir
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    // MARK: - Actions
    @IBAction func shareBUttonTapped(_ button: UIButton)
    {
        guard let image = imageView.image else {return}
        
        //ActivityController nesnesi oluşturmak
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //Ekranda controller gösterir
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func safariBUttonTapped(_ button: UIButton)
    {
        if let url = URL(string: "https://apple.com"){
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
        
    }
    @IBAction func prohtosBUttonTapped(_ button: UIButton)
    {
        let imagePickerController = UIImagePickerController()
        // ImagePickerController'ın yöneticisi olan sııfın bu ViewController olduğunu belirtir.
        //Belirtmezsek Delegate fonksiyonları çalışmaz
        
        imagePickerController.delegate = self
        
        // actionSheet: Ekranın altından gelen sayfa
        // alert: Ekranın ortasında beliren pop-up'tır.
        
        let alertController = UIAlertController(title: "Görsel Kaynağı Seçin", message: nil, preferredStyle: .actionSheet)
        //aksiyonlar nelerdir?
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let cameraAction = UIAlertAction(title: "Kamera", style: .default) {
            (action) in // tıklandığınad ne yapılmalı onu yazman gerekli.
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        let photoLibrary = UIAlertAction(title: "Fotoğraf Galerisi", style: .default) { (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        //oluşturulan aksiyonlar uıalertcontroller'a eklemek
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibrary)
        
        //controller'ın ekranda gösterilmesi
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func emailBUttonTapped(_ button: UIButton)
    {
        // Öncelikle mail atılabilir mi bunu kontrol et!
        guard MFMailComposeViewController.canSendMail() else {return}
        // adım1 controller oluştur.
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["talhavarol@varol.com"])
        mailComposer.setSubject("Sswifte Çalış!")
        mailComposer.setMessageBody("günde minimum 4 saat swift çalışacaksın.", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
        
    }

}


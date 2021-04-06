//
//  ViewController.swift
//  RemoveBackgroundCoreML
//
//  Created by 영근 김 on 2021/04/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var originImage: UIImage?
    var backgroundImage: UIImage?
    var finalImage: UIImage?
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        // Do any additional setup after loading the view.
        let image = UIImage(named: "cat.jpg")
        originImage = image
        backgroundImage = image?.removeBackground(returnResult: .background)
        finalImage = image?.removeBackground(returnResult: .finalImage)
        imageView.image = originImage
        view.backgroundColor = .blue
    }

    @IBAction func changeImageAction(_ sender: Any) {
        if imageView.image == originImage {
            imageView.image = backgroundImage
        } else if imageView.image == backgroundImage {
            imageView.image = finalImage
        } else {
            imageView.image = originImage
        }
    }
    
    @IBAction func loadPhotoAction(_ sender: Any) {
        let alert = UIAlertController(title: "사진", message: "원하는 방식 선택", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "앨범", style: .default) { (action) in
            self.openLibrary()
        }
        
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            originImage = image
            backgroundImage = image.removeBackground(returnResult: .background)
            finalImage = image.removeBackground(returnResult: .finalImage)
            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
}

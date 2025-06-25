//
//  ThirdViewController.swift
//  Freela-onTap
//
//  Created by Ana Carolina Palhares Poletto on 23/06/25.
//

import UIKit

class ThirdViewController: UIViewController {
    // MARK: Description
    private lazy var orangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .DesignSystem.terracota600
        return view
    }()
    lazy var stepLabel: UILabel = {
        var label = UILabel()
        label.text = "Etapa 3 de 3"
        label.textColor = .label
        label.font = .DesignSystem.caption2
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lastStepLabel: UILabel = {
        var label = UILabel()
        label.text = "Última etapa, prometo!"
        label.textColor = .label
        label.font = .DesignSystem.title3Emphasized
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    lazy var lastStepDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Conte sobre seu estabelecimento e mostre uma foto do ambiente. Isso ajuda freelancers a conhecerem seu espaço e atrair os freelas certos."
        label.numberOfLines = 3
        label.textAlignment = .center
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var stepStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [lastStepLabel, lastStepDescriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Sobre seu negócio: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .DesignSystem.terracota0
        textField.layer.cornerRadius = 12
        textField.text = "Sunset Drinks é um bar descontraído, especializado em coquetelaria autoral e cervejas artesanais. Um espaço pra quem curte bons drinks, boa música e pôr do sol na faixa."
        textField.textColor = .labelsSecondary
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.font = .DesignSystem.subheadline
        textField.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 12)
        return textField
    }()
    
    lazy var limitLabel: UILabel = {
        var label = UILabel()
        label.text = "Limite de 2.000 caracteres"
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.caption2
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    lazy var descriptionStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextField, limitLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var photoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Anexar foto", for: .normal)
        button.setTitleColor(.DesignSystem.terracota600, for: .normal)
        button.backgroundColor = .DesignSystem.terracota100
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(photoAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: BigStack
    lazy var bigStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [stepStack, descriptionStack, photoButton, photoLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finalizar", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .DesignSystem.terracota600
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(photoAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var photoLabel: UILabel = {
        var label = UILabel()
        label.text = "Formatos compatíveis: JPG, JPEG, PNG, HEIC e TIFF."
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.caption2
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    lazy var selectedPhotoLabel: UILabel = {
        var label = UILabel()
        label.text = "Foto selecionada"
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.headline
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    lazy var selectedPhotoDescription: UILabel = {
        var label = UILabel()
        label.text = "Essa será a imagem do seu estabelecimento no app."
        label.textColor = .labelsSecondary
        label.numberOfLines = 2
        label.font = .DesignSystem.headline
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    lazy var changePhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Trocar imagem", for: .normal)
        button.titleLabel?.font = .DesignSystem.headline
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.DesignSystem.terracota600, for: .normal)
        button.backgroundColor = .tertiarySystemBackground
        button.addTarget(self, action: #selector(changePhotoAction), for: .touchUpInside)
        return button
    }()
    lazy var photoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [selectedPhotoLabel, selectedPhotoDescription, changePhotoButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return stack
    }()
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .DesignSystem.terracota600
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var photoisSelectedStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [imageView, photoStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.isHidden = true
        stack.layer.cornerRadius = 12
        stack.backgroundColor = .tertiarySystemBackground
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        return stack
    }()

    
    @objc func photoAction() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func finishAction() {
        let jobListVC = UINavigationController(rootViewController: JobListViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(jobListVC)
    }
    
    @objc func changePhotoAction() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        descriptionTextField.delegate = self
        setup()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ThirdViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(stepLabel)
        view.addSubview(bigStack)
        view.addSubview(finishButton)
        view.addSubview(orangeView)
        view.addSubview(photoisSelectedStack)
      
        title = "Cadastro de conta"
        view.backgroundColor = .DesignSystem.lavanda0
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stepLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stepLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            bigStack.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 22),
            bigStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bigStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            finishButton.heightAnchor.constraint(equalToConstant: 50),
            photoButton.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 112),
            photoisSelectedStack.heightAnchor.constraint(equalToConstant: 132),
            imageView.heightAnchor.constraint(equalToConstant: 112),
            imageView.widthAnchor.constraint(equalToConstant: 112),
            
            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            finishButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            finishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            photoisSelectedStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -282),
            photoisSelectedStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            photoisSelectedStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            orangeView.heightAnchor.constraint(equalToConstant: 4),
            orangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            orangeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    
    func adicionalSetup() {
        navigationItem.hidesBackButton = true
    }
}
extension ThirdViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Sunset Drinks é um bar descontraído, especializado em coquetelaria autoral e cervejas artesanais. Um espaço pra quem curte bons drinks, boa música e pôr do sol na faixa." {
            textView.text = ""
            textView.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Sunset Drinks é um bar descontraído, especializado em coquetelaria autoral e cervejas artesanais. Um espaço pra quem curte bons drinks, boa música e pôr do sol na faixa."
            textView.textColor = .secondaryLabel
        }
    }
}

extension ThirdViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            photoisSelectedStack.isHidden = false
        }
    }
}

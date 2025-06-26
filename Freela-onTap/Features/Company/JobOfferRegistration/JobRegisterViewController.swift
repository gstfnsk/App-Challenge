//
//  JobRegisterViewController.swift
//  Freela-onTap
//
//  Created by Ana Carolina Palhares Poletto on 24/06/25.
//
import UIKit

class JobRegisterViewController: UIViewController {
    // MARK: Description
    private lazy var orangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .DesignSystem.terracota600
        return view
    }()
    lazy var stepLabel: UILabel = {
        var label = UILabel()
        label.text = "Etapa 1 de 2"
        label.textColor = .label
        label.font = .DesignSystem.caption2
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var lastStepLabel: UILabel = {
        var label = UILabel()
        label.text = "Precisa de reforço?"
        label.textColor = .label
        label.font = .DesignSystem.title3Emphasized
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    lazy var lastStepDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Cadastre as informações da vaga, descreva as funções e conecte-se com profissionais disponíveis."
        label.numberOfLines = 2
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
    lazy var functionLabel: UILabel = {
        var label = UILabel()
        label.text = "Função: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var functionSelector: FunctionSelector = {
        return FunctionSelector()
    }()
    
    lazy var functionInput: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [functionLabel, functionSelector])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var moneyLabel: UILabel = {
        var label = UILabel()
        label.text = "Remuneração: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var reaisLabel: UILabel = {
        var label = UILabel()
        label.text = "R$"
        label.textColor = .DesignSystem.terracota600
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 17)
        label.layer.cornerRadius = 12
        return label
    }()
    lazy var reaisStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [reaisLabel])
        stack.layer.cornerRadius = 12
        stack.backgroundColor = .tertiarySystemBackground
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private lazy var textField: InsetedTextField = {
        let textField = InsetedTextField(insetX: 16, insetY: 10)
        textField.font = .DesignSystem.body
        textField.textColor = .label
        textField.placeholder = "120,00"
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    lazy var money: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [reaisStack, textField])
        stack.bringSubviewToFront(reaisStack)
        stack.spacing = -15
        return stack
    }()
    
    lazy var moneyInput: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [moneyLabel, money])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "Data: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .DesignSystem.terracota600
        datePicker.addTarget(self, action: #selector(dateChanged), for: .editingDidEnd)
        datePicker.locale = Locale(identifier: "pt_BR")
        return datePicker
    }()
    lazy var dateStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dateLabel, datePicker])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        return stack
    }()
    
    lazy var date: UILabel = {
        var label = UILabel()
        label.text = "aud"
        label.textColor = .DesignSystem.terracota600
        label.font = .DesignSystem.body
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray5
        return label
    }()
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: sender.date)
        
        date.text = dateString
        date.isHidden = false
        date.textColor = .DesignSystem.terracota600
    }
    
    lazy var timeLabel: UILabel = {
        var label = UILabel()
        label.text = "Horário: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var timePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.tintColor = .DesignSystem.terracota600
        datePicker.addTarget(self, action: #selector(timeChanged), for: .editingDidEnd)
        return datePicker
    }()
    
    lazy var timeStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [timeLabel, timePicker])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        return stack
    }()
    
    lazy var time: UILabel = {
        var label = UILabel()
        label.text = "aud"
        label.textColor = .DesignSystem.terracota600
        label.font = .DesignSystem.body
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray5
        return label
    }()
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateString = formatter.string(from: sender.date)
        
        time.text = dateString
        time.isHidden = false
        time.textColor = .DesignSystem.terracota600
    }
    
    lazy var hourLabel: UILabel = {
        var label = UILabel()
        label.text = "Jornada: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var hourPickerWheel: HourOnlyPickerView = {
        let datePicker = HourOnlyPickerView()
        datePicker.isHidden = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let hourPicker: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("6h", for: .normal)
        button.setTitleColor(.labelsPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(showHourPicker), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        return button
    }()
    
    @objc func showHourPicker() {
        hourPickerWheel.isHidden = false
    }
    
    lazy var hourStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [hourLabel, hourPicker])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()

    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Atribuições, requisitos e detalhes da vaga: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .DesignSystem.terracota0
        textField.layer.cornerRadius = 12
        textField.text = "Atendimento ao público, anotar pedidos, servir alimentos e bebidas, organizar mesas, apoiar na limpeza e organização do salão e repor itens quando necessário."
        textField.textColor = .labelsSecondary
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.font = .DesignSystem.subheadline
        textField.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 12)
        return textField
    }()

    lazy var limitLabel: UILabel = {
        var label = UILabel()
        label.text = "Importante conter todos os principais pontos do freela."
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.caption2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var timeDayInformaion: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dateStack, timeStack, hourStack])
        stack.spacing = 48
        return stack
    }()
    
    lazy var inputStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [functionInput, moneyInput, timeDayInformaion])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    lazy var descriptionStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextField, limitLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    // MARK: BigStack
    lazy var bigStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [stepStack, inputStack, descriptionStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    lazy var coninueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .DesignSystem.terracota600
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.DesignSystem.terracota600, for: .normal)
        button.backgroundColor = .tertiarySystemBackground
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [coninueButton, cancelButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false 
        return stack
    }()
    

    @objc func continueAction() {
        let jobListVC = UINavigationController(rootViewController: JobListViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(jobListVC)
    }
    @objc func cancelButtonAction() {
        let jobListVC = UINavigationController(rootViewController: JobListViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(jobListVC)
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

extension JobRegisterViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(stepLabel)
        view.addSubview(bigStack)
        view.addSubview(orangeView)
        view.addSubview(buttonStack)
        view.addSubview(date)
        view.addSubview(time)
        view.addSubview(hourPickerWheel)
        
        hourPickerWheel.onHourSelected = { [weak self] selectedHour in
            guard let self = self else {
                return
            }
            self.hourPicker.setTitle(String(format: "%02dh", selectedHour), for: .normal)
            self.hourPicker.setTitleColor(.DesignSystem.terracota600, for: .normal)
            self.hourPickerWheel.isHidden = true
        }

        title = "Cadastro de Vaga"
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
            dateStack.widthAnchor.constraint(equalToConstant: 115),
            timeStack.widthAnchor.constraint(equalToConstant: 70),
            textField.widthAnchor.constraint(equalToConstant: 330),
            
            date.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 356),
            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            date.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -266),
            
            time.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 356),
            time.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 193),
            time.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -155),

            bigStack.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 22),
            bigStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bigStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            coninueButton.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 112)
            ,
            hourPicker.heightAnchor.constraint(equalTo: timePicker.heightAnchor),
            hourPicker.widthAnchor.constraint(equalToConstant: 60),

            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54),
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            orangeView.heightAnchor.constraint(equalToConstant: 4),
            orangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            orangeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -197),
            
            hourPickerWheel.topAnchor.constraint(equalTo: view.topAnchor, constant: 374),
            hourPickerWheel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 280),
            hourPickerWheel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            hourPickerWheel.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

extension JobRegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Atendimento ao público, anotar pedidos, servir alimentos e bebidas, organizar mesas, apoiar na limpeza e organização do salão e repor itens quando necessário." {
            textView.text = ""
            textView.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Atendimento ao público, anotar pedidos, servir alimentos e bebidas, organizar mesas, apoiar na limpeza e organização do salão e repor itens quando necessário."
            textView.textColor = .secondaryLabel
        }
    }
}

class HourOnlyPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    let picker = UIPickerView()
    var onHourSelected: ((Int) -> Void)?

    let hours = Array(0...12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        picker.delegate = self
        picker.dataSource = self
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: topAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(hours[row])h"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onHourSelected?(hours[row])
    }
}

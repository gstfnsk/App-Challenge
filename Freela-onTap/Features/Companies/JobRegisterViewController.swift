//
//  JobRegisterViewController.swift
//  Freela-onTap
//
//  Created by Ana Carolina Palhares Poletto on 24/06/25.
//
import UIKit

class JobRegisterViewController: UIViewController {
    // MARK: Description
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var orangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .DesignSystem.terracota600
        return view
    }()
    
    private lazy var overlayView: UIView = {
        let view = GradientOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
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
        let function = FunctionSelector()
        function.onSelectionChanged = { [weak self] in
            self?.validateForm()
        }
        return function
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
    
    private lazy var moneyTextField: InsetedTextField = {
        let textField = InsetedTextField(insetX: 16, insetY: 10)
        textField.font = .DesignSystem.body
        textField.textColor = .label
        textField.placeholder = "120,00"
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 12
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(validateForm), for: .editingChanged)
        return textField
    }()
    
    lazy var money: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [reaisStack, moneyTextField])
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
    
    private var selectedDate: Date?
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        
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
    
    private var duration: String?
    
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
        duration = hourPicker.titleLabel?.text
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
        label.text = "Descrição da vaga: "
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .DesignSystem.terracota0
        textField.layer.cornerRadius = 12
        textField.text = "Buscamos alguém para integrar a equipe, com foco em bom atendimento, atenção aos detalhes e paixão pelo que faz.."
        textField.textColor = .labelsSecondary
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.font = .DesignSystem.subheadline
        textField.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 12)
        textField.delegate = self
        return textField
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
        var stack = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var responsabilitiesLabel: UILabel = {
        var label = UILabel()
        label.text = "Responsabilidades"
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var responsabilitiesTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .DesignSystem.terracota0
        textField.layer.cornerRadius = 12
        textField.text = """
        • Atender clientes com cordialidade
        • Organizar reservas e fila de espera
        • Apoiar equipe de salão e cozinha.
        """
        textField.textColor = .labelsSecondary
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.font = .DesignSystem.subheadline
        textField.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 12)
        textField.delegate = self
        return textField
    }()
    
    lazy var responsabilitiesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [responsabilitiesLabel, responsabilitiesTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var dutiesLabel: UILabel = {
        var label = UILabel()
        label.text = "Obrigações"
        label.textColor = .labelsSecondary
        label.font = .DesignSystem.subheadline
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var dutiesTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .DesignSystem.terracota0
        textField.layer.cornerRadius = 12
        textField.text = """
                    • Experiência em atendimento ao público
                    • Boa comunicação verbal e escrita
                    • Fluência em português (inglês é um diferencial)
                    """
        textField.textColor = .labelsSecondary
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.font = .DesignSystem.subheadline
        textField.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 12)
        textField.delegate = self
        return textField
    }()
    
    lazy var dutiesStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dutiesLabel, dutiesTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    
    // MARK: BigStack
    lazy var bigStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [stepStack, inputStack, descriptionStack, responsabilitiesStack, dutiesStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.DesignSystem.terracota0, for: .normal)
        button.backgroundColor = .systemGray4
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
        var stack = UIStackView(arrangedSubviews: [continueButton, cancelButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @objc func validateForm() {
        let isTextFilled = !(moneyTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isFunctionSelected = functionSelector.selectedFunction != nil

        let defaultDescription = "Buscamos alguém para integrar a equipe, com foco em bom atendimento, atenção aos detalhes e paixão pelo que faz.."
        let defaultResponsabilities = """
    • Atender clientes com cordialidade
    • Organizar reservas e fila de espera
    • Apoiar equipe de salão e cozinha.
    """
        let defaultDuties = """
    • Experiência em atendimento ao público
    • Boa comunicação verbal e escrita
    • Fluência em português (inglês é um diferencial)
    """

        let descriptionText = descriptionTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let responsabilitiesText = responsabilitiesTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let dutiesText = dutiesTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)

        let isDescriptionFilled = !descriptionText.isEmpty && descriptionText != defaultDescription
        let isResponsabilitiesFilled = !responsabilitiesText.isEmpty && responsabilitiesText != defaultResponsabilities
        let isDutiesFilled = !dutiesText.isEmpty && dutiesText != defaultDuties

        let isFormValid = isTextFilled && isFunctionSelected && isDescriptionFilled && isResponsabilitiesFilled && isDutiesFilled
        // MUDAR AQUI DEPOOOISSSSS
        continueButton.isEnabled = isFormValid
        continueButton.backgroundColor = isFormValid ? .DesignSystem.terracota600 : .systemGray4
        
        print("Form válido?", isFormValid)
        print("Botão está habilitado?", continueButton.isEnabled)
    }

    @objc func continueAction() {
        let job = functionSelector.selectedFunction
        let date = selectedDate
        let stringHour = time.text
        let hourComponent = stringHour?.split(separator: ":").first?.trimmingCharacters(in: .whitespacesAndNewlines)
        let hour = Int(hourComponent ?? "")
        let stringSalary = moneyTextField.text ?? ""

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR") // para aceitar "100,00"
        
        let description = descriptionTextField.text
        let qualifications = responsabilitiesTextField.text
        let duties = dutiesTextField.text
            
        print("clicou")
//        print("job: \(String(describing: job))")
//        print("date: \(String(describing: date))")
//        print("stringHour: \(String(describing: stringHour))")
//        print("hourComponent: \(String(describing: hourComponent))")
//        print("hour: \(String(describing: hour))")
//        print("stringSalary: \(String(describing: stringSalary))")
//        print("salary: \(String(describing: salary))")
//        print("description: \(String(describing: description))")
//        print("qualifications: \(String(describing: qualifications))")
//        print("duties: \(String(describing: duties))")


        if let job,
           let date,
           let duration,
           // ESSE HOUR é o horário que começa.. tem que ser passado por fora!
           let hour,
           let number = formatter.number(from: stringSalary),
           let description,
           let qualifications,
           let duties {
            let salary = Int(truncating: number)
            let numberDuration = duration.replacingOccurrences(of: "h", with: "")
            let intDuration = Int(numberDuration) ?? 00
            let newJob = JobOffer (
                
                
                id: UUID(),
                companyId: UUID(), // AINDA NAO TEMOS
                postedAt: date,
                title: job,
                // esse HOUR NAO ´E DURATION E HOrario que eu começo
                durationInHours: intDuration,
                startDate: datePicker.date,
                salaryBRL: salary,
                description: description,
                qualifications: qualifications,
                duties: duties
            )
            
            let jobregister2 = JobRegister2ViewController()
            jobregister2.jobOffer = newJob
            jobregister2.begginingHour = hour
            navigationController?.pushViewController(jobregister2, animated: true)
        }
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
        responsabilitiesTextField.delegate = self
        dutiesTextField.delegate = self
        setup()
        validateForm()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension JobRegisterViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)
        contentView.addSubview(bigStack)
        contentView.addSubview(stepLabel)
        contentView.addSubview(orangeView)
        contentView.addSubview(date)
        contentView.addSubview(time)
        contentView.addSubview(hourPickerWheel)
        contentView.addSubview(buttonStack)
        
        
        hourPickerWheel.onHourSelected = { [weak self] selectedHour in
            guard let self else {
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
            // scrollView na tela
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // contentView dentro da scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // conteúdo dentro da contentView
            stepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stepLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            date.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 325),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -266),
            
            time.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 325),
            time.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 191),
            time.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -155),
            
            bigStack.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 24),
            bigStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bigStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bigStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -175), // <- FECHA A SCROLL
            
            
            buttonStack.heightAnchor.constraint(equalToConstant: 112),
            buttonStack.widthAnchor.constraint(equalToConstant: 321),
            buttonStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
            
            // continua fora da scroll
            orangeView.heightAnchor.constraint(equalToConstant: 4),
            orangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orangeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -197),
            
            hourPickerWheel.topAnchor.constraint(equalTo: view.topAnchor, constant: 374),
            hourPickerWheel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 280),
            hourPickerWheel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            hourPickerWheel.heightAnchor.constraint(equalToConstant: 180),
            
            // alturas e larguras fixas
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 112),
            dutiesTextField.heightAnchor.constraint(equalToConstant: 112),
            responsabilitiesTextField.heightAnchor.constraint(equalToConstant: 112),
            
            dateStack.widthAnchor.constraint(equalToConstant: 115),
            timeStack.widthAnchor.constraint(equalToConstant: 70),
            moneyTextField.widthAnchor.constraint(equalToConstant: 330),
            hourPicker.heightAnchor.constraint(equalTo: timePicker.heightAnchor),
            hourPicker.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension JobRegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let placeholderDescription = "Buscamos alguém para integrar a equipe, com foco em bom atendimento, atenção aos detalhes e paixão pelo que faz.."
        let placeholderResponsabilities = """
        • Atender clientes com cordialidade
        • Organizar reservas e fila de espera
        • Apoiar equipe de salão e cozinha.
        """
        
        let placeholderDuties = """
        • Experiência em atendimento ao público
        • Boa comunicação verbal e escrita
        • Fluência em português (inglês é um diferencial)
        """
        
        if textView.text == placeholderDescription
            || textView.text == placeholderResponsabilities
            || textView.text == placeholderDuties
        {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextField.text.isEmpty {
            textView.text = "Buscamos alguém para integrar a equipe, com foco em bom atendimento, atenção aos detalhes e paixão pelo que faz.."
            textView.textColor = .secondaryLabel
        } else if responsabilitiesTextField.text.isEmpty {
            responsabilitiesTextField.text = """
            • Atender clientes com cordialidade
            • Organizar reservas e fila de espera
            • Apoiar equipe de salão e cozinha.
            """
            textView.textColor = .secondaryLabel
        } else if dutiesTextField.text.isEmpty {
            dutiesTextField.text = """
            • Experiência em atendimento ao público
            • Boa comunicação verbal e escrita
            • Fluência em português (inglês é um diferencial)
            """
            textView.textColor = .secondaryLabel
        } else {
            textView.textColor = .label
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        validateForm()
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

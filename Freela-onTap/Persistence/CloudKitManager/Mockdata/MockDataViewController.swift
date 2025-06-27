import UIKit

class MockDataViewController: UIViewController {
    // MARK: - Properties
    let persistenceManager = CloudKitManager.shared

    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mock Data Control"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This tool will completely erase all existing data from the database and repopulate it with a standard set of mock data. This is useful for development and testing."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var companyCountLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        label.text = "Companies to be created: ..."
        return label
    }()
    
    private lazy var jobCountLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        label.text = "Job Offers to be created: ..."
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.isHidden = true
        return progressView
    }()

    private lazy var resetButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Reset and Populate Database"
        config.baseBackgroundColor = .systemRed
        config.cornerStyle = .medium
        config.image = UIImage(systemName: "trash.fill")
        config.imagePadding = 8
        
        return UIButton(configuration: config, primaryAction: UIAction { [weak self] _ in
            self?.presentConfirmationAlert()
        })
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            infoContainerView,
            resetButton,
            statusLabel,
            progressView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.setCustomSpacing(12, after: titleLabel)
        stack.setCustomSpacing(30, after: infoContainerView)
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadMockDataSummary()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Developer Tools"

        view.addSubview(mainStackView)
        
        let infoStack = UIStackView(arrangedSubviews: [companyCountLabel, jobCountLabel])
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .vertical
        infoStack.spacing = 8
        
        infoContainerView.addSubview(infoStack)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoStack.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 16),
            infoStack.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -16),
            infoStack.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Logic
    
    /// Fetches the summary from the persistence layer and updates the UI.
    private func loadMockDataSummary() {
        // Now using the clean, static property from our extension.
        let summary = CloudKitManager.mockDataSummary
        companyCountLabel.text = "Companies to be created: \(summary.companyCount)"
        jobCountLabel.text = "Job Offers to be created: \(summary.jobCount)"
    }
    
    /// Presents an alert to confirm the destructive action.
    private func presentConfirmationAlert() {
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "This action is irreversible. All current company and job offer data in the database will be deleted before repopulating.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let resetAction = UIAlertAction(title: "Reset Data", style: .destructive) { [weak self] _ in
            self?.executeDataReset()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        present(alert, animated: true)
    }

    /// This function orchestrates the data reset and population process,
    /// passing a progress handler to the persistence layer.
    private func executeDataReset() {
        print("Starting database reset...")

        Task {
            await MainActor.run {
                resetButton.isEnabled = false
                statusLabel.textColor = .secondaryLabel
                statusLabel.text = "Starting..."
                progressView.setProgress(0, animated: false)
                statusLabel.isHidden = false
                progressView.isHidden = false
            }

            let progressHandler: (Double, String) -> Void = { [weak self] progress, status in
                Task {
                    await MainActor.run {
                        self?.statusLabel.text = status
                        self?.progressView.setProgress(Float(progress), animated: true)
                    }
                }
            }

            do {
                try await persistenceManager.deleteAllMockData(progressHandler: progressHandler)
                try await persistenceManager.addMockCompaniesAndJobs(progressHandler: progressHandler)
                
                await MainActor.run {
                    progressView.setProgress(1.0, animated: true)
                    statusLabel.textColor = .systemGreen
                    statusLabel.text = "✅ Completed successfully!"
                }
                print("✅ Database reset and population completed successfully!")
            } catch {
                await MainActor.run {
                    statusLabel.textColor = .systemRed
                    statusLabel.text = "❌ Operation Failed\n\(error.localizedDescription)"
                    progressView.setProgress(0, animated: true)
                }
                print("❌ An error occurred: \(error.localizedDescription)")
            }

            await MainActor.run {
                resetButton.isEnabled = true
            }
        }
    }
    
    // The duplicated mock data functions have been removed.
}

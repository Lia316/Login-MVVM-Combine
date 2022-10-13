//
//  ViewController.swift
//  Login+Combine
//
//  Created by 리아 on 2022/10/03.
//

import Combine
import SwiftUI
import UIKit

final class ViewController: UIViewController {

    private let idTextField = UITextField()
    private let pwTextField = UITextField()
    private let idValidView = UIView()
    private let pwValidView = UIView()
    private let loginButton = UIButton()
    
    private let viewModel = ViewModel()
    
    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureUI()
        bindUI()
    }

}

// MARK: - TextField Interaction

extension ViewController {
    
    private func bindUI() {
        // Input
        idTextField.publisher
            .assign(to: \.idText, on: viewModel)
            .store(in: &cancelBag)
        
        pwTextField.publisher
            .assign(to: \.pwText, on: viewModel)
            .store(in: &cancelBag)
        
        // Output
        viewModel.$isIDValid
            .sink { [weak self] isValid in
                self?.idValidView.isHidden = isValid
            }
            .store(in: &cancelBag)
        
        viewModel.$isPWValid
            .sink { [weak self] isValid in
                self?.pwValidView.isHidden = isValid
            }
            .store(in: &cancelBag)
        
        viewModel.$isBothValid
            .sink { [weak self] isValid in
                let color = isValid ? UIColor.systemBlue : UIColor.systemGray
                self?.loginButton.backgroundColor = color
            }
            .store(in: &cancelBag)
    }
    
}


// MARK: - UI

extension ViewController {
    
    private func configureLayout() {
        let hPadding: CGFloat = 50
        let vPadding: CGFloat = 40
        
        [idTextField, pwTextField,
         idValidView, pwValidView, loginButton].forEach { subview in
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: hPadding),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -hPadding),
            idTextField.heightAnchor.constraint(equalToConstant: vPadding),
            idTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: vPadding)])
        
        NSLayoutConstraint.activate([
            pwTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: hPadding),
            pwTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -hPadding),
            pwTextField.heightAnchor.constraint(equalToConstant: vPadding),
            pwTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor,
                                             constant: vPadding)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: hPadding),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -hPadding),
            loginButton.heightAnchor.constraint(equalToConstant: vPadding),
            loginButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor,
                                             constant: vPadding)
        ])
        
        let sPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            idValidView.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor, constant: -sPadding),
            idValidView.topAnchor.constraint(equalTo: idTextField.topAnchor, constant: sPadding),
            idValidView.bottomAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: -sPadding),
            idValidView.widthAnchor.constraint(equalTo: idValidView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pwValidView.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor, constant: -sPadding),
            pwValidView.topAnchor.constraint(equalTo: pwTextField.topAnchor, constant: sPadding),
            pwValidView.bottomAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: -sPadding),
            pwValidView.widthAnchor.constraint(equalTo: pwValidView.heightAnchor)
        ])

    }
    
    private func configureUI() {
        idTextField.placeholder = "id"
        pwTextField.placeholder = "password"
        idTextField.borderStyle = .roundedRect
        pwTextField.borderStyle = .roundedRect
        
        idValidView.backgroundColor = .systemRed
        pwValidView.backgroundColor = .systemRed
        
        loginButton.setTitle("Log in", for: .normal)
        loginButton.backgroundColor = .systemGray
        loginButton.layer.cornerRadius = 10
    }
    
}

struct ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        ViewController().toPreview()
    }
    
}

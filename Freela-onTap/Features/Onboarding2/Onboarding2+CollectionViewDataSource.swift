//
//  Onboarding+DataSource.swift
//  App-Challenge
//
//  Created by Gustavo Ferreira bassani on 18/06/25.
//

import UIKit

extension Onboarding2: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Onboarding2Cell.identifier, for: indexPath) as? Onboarding2Cell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            let fullText = NSMutableAttributedString()
            let text1 = NSAttributedString(
                string: "Encontre ",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 40, weight: .medium)
                ]
            )
            
            let text2 = NSAttributedString(
                string: "freelas ",
                attributes: [
                    .font: UIFont(name: "PPValve-PlainMedium", size: 40) ?? UIFont.systemFont(ofSize: 40)
                ]
            )
            
            let text3 = NSAttributedString(
                string: "beeeeeem perto de você!",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 40, weight: .medium)
                ]
            )
            fullText.append(text1)
            fullText.append(text2)
            fullText.append(text3)
            cell.configure(title: fullText, subtitle: "Filtre por cargos e saiba tudo sobre a vaga.", imageName: "phone1")
        } else {
            let fullText = NSMutableAttributedString()
            let text1 = NSAttributedString(
                string: "Monte a escala do seu time com ",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 40, weight: .medium)
                ]
            )

            let text2 = NSAttributedString(
                string: "agilidade",
                attributes: [
                    .font: UIFont(name: "PPValve-PlainMedium", size: 40) ?? UIFont.systemFont(ofSize: 40)
                ]
            )
            fullText.append(text1)
            fullText.append(text2)
            cell.configure(title: fullText, subtitle: "", imageName: "phone2")
        }
        return cell
    }
}

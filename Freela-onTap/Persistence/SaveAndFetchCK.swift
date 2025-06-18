//
//  SaveAndFetchCK.swift
//  App-Challenge
//
//  Created by Gustavo Ferreira bassani on 11/06/25.
//

import CloudKit
// test

struct Vacancies {
    var name: String
    var description: String
    var UUID: UUID
}

class SavingAndFetchOnCK {
    static var muralRecords: [CKRecord] = []
    // Cria uma referência ao container CloudKit específico pelo identificador
    static let container = CKContainer(identifier: "iCloud.app.freela.OnTap")
    
    static func savePublicData(nameInput: String, descriptionInput: String) {
        // Pega o banco de dados público desse container
        let publicDB = container.publicCloudDatabase
        
        let newVacancie = Vacancies(name: nameInput, description: descriptionInput, UUID: UUID())
        
        // Cria um novo registro do tipo "Mural" (entidade no CloudKit)
        let recordID = CKRecord.ID(recordName: newVacancie.UUID.uuidString)
        let record = CKRecord(recordType: "vacancies", recordID: recordID)
        
        
        // Define o valor "Olá, mundo" para o campo "mensagem" do registro
        record["name"] = newVacancie.name as CKRecordValue
        
        // Define o valor "Gustavo" para o campo "autor" do registro
        record["description"] = newVacancie.description as CKRecordValue
        
        // Salva o registro no banco público
        publicDB.save(record) { savedRecord, error in
            // Verifica se houve erro durante a operação de salvamento
            if let error {
                print("erro ao salvar no banco público: \(error)")
            } else {
                // Se salvou com sucesso, imprime o ID do registro salvo
                print("registro salvo com sucesso no público: \(savedRecord?.recordID.recordName ?? "")")
            }
        }
    }
    
    static func fetchMuralRecordByID(recordName: String) {
        let publicDB = container.publicCloudDatabase
        let recordID = CKRecord.ID(recordName: recordName)
        
        publicDB.fetch(withRecordID: recordID) { record, error in
            if let error  {
                print("Erro ao buscar registro: \(error)")
                return
            }
            
            if let record  {
                print("Registro encontrado:")
                print("Mensagem: \(record["mensagem"] ?? "")")
                print("Autor: \(record["autor"] ?? "")")
                
                DispatchQueue.main.async {
                    self.muralRecords = [record] // substitui pelos dados buscados
                }
            } else {
                print("Registro não encontrado.")
            }
        }
    }
}

//
//  Company.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 10/06/25.
//
import Foundation
import UIKit

struct Company {
    var name: String
    var establishmentType: Establishment
    var cnpj: String
    var address: String
    var description: String
    var companySize: String
    var photo: String //Depois trocar para como pretendemos fazer upload da foto
    var whatsappNumber: String
    var email: String
    var password: String
}

enum Establishment: String {
    case restaurant
    case bar
    case coffeeshop
    case other
}


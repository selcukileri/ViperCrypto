//
//  Presenter.swift
//  CryptoViper
//
//  Created by Selçuk İleri on 6.11.2023.
//

import Foundation

// Class, protocol
// talks to -> interacter, router, view

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto (result: Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case.failure(_):
            view?.update(with: "Try again later..")
        }
    }
    
    
}

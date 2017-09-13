//
//  Object+Rx.swift
//
//  Created by suguru-kishimoto on 2017/09/13.
//
import Foundation
import Firebase
import RxSwift

extension Reactive where Base: Object {
    public func save() -> Observable<DatabaseReference> {
        return .create { [weak base] observer in
            base?.save { (ref, error) in
                if let error = error {
                    observer.on(.error(error))
                } else if let ref = ref {
                    observer.on(.next(ref))
                    observer.on(.completed)
                } else {
                    observer.on(.error(NSError(domain: "", code: 0, userInfo: nil)))
                }
            }
            return Disposables.create()
        }
    }
}

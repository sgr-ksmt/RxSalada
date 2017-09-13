//
//  Firebase+Rx.swift
//  Lesson
//
//  Created by suguru-kishimoto on 2017/09/13.
//

import Foundation
import Firebase
import RxSwift

extension Reactive where Base: Referenceable {
    public static func observeSingle(_ id: String, eventType: DataEventType) -> Observable<Base?> {
        return .create { observer in
            Base.observeSingle(id, eventType: eventType) { object in
                observer.on(.next(object))
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }
    public static func observeSingle(_ eventType: DataEventType) -> Observable<[Base]> {
        return .create { observer in
            Base.observeSingle(eventType) { objects in
                observer.on(.next(objects))
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    public static func observeSingle(child property: String, equal value: Any, eventType: DataEventType) -> Observable<[Base]> {
        return .create { observer in
            Base.observeSingle(child: property, equal: value, eventType: eventType) { objects in
                observer.on(.next(objects))
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    public static func observe(_ eventType: DataEventType) -> Observable<[Base]> {
        return .create { observer in
            let disposer: Disposer<Base> = Base.observe(eventType) { objects in
                observer.on(.next(objects))
            }
            return Disposables.create {
                disposer.dispose()
            }
        }
    }

    public static func observe(_ id: String, eventType: DataEventType) -> Observable<Base?> {
        return .create { observer in
            let disposer: Disposer<Base> = Base.observe(id, eventType: eventType) { object in
                observer.on(.next(object))
            }
            return Disposables.create {
                disposer.dispose()
            }
        }
    }

}

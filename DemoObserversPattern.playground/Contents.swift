////: A UIKit based Playground for presenting user interface
//
import UIKit
import PlaygroundSupport


//Apple Objc Library
@objcMembers public class KVOUser: NSObject {
    // 2
    dynamic var name: String
    // 3
    public init(name: String) {
        self.name = name
    }
}

// 1
print("-- KVO Example -- ")
// 2
let kvoUser = KVOUser(name: "Ray")
// 3


var kvoObserver: NSKeyValueObservation? =
    kvoUser.observe(\.name, options: [.initial, .new]) {
        (user, change) in
        print("User's name is \(user.name)")
}

kvoUser.name = "Rockin' Ray"

kvoObserver = nil
kvoUser.name = "Ray has left the building"


//Custom
class Observable<Type>
{
    fileprivate class Callback
    {
        fileprivate weak var observer: AnyObject?
        fileprivate let options: [ObserableOptions]
        fileprivate let closure: (Type, ObserableOptions) -> Void
        
        fileprivate init(observer: AnyObject,
                         options: [ObserableOptions],
                         closure: @escaping (Type, ObserableOptions) -> Void)
        {
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }
    // MARK: - Properties
    var value: Type {
        didSet {
            removeNilObserverCallbacks()
            notifyCallbacks(value: oldValue, option: .old)
            notifyCallbacks(value: value, option: .new)
        }
    }
    
    private func removeNilObserverCallbacks() {
        callbacks = callbacks.filter { $0.observer != nil }
    }
    
    private func notifyCallbacks(value: Type, option: ObserableOptions)
    {
        let callbacksToNotify = callbacks.filter {
            $0.options.contains(option)
        }
        callbacksToNotify.forEach { $0.closure(value, option) }
    }
    
    // MARK: - Object Lifecycle
    init(_ value: Type)
    {
        self.value = value
    }
    
    // MARK: - Managing Observers
    private var callbacks: [Callback] = []
    
    func addObserver(_ observer: AnyObject,
                     removeIfExist: Bool = true,
                     options: [ObserableOptions] = [.new],
                     closure: @escaping (Type, ObserableOptions) -> Void) -> Void
    {
        if removeIfExist {
            removeObserver(observer)
        }
        
         let callback = Callback(observer: observer, options: options, closure: closure)
         callbacks.append(callback)
        
        if options.contains(.initial)
        {
            closure(value, .initial)
        }
    }
    
    func removeObserver(_ observer: AnyObject)
    {
        callbacks = callbacks.filter { $0.observer !== observer }
    }
}

struct ObserableOptions: OptionSet
{
    static let initial = ObserableOptions(rawValue: 1 << 0)
    static let old = ObserableOptions(rawValue: 1 << 1)
    static let new = ObserableOptions(rawValue: 1 << 2)
    
    var rawValue: Int
    
    init(rawValue: Int)
    {
        self.rawValue = rawValue
    }
}

// MARK: - Observable Example
class User {
     let name: Observable<String>
     init(name: String) {
        self.name = Observable(name)
    }
}

public class Observer { }

// 1
print("")
print("-- Observable Example--")
// 2
let user = User(name: "Madeline")
// 3
var observer2: Observer? = Observer()
user.name.addObserver(observer2!, removeIfExist: true, options: [.initial, .new]) { (name, change) in
    print("User's name is \(name)")
}

user.name.removeObserver(observer2!)
user.name.value = "Amelia is outta here"



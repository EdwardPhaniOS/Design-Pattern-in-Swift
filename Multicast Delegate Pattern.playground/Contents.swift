import UIKit

var str = "Hello, playground"

 // MARK: - MulticastDelegate

class MulticastDelegate<ProtocolType> {
    
    // MARK: - Delegate Wrapper
    
    private class DelegateWrapper {
        weak var delegate: AnyObject?
        
        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }
    
    // MARK: - Instance Properties
    
    private var delegateWrappers: [DelegateWrapper]
    
    var delegates: [ProtocolType] {
        delegateWrappers = delegateWrappers.filter( { $0.delegate != nil } )
        return delegateWrappers.map({ $0.delegate! }) as! [ProtocolType]
    }
    
    // MARK: - Object Lifecycle
    
    init(delegates: [ProtocolType] = []) {
        delegateWrappers = delegates.map({
            DelegateWrapper($0 as AnyObject)
        })
    }
    
    // MARK: - Delegate Management
    func adđDelegate(_ delegate: ProtocolType) {
        let wrapper = DelegateWrapper(delegate as AnyObject)
        delegateWrappers.append(wrapper)
    }
    
    func removeDelegate(_ delegate: ProtocolType) {
        guard let index = delegateWrappers.index(where: {
            $0.delegate === (delegate as AnyObject)
        }) else { return }
        delegateWrappers.remove(at: index)
    }
    
    func invokeDelegates(_ closure: (ProtocolType) -> ()) {
        self.delegates.forEach { closure($0) }
    }
}

// MARK: - Delegate Protocol
protocol EmergencyResponding {
    func notifyFire(at location: String)
    func notifyCarCash(at location: String)
}

// MARK: - Delegates
class FireStation: EmergencyResponding {
    
    func notifyFire(at location: String) {
        print("Firefighters were notified about a fire at "
            + location)
    }
    
    func notifyCarCash(at location: String) {
        print("Firefighters were notified about a car crash at "
            + location)
    }
}

class PoliceStation: EmergencyResponding {
    func notifyFire(at location: String) {
        print("Police were notified about a fire at "
            + location)
    }
    
    func notifyCarCash(at location: String) {
        print("Police were notified about a car crash at "
            + location)
    }
}

// MARK: - Delegating Object

class DispatchSystem {
    let multicastDelegate = MulticastDelegate<EmergencyResponding>()
}

// MARK: - Example
let dispatch = DispatchSystem()
var policeStation: PoliceStation! = PoliceStation()
var fireStation: FireStation! = FireStation()

dispatch.multicastDelegate.adđDelegate(policeStation)
dispatch.multicastDelegate.adđDelegate(fireStation)
dispatch.multicastDelegate.invokeDelegates { $0.notifyFire(at: "Ray's house")
}

print("")
dispatch.multicastDelegate.removeDelegate(fireStation)

dispatch.multicastDelegate.invokeDelegates {
    $0.notifyCarCash(at: "Ray' garage!")
}






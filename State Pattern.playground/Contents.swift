import UIKit
import PlaygroundSupport

var str = "Hello, playground"


// MARK: - State Protocol
protocol TrafficLightState: class {
    
    //MARK: - Properties
    var delay: TimeInterval { get }
    
    //MARK: - Instance methods
    func apply(to context: TrafficLight)
    
}

extension TrafficLightState {
    
    func apply(to context: TrafficLight, after delay: TimeInterval) {
        let queue = DispatchQueue.main
        let dispatchTime = DispatchTime.now() + delay
        queue.asyncAfter(deadline: dispatchTime) {
            [weak self, weak context] in
            guard let self = self else { return }
            context?.transition(to: self)
        }
    }
}


// MARK: - Context
class TrafficLight: UIView {
    // MARK: - Instance Properties
    
    private (set) var canisterLayer: [CAShapeLayer] = []
    private (set) var currentState: TrafficLightState
    private (set) var states: [TrafficLightState]
    
    
    // MARK: - Object Life Cycle
    @available(*, unavailable, message: "Use init(canisterCount: frame:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    init(canisterCount: Int = 3, frame: CGRect = CGRect(x: 0, y: 0, width: 160, height: 420), states: [TrafficLightState]) {
        
        guard !states.isEmpty else {
            fatalError("States should not be empty")
        }
        
        self.currentState = states.first!
        self.states = states
        
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.86, green: 0.64, blue: 0.25, alpha: 1)
        createCanisterLayers(count: canisterCount)
    }
    
    private func createCanisterLayers(count: Int) {
        
        let paddingPercentage: CGFloat = 0.2
        let yTotalPadding = paddingPercentage * bounds.height
        let yPadding = yTotalPadding / CGFloat(count + 1)
        
        let canisterHeight = (bounds.height - yTotalPadding) / CGFloat(count)
        let xPadding = (bounds.width - canisterHeight) / 2.0
        var canisterFrame = CGRect(x: xPadding,
                                  y: yPadding,
                                  width: canisterHeight,
                                  height: canisterHeight)
        
        for _ in 0..<count {
            let canisterShape = CAShapeLayer()
            canisterShape.path = UIBezierPath(ovalIn: canisterFrame).cgPath
            canisterShape.fillColor = UIColor.black.cgColor
            
            layer.addSublayer(canisterShape)
            canisterLayer.append(canisterShape)
            
            canisterFrame.origin.y += (canisterFrame.height + yPadding)
        }
    }
    
    func transition(to state: TrafficLightState) {
        removeCanisterSublayers()
        currentState = state
        currentState.apply(to: self)
        nextState.apply(to: self, after: currentState.delay)
    }
    
    private func removeCanisterSublayers() {
        canisterLayer.forEach {
            $0.sublayers?.forEach({
                $0.removeFromSuperlayer()
            })
        }
    }
    
    public var nextState: TrafficLightState {
        guard let index = states.index(where: { $0 === currentState }),
            index + 1 < states.count else { return states.first! }
        return states[index + 1]
    }
    
}

// MARK: - Concrete States
class SolidTrafficLightState {
    
    // MARK: - Properties
    let canisterIndex: Int
    let color: UIColor
    let delay: TimeInterval
    
    // MARK: - Objective Lifecycle
    init(canisterIndex: Int, color: UIColor, delay: TimeInterval) {
        self.canisterIndex = canisterIndex
        self.color = color
        self.delay = delay
    }
}

extension SolidTrafficLightState: TrafficLightState {
    
    func apply(to context: TrafficLight) {
        let canisterLayer = context.canisterLayer[canisterIndex]
        let circleShape = CAShapeLayer()
        circleShape.path = canisterLayer.path!
        circleShape.fillColor = color.cgColor
        circleShape.strokeColor = color.cgColor
        canisterLayer.addSublayer(circleShape)
    }
}

extension SolidTrafficLightState {
    class func greenLight
        (color: UIColor = UIColor(displayP3Red: 0.21, green: 0.78, blue: 0.35, alpha: 1),
                           canisterIndex: Int = 2,
                           delay: TimeInterval = 1.0) -> SolidTrafficLightState {
        return SolidTrafficLightState(canisterIndex: canisterIndex, color: color, delay: delay)
    }
    
    class func yellowLight(color: UIColor = UIColor(displayP3Red: 0.98, green: 0.91, blue: 0.07, alpha: 1),
                           canisterIndex: Int = 1,
                           delay: TimeInterval = 0.5) -> SolidTrafficLightState {
        return SolidTrafficLightState(canisterIndex: canisterIndex, color: color, delay: delay)
    }
    
    class func redLight(color: UIColor = UIColor(displayP3Red: 0.88, green: 0, blue: 0.04, alpha: 1),
                        canisterIndex: Int = 0, delay: TimeInterval = 2.0) -> SolidTrafficLightState {
        return SolidTrafficLightState(canisterIndex: canisterIndex, color: color, delay: delay)
    }
}

let greenYellowRed: [SolidTrafficLightState] = [.greenLight(), .yellowLight(), .redLight()]
let trafficLight = TrafficLight(states: greenYellowRed)
trafficLight.transition(to: greenYellowRed.first!)
PlaygroundPage.current.liveView = trafficLight




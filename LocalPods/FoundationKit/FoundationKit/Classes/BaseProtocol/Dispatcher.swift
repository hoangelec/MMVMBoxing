// Abstraction of DispatchQueue for DI
public protocol Dispatcher {
    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @convention(block) () -> Void)
    func sync(execute block: () -> Void)
}

public extension Dispatcher {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}

extension DispatchQueue: Dispatcher {}


public extension Result {
    var value: Success? {
        if case let .success(success) = self {
            return success
        } else {
            return nil
        }
    }
    
    var error: Error? {
        if case let .failure(error) = self {
            return error
        } else {
            return nil
        }
    }
    
    func onSuccess(handler: (Success) -> Void) {
        if case let .success(success) = self { handler(success) }
    }
    
    func onFailure(handler: (Failure) -> Void) {
        if case let .failure(error) = self { handler(error) }
    }
}


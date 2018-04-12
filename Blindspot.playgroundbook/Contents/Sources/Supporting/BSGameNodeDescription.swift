public enum BSGameNodeType {
    case Start
    case End
    case Hole
}

public struct BSGameNodeDescription {
    
    let type: BSGameNodeType
    let position: BSGameFieldPosition
    
    init(type: BSGameNodeType, position: BSGameFieldPosition) {
        self.type = type
        self.position = position
    }
}

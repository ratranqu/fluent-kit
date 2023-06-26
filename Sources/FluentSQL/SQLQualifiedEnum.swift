import SQLKit

public struct SQLQualifiedEnum: SQLExpression {
    public var `enum`: SQLExpression
    public var space: SQLExpression?

    public init(_ enum: String, space: String? = nil) {
        self.init(SQLIdentifier(`enum`), space: space.flatMap(SQLIdentifier.init(_:)))
    }

    public init(_ enum: SQLExpression, space: SQLExpression? = nil) {
        self.enum = `enum`
        self.space = space
    }

    public func serialize(to serializer: inout SQLSerializer) {
        if let space = self.space {
            space.serialize(to: &serializer)
            serializer.write(".")
        }
        self.enum.serialize(to: &serializer)
    }
}

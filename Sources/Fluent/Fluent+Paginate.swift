import Vapor
import NIOCore
import FluentKit

extension QueryBuilder {
    public func paginate(
        for request: Request
    ) -> EventLoopFuture<Page<Model>> {
        do {
            let page = try request.query.decode(PageRequest.self)
            return self.paginate(page)
        } catch {
            return request.eventLoop.makeFailedFuture(error)
        }
    }
}

extension Page: @retroactive Content, @retroactive ResponseEncodable, @retroactive RequestDecodable, @retroactive AsyncResponseEncodable, @retroactive AsyncRequestDecodable where T: Codable { }

import Foundation

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

let dateFormater = ISO8601DateFormatter()

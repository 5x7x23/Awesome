// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let calendarDataModel = try? newJSONDecoder().decode(CalendarDataModel.self, from: jsonData)

import Foundation

// MARK: - CalendarDataModel
struct CalendarDataModel: Codable {
    let createdCalendar: [String]
    let myCalendar: [MyCalendar]

    enum CodingKeys: String, CodingKey {
        case createdCalendar = "created_calendar"
        case myCalendar = "my_calendar"
    }
}

// MARK: - MyCalendar
struct MyCalendar: Codable {
    let id, creator, participant: Int
    let comment: String
    let startDate, endDate: Date

    enum CodingKeys: String, CodingKey {
        case id, creator, participant, comment
        case startDate = "start_date"
        case endDate = "end_date"
    }
}

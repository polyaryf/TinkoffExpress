//
//  IMeetingAppointmentService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 03.04.2023.
//

import Foundation

protocol IMeetingAppointmentService {
    func loadDates(completion: @escaping ([MeetingAppointmentDate]?) -> Void)
    func loadTimes(completion: @escaping ([MeetingAppointmentTime]?) -> Void)
}

final class MeetingAppointmentService: IMeetingAppointmentService {
    func loadDates(completion: @escaping ([MeetingAppointmentDate]?) -> Void) {
        let dates: [MeetingAppointmentDate] = [
            .init(date: "Сегодня"),
            .init(date: "Завтра"),
            .init(date: "21 Июля"),
            .init(date: "22 Июля"),
            .init(date: "23 Июля"),
            .init(date: "24 Июля"),
            .init(date: "25 Июля"),
            .init(date: "26 Июля"),
            .init(date: "27 Июля"),
            .init(date: "28 Июля"),
            .init(date: "29 Июля"),
            .init(date: "30 Июля"),
            .init(date: "31 Июля"),
            .init(date: "1 Августа"),
            .init(date: "2 Августа")
        ]
        completion(dates)
    }
    
    func loadTimes(completion: @escaping ([MeetingAppointmentTime]?) -> Void) {
        let times: [MeetingAppointmentTime] = [
            .init(time: "10:00-12:00", date: "Сегодня"),
            .init(time: "12:00-14:00", date: "Сегодня"),
            .init(time: "14:00-16:00", date: "Сегодня"),
            .init(time: "16:00-18:00", date: "Сегодня"),
            .init(time: "18:00-20:00", date: "Сегодня")
        ]
        completion(times)
    }
}

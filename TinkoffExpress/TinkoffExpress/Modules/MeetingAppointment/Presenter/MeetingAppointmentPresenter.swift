//
//  MeetingAppointmentPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit

protocol IMeetingAppointmentModuleOutput: AnyObject {
    /// тут подставила пока модельку следующего экрана
    /// но лучше передавать введенные данные, которые я потом на своем экране будут парсить
    func meetingAppointment(didCompleteWith orderData: OrderCheckout)
}

protocol MeetingAppointmentPresenterProtocol {
    func viewDidLoad()
    func addressButtonTapped()
    func deliveryButtonTapped()
    func viewDidChange(comment: String)
    func viewDidRequestNumberOfDateSlots() -> Int
    func viewDidRequestDateSlot(at index: Int) -> MeetingAppointmentDate
    func viewDidSelectDateSlot(at index: Int)
    func viewDidRequestNumberOfTimeSlots() -> Int
    func viewDidRequestTimeSlot(at index: Int) -> MeetingAppointmentTime
    func viewShouldSelectTimeSlot(at index: Int) -> Bool
    func viewDidSelectTimeSlot(at index: Int)
}

class MeetingAppointmentPresenter {
    // MARK: InternalTypes
    
    struct DateSlot {
        let date: Date
        let viewModel: MeetingAppointmentDate
        var timeSlotsState: TimeSlotState = .initial
    }
    
    struct TimeSlot {
        let apiTime: TEApiTimeSlot
        let viewModel: MeetingAppointmentTime
    }
    
    enum TimeSlotState {
        case initial
        case loading
        case loaded([TimeSlot])
        case failed
    }
    
    // MARK: Dependencies
    
    weak var view: IMeetingAppointmentView?
    private let router: IMeetingAppointmentRouter
    private let service: IMeetingAppointmentService
    
    // MARK: State
    
    private var address = ""
    private var comment = ""
    private var dateSlots: [DateSlot] = []
    private var selectedDateSlotIndex = 0
    private var selectedTimeSlotIndex = 0
    
    // MARK: Init
    
    init(
        router: IMeetingAppointmentRouter,
        service: IMeetingAppointmentService
    ) {
        self.router = router
        self.service = service
    }
    
    // MARK: Navigation
    
    private func showSearch() {
        // TODO: сделать смену открытия экрана
        //        router.openAddressInput(output: self)
        router.openABtest(output: self)
    }
    
    private func showOrderCheckout() {
        //        output?.meetingAppointment(didCompleteWith: OrderCheckout())
        router.openOrderCheckout()
    }
    
    private func loadTimeSlots(for dateSlotIndex: Int) {
        dateSlots[dateSlotIndex].timeSlotsState = .loading
        
        if selectedDateSlotIndex == dateSlotIndex {
            view?.reloadTimeCollection()
        }
        
        service.loadSlots(forDate: dateSlots[dateSlotIndex].date) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let apiTimeSlots):
                let slots = apiTimeSlots.map {
                    TimeSlot.from(apiTimeSlot: $0, date: self.dateSlots[dateSlotIndex].date)
                }
                self.dateSlots[dateSlotIndex].timeSlotsState = .loaded(slots)
                fallthrough
            case .success where self.selectedDateSlotIndex == dateSlotIndex:
                self.view?.reloadTimeCollection()
                self.view?.selectTimeSlot(at: selectedTimeSlotIndex)
            case .failure:
                self.dateSlots[dateSlotIndex].timeSlotsState = .failed
                fallthrough
            case .failure where self.selectedDateSlotIndex == dateSlotIndex:
                self.view?.showErrorAlert()
            }
        }
    }
}

// MARK: - MeetingAppointmentPresenterProtocol

extension MeetingAppointmentPresenter: MeetingAppointmentPresenterProtocol {
    func viewDidLoad() {
        dateSlots = DateSlot.defaultRange
        view?.reloadDateCollection()
        view?.selectDateSlot(at: selectedDateSlotIndex)
        
        loadTimeSlots(for: selectedDateSlotIndex)
    }
    
    func addressButtonTapped() {
        showSearch()
    }
    
    func deliveryButtonTapped() {
        showOrderCheckout()
    }
    
    func viewDidChange(comment: String) {
        self.comment = comment
    }
    
    func viewDidRequestNumberOfDateSlots() -> Int {
        dateSlots.count
    }
    
    func viewDidRequestDateSlot(at index: Int) -> MeetingAppointmentDate {
        dateSlots[index].viewModel
    }
    
    func viewDidSelectDateSlot(at index: Int) {
        guard selectedDateSlotIndex != index else { return }
        selectedDateSlotIndex = index
        selectedTimeSlotIndex = .zero
        
        switch dateSlots[selectedDateSlotIndex].timeSlotsState {
        case .loaded:
            view?.reloadTimeCollection()
            view?.selectTimeSlot(at: selectedTimeSlotIndex)
        case .loading:
            view?.reloadTimeCollection()
        case .initial, .failed:
            loadTimeSlots(for: selectedDateSlotIndex)
        }
    }
    
    func viewDidRequestNumberOfTimeSlots() -> Int {
        switch dateSlots[selectedDateSlotIndex].timeSlotsState {
        case .initial, .loading, .failed:
            return .shimmeringCellsCount
        case .loaded(let slots):
            return slots.count
        }
    }
    
    func viewDidRequestTimeSlot(at index: Int) -> MeetingAppointmentTime {
        switch dateSlots[selectedDateSlotIndex].timeSlotsState {
        case .initial, .failed, .loading:
            return .clear
        case .loaded(let slots):
            return slots[index].viewModel
        }
    }
    
    func viewDidSelectTimeSlot(at index: Int) {
        guard selectedTimeSlotIndex != index else { return }
        selectedTimeSlotIndex = index
    }
    
    func viewShouldSelectTimeSlot(at index: Int) -> Bool {
        switch dateSlots[selectedDateSlotIndex].timeSlotsState {
        case .loaded:
            return true
        case .initial, .loading, .failed:
            return false
        }
    }
}

// MARK: - IAddressInputModuleOutput

extension MeetingAppointmentPresenter: IAddressInputModuleOutput {
    func addressInputModule(didCompleteWith addressInput: String) {
        // TODO: Handle adressInput
    }
}

// MARK: - IABTestModuleOutput

extension MeetingAppointmentPresenter: IABTestModuleOutput {
    func abTestModule(didCompleteWith addressInput: String) {
        print(addressInput)
        // TODO: Handle adressInput
    }
}

// MARK: - Helpers

private extension MeetingAppointmentPresenter.DateSlot {
    static var defaultRange: [MeetingAppointmentPresenter.DateSlot] {
        let now = Date()
        
        return CollectionOfOne(initialSlot(from: now)) + (1 ... 14).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: now)
        }.map(initialSlot(from:))
    }
    
    static func initialSlot(from date: Date) -> MeetingAppointmentPresenter.DateSlot {
        MeetingAppointmentPresenter.DateSlot(
            date: date,
            viewModel: MeetingAppointmentDate(date: .localizedDate(from: date))
        )
    }
}

private extension String {
    static func localizedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("d-MMMM")
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Сегодня"
        } else if calendar.isDateInTomorrow(date) {
            return "Завтра"
        } else {
            return formatter.string(from: date)
        }
    }
}

private extension DateFormatter {
    static let `default`: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
}

private extension MeetingAppointmentPresenter.TimeSlot {
    static func from(apiTimeSlot: TEApiTimeSlot, date: Date) -> MeetingAppointmentPresenter.TimeSlot {
        MeetingAppointmentPresenter.TimeSlot(
            apiTime: apiTimeSlot,
            viewModel: MeetingAppointmentTime(
                time: "\(apiTimeSlot.timeFrom)-\(apiTimeSlot.timeTo)",
                date: .localizedDate(from: date)
            )
        )
    }
}

private extension MeetingAppointmentPresenter.TimeSlotState {
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    var isLoaded: Bool {
        switch self {
        case .loaded:
            return true
        default:
            return false
        }
    }
}

private extension Int {
    static let shimmeringCellsCount = 4
}

private extension MeetingAppointmentTime {
    static var clear: MeetingAppointmentTime {
        MeetingAppointmentTime(time: "", date: "")
    }
}

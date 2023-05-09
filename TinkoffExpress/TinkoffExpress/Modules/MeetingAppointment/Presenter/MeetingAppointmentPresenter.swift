//
//  MeetingAppointmentPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit

protocol IMeetingAppointmentPresenter {
    func viewDidLoad()
    func viewDidTapAddress()
    func viewDidTapPrimaryButton()
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
    
    enum AddressSearchType {
        case abTest
        case daData
    }
    
    enum UseCase {
        case ordering
        case editing
    }
    
    // MARK: Dependencies
    
    weak var view: IMeetingAppointmentView?
    private let router: IMeetingAppointmentRouter
    private let service: IMeetingAppointmentService
    private let addressSearchType: AddressSearchType
    private let useCase: UseCase
    
    // MARK: State
    
    private var address = "Ивангород, ул. Гагарина, д. 1"
    private var comment = ""
    private var dateSlots: [DateSlot] = []
    private var selectedDateSlotIndex = 0
    private var selectedTimeSlotIndex = 0
    
    // MARK: Init
    
    init(
        router: IMeetingAppointmentRouter,
        service: IMeetingAppointmentService,
        addressSearchType: AddressSearchType,
        useCase: UseCase
    ) {
        self.router = router
        self.service = service
        self.addressSearchType = addressSearchType
        self.useCase = useCase
    }
    
    // MARK: Helpers
    
    private func loadTimeSlots(for dateSlotIndex: Int, animateLoadingState: Bool = true) {
        dateSlots[dateSlotIndex].timeSlotsState = .loading
        
        if selectedDateSlotIndex == dateSlotIndex {
            view?.reloadTimeCollection(animated: animateLoadingState)
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
                self.view?.reloadTimeCollection(animated: true)
                self.view?.selectTimeSlot(at: self.selectedTimeSlotIndex)
            case .failure:
                self.dateSlots[dateSlotIndex].timeSlotsState = .failed
                fallthrough
            case .failure where self.selectedDateSlotIndex == dateSlotIndex:
                self.view?.showErrorAlert()
            }
        }
    }
    
    private func updatePrimaryButtonTitle() {
        let selectedDate = dateSlots[selectedDateSlotIndex].date
        let title = "Доставить \(String.localizedDate(from: selectedDate).lowercased())"
        view?.set(primaryButtonTitle: title)
    }
    
    private func isFormValid() -> Bool {
        let isAddressValid = !address.isEmpty
        
        let isTimeSlotSelected: Bool = {
            switch dateSlots[selectedDateSlotIndex].timeSlotsState {
            case .loaded:
                return true
            default:
                return false
            }
        }()
        
        return isAddressValid && isTimeSlotSelected
    }
}

// MARK: - IMeetingAppointmentPresenter

extension MeetingAppointmentPresenter: IMeetingAppointmentPresenter {
    func viewDidLoad() {
        dateSlots = DateSlot.defaultRange
        view?.reloadDateCollection()
        view?.selectDateSlot(at: selectedDateSlotIndex)
        view?.set(address: address)
        updatePrimaryButtonTitle()        
        loadTimeSlots(for: selectedDateSlotIndex, animateLoadingState: false)
    }
    
    func viewDidTapAddress() {
        switch addressSearchType {
        case .abTest:
            router.openABtest(output: self)
        case .daData:
            router.openAddressInput(output: self)
        }
    }
    
    func viewDidTapPrimaryButton() {
        guard
            isFormValid(),
            case let .loaded(timeSlots) = dateSlots[selectedDateSlotIndex].timeSlotsState
        else { return }

        let model = NewOrderInputModel(
            address: address,
            slot: timeSlots[selectedTimeSlotIndex].apiTime,
            comment: comment
        )

        router.openOrderCheckout(with: model)
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
            view?.reloadTimeCollection(animated: true)
            view?.selectTimeSlot(at: selectedTimeSlotIndex)
        case .loading:
            view?.reloadTimeCollection(animated: true)
        case .initial, .failed:
            loadTimeSlots(for: selectedDateSlotIndex)
        }
        
        updatePrimaryButtonTitle()
    }
    
    func viewDidRequestNumberOfTimeSlots() -> Int {
        switch dateSlots[selectedDateSlotIndex].timeSlotsState {
        case .initial, .loading, .failed:
            return .emptyTimeSlotsCount
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
        address = addressInput
        view?.set(address: address)
    }
}

// MARK: - IABTestModuleOutput

extension MeetingAppointmentPresenter: IABTestModuleOutput {
    func abTestModule(didCompleteWith addressInput: String) {
        address = addressInput
        view?.set(address: address)
    }
}

// MARK: - Utils

private extension MeetingAppointmentPresenter.DateSlot {
    static var defaultRange: [MeetingAppointmentPresenter.DateSlot] {
        let now = Date()
        
        return CollectionOfOne(initialSlot(from: now)) + (1 ... 14).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: now)
        }
        .map(initialSlot(from:))
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
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Сегодня"
        } else if calendar.isDateInTomorrow(date) {
            return "Завтра"
        } else {
            return DateFormatter.default.string(from: date)
        }
    }
}

private extension DateFormatter {
    static let `default`: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("d-MMMM")
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

private extension Int {
    static let emptyTimeSlotsCount = 3
}

private extension MeetingAppointmentTime {
    static var clear: MeetingAppointmentTime {
        MeetingAppointmentTime(time: "", date: "")
    }
}

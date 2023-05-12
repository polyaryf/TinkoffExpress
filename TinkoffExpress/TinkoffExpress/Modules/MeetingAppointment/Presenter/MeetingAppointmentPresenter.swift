//
//  MeetingAppointmentPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit

protocol IMeetingAppointmentPresenter {
    func viewWillAppear(with order: TEApiOrder)
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
        case editing(MyOrder)
    }
    
    // MARK: Dependencies
    
    weak var view: IMeetingAppointmentView?
    private let router: IMeetingAppointmentRouter
    private let service: IMeetingAppointmentService
    private let dateFormatter: ITEDateFormatter
    private let addressSearchType: AddressSearchType
    private let useCase: UseCase
    
    // MARK: State
    
    private var isCreatingOrder: Bool
    private var address = NSLocalizedString("meetingAppointmentDefaultAddress", comment: "")
    private var comment = ""
    private var dateSlots: [DateSlot] = []
    private var selectedDateSlotIndex = 0
    private var selectedTimeSlotIndex = 0
    private var buttonName = NSLocalizedString("meetingAppointmentDeliveryButton", comment: "")
    private var orderToUpdate: TEApiOrder?
    
    // MARK: Init
    
    init(
        router: IMeetingAppointmentRouter,
        service: IMeetingAppointmentService,
        dateFormatter: ITEDateFormatter,
        addressSearchType: AddressSearchType,
        useCase: UseCase,
        isCreatingOrder: Bool
    ) {
        self.router = router
        self.service = service
        self.dateFormatter = dateFormatter
        self.addressSearchType = addressSearchType
        self.useCase = useCase
        self.isCreatingOrder = isCreatingOrder
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
                    TimeSlot.from(
                        apiTimeSlot: $0,
                        date: self.dateSlots[dateSlotIndex].date,
                        formatter: self.dateFormatter
                    )
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
        let title = "\(buttonName) \(dateFormatter.format(date: selectedDate).lowercased())"
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
    
    private func getIndexFor(timeSlot: TEApiTimeSlot) -> Int {
        if timeSlot.timeFrom == "12:00" {
            return 0
        } else if timeSlot.timeFrom == "14:00" {
            return 1
        } else {
            return 2
        }
    }
    
    private func getIndexFor(dateSlot: TEApiTimeSlot) -> Int {
        if let index = dateSlots.firstIndex(where: {
            let dateFromSlot = dateFormatter.format(
                date: $0.date,
                timeFrom: dateSlot.timeFrom,
                timeTo: dateSlot.timeFrom
            )
            let dateFromModel = dateFormatter.format(
                date: dateSlot.date,
                timeFrom: dateSlot.timeFrom,
                timeTo: dateSlot.timeFrom
            )
            return dateFromSlot == dateFromModel
        }) {
            return index
        } else {
            return 0
        }
    }
    
    private func createOrderUpdateRequest(
        with model: TEApiOrder,
        timeSlots: [MeetingAppointmentPresenter.TimeSlot]
    ) -> OrderUpdateRequest {
        OrderUpdateRequest(
            address: TEApiAddress(address: address, lat: 0, lon: 0),
            paymentMethod: model.paymentMethod.rawValue,
            deliverySlot: timeSlots[selectedTimeSlotIndex].apiTime,
            comment: comment,
            status: .created
        )
    }
}

// MARK: - IMeetingAppointmentPresenter

extension MeetingAppointmentPresenter: IMeetingAppointmentPresenter {
    func viewWillAppear(with order: TEApiOrder) {
        orderToUpdate = order
    }
    
    func viewDidLoad() {
        dateSlots = DateSlot.defaultRange(formattingWith: dateFormatter)
        view?.reloadDateCollection()
        guard let orderToUpdate else {
            view?.selectDateSlot(at: selectedDateSlotIndex)
            view?.set(address: address)
            updatePrimaryButtonTitle()
            loadTimeSlots(for: selectedDateSlotIndex, animateLoadingState: false)
            return
        }
        address = orderToUpdate.address.address
        selectedDateSlotIndex = getIndexFor(dateSlot: orderToUpdate.deliverySlot)
        selectedTimeSlotIndex = getIndexFor(timeSlot: orderToUpdate.deliverySlot)
        comment = orderToUpdate.comment
        
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
            deliverySlot: timeSlots[selectedTimeSlotIndex].apiTime,
            comment: comment
        )
        if isCreatingOrder {
            router.openOrderCheckout(with: model)
        } else {
            guard let orderToUpdate else { return }
            
            service.updateOrder(
                id: orderToUpdate.id,
                with: createOrderUpdateRequest(with: orderToUpdate, timeSlots: timeSlots)
            ) { [weak self] result in
                switch result {
                case .success: self?.view?.closeView()
                case .failure: break
                }
            }
        }
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
    static func defaultRange(formattingWith formatter: ITEDateFormatter) -> [MeetingAppointmentPresenter.DateSlot] {
        let now = Date()

        return CollectionOfOne(slot(withDate: now, formattingWith: formatter)) + (1 ... 14).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: now)
        }
        .map { slot(withDate: $0, formattingWith: formatter) }
    }

    static func slot(
        withDate date: Date,
        formattingWith formatter: ITEDateFormatter
    ) -> MeetingAppointmentPresenter.DateSlot {
        MeetingAppointmentPresenter.DateSlot(
            date: date,
            viewModel: MeetingAppointmentDate(date: formatter.format(date: date))
        )
    }
}

private extension MeetingAppointmentPresenter.TimeSlot {
    static func from(
        apiTimeSlot: TEApiTimeSlot,
        date: Date,
        formatter: ITEDateFormatter
    ) -> MeetingAppointmentPresenter.TimeSlot {
        MeetingAppointmentPresenter.TimeSlot(
            apiTime: apiTimeSlot,
            viewModel: MeetingAppointmentTime(
                time: "\(apiTimeSlot.timeFrom)-\(apiTimeSlot.timeTo)",
                date: formatter.format(date: date)
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

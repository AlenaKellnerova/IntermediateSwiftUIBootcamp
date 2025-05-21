//
//  TimerFromVMSubscriberBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 12.05.2025.
//

import SwiftUI
import Combine


class TimerFromVMSubscriberViewModel: ObservableObject {

    @Published var count: Int = 0
//    var timer: AnyCancellable? // timer needs to be able to be cancelled = One cancellable
    var cancellables = Set<AnyCancellable>()  // if several cancellables
    
    @Published var textFieldText: String = ""
//    {
//        didSet {
//            print(textFieldText)
//            if textFieldText.count >= 3 {
//                print("TEXT IS VALID")
//                isValid = true
//            } else {
//                print("Text is not valid")
//                isValid = false
//            }
//        }
//    }
    
    @Published var isValid: Bool = false
    @Published var showButton: Bool = false
    
//    func addTextFieldSubscriber() {
//        $textFieldText
//            .map { text in  // transforming String to any type (T)
//                if text.count >= 3 {
//                    return true
//                }
//                return false
//            }
////            .assign(to: \.isValid, on: self) // every time we get bool it gets assigned to isValid = NO WEAK SELF OPTION
//            .sink(receiveValue: { [weak self] isValid in
//                self?.isValid = isValid
//            })
//            .store(in: &cancellables)
//    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // when user types quickly. waits 0.5 before running map
            .map { $0.count >= 3 }
            .sink { [weak self] in self?.isValid = $0} // better than assign - allows to make self weak
            .store(in: &cancellables)
    }
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
//        timer =
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }// check if self is valid
                self.count += 1
                
                if self.count >= 10 {
                    // If one cancellable
//                    self.timer?.cancel()
                    // If serveral cancellables
                    for item in self.cancellables {
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $isValid
            .combineLatest($count)
            .sink { [weak self] textIsValid, count in
                guard let self = self else { return }
                if textIsValid && count >= 9 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct TimerFromVMSubscriberBootcamp: View {
    
    @StateObject var vm = TimerFromVMSubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
            
            Text("Text is valid: \(vm.isValid.description)")
            
            TextField("Type something...", text: $vm.textFieldText)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(.gray).opacity(0.3)
                .cornerRadius(10)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(vm.textFieldText.count == 0 ? 0.0 : vm.isValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.isValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }
            
            Button {
                //
            } label: {
                Text("Submit")
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)

        }
        .padding()
    }
}

#Preview {
    TimerFromVMSubscriberBootcamp()
}

//
//  HapticEffectsExample.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import SwiftUI
import CoreHaptics

struct HapticEffectsExample: View {
    @State private var counter: Int = 0
    
    var body: some View {
        ScrollView {
            HapticFeedbackCounterView()
            
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal)
            
            OtherHapticEffects()
        
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal)
            
            HapticImpactExampleView()
            
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal)
            
            CoreHapticEffectsExampleView()
        }
        .navigationTitle("Haptic Examples")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct HapticFeedbackCounterView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Text("Haptic Feedback On Button Click")
                .font(.system(size: 40).bold())
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            HStack {
                Button {
                    counter += 1
                } label: {
                    Image(systemName: "arrow.up.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .sensoryFeedback(.increase, trigger: counter)
                Text("Counter")
                    .font(.title)
                    .padding(.horizontal, 30)
                Button {
                    counter -= 1
                } label: {
                    Image(systemName: "arrow.down.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .sensoryFeedback(.decrease, trigger: counter)
            }
            .padding(.vertical, 20)
            Text("\(counter)")
                .font(.title)
        }
        .padding(.vertical)
    }
}

struct OtherHapticEffects: View {
    
    @State private var stateMessage: String = "Message..."
    
    var body: some View {
        VStack{
            Text("Test Other Haptic Effects")
                .font(.system(size: 30).bold())
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            HStack {
                Button {
                    stateMessage = "Success"
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.green)
                }
                .sensoryFeedback(.success, trigger: stateMessage)
                
                Button {
                    stateMessage = "Warning"
                } label: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.yellow)
                }
                .sensoryFeedback(.warning, trigger: stateMessage)
                
                Button {
                    stateMessage = "Error"
                } label: {
                    Image(systemName: "sun.max.trianglebadge.exclamationmark")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.red)
                }
                .sensoryFeedback(.error, trigger: stateMessage)
                
                Button {
                    stateMessage = "Start"
                } label: {
                    Image(systemName: "restart.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.blue)
                }
                .sensoryFeedback(.start, trigger: stateMessage)
                
                Button {
                    stateMessage = "Stop"
                } label: {
                    Image(systemName: "stop.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.secondary)
                }
                .sensoryFeedback(.stop, trigger: stateMessage)
            }
            
            Text(stateMessage)
                .font(.system(size: 40).bold())
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
        .padding(.vertical)
    }
}

struct HapticImpactExampleView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Button{
                counter += 1
            } label: {
                Text("Soft collision")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.secondary)
            .foregroundColor(.primary)
            .frame(width: 150, height: 50)
            .clipShape(.capsule)
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
            
            Button{
                counter -= 1
            } label: {
                Text("Hard collision")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.green)
            .foregroundColor(.black)
            .frame(width: 150, height: 50)
            .clipShape(.capsule)
            .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
        }
        .padding(.vertical)
    }
}

struct CoreHapticEffectsExampleView: View {
    @State private var engine: CHHapticEngine?
    
    @State private var statusMessage: String = "Haptics Load Check Passed"
    
    var body: some View {
        VStack {
            Text("CoreHaptics")
                .font(.system(size: 30).bold())
                .multilineTextAlignment(.center)
            Text(statusMessage)
                .font(.system(size: 20))
                .padding(.bottom)
            
            Button{
                complexSuccess()
            } label: {
                Text("Play Custom Haptic")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.cyan)
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .clipShape(.capsule)
            
            Button {
                increaseHaptics()
            } label: {
                Text("Play Increase Haptic")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.yellow)
            .foregroundColor(.primary)
            .frame(width: 300, height: 50)
            .clipShape(.capsule)
            
            Button {
                decreaseHaptics()
            } label: {
                Text("Play Decrease Haptic")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.indigo)
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .clipShape(.capsule)
            
        }
        .padding(.vertical)
        .onAppear(perform: prepareHaptics)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            statusMessage = "Device does not support haptics"
            print(statusMessage)
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            statusMessage = "There was an error creating the engine: \(error.localizedDescription)"
            print(statusMessage)
        }
        
    }
    
    func complexSuccess() {
        // confirm device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            statusMessage = "Device does not support haptics"
            print(statusMessage)
            return
        }
        var events: [CHHapticEvent] = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert event into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            statusMessage = "Playing: Custom Haptics..."
        } catch {
            statusMessage = "Failed to play pattern: \(error.localizedDescription)"
            print(statusMessage)
        }
        
    }
    
    func increaseHaptics() {
        // confirm device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            statusMessage = "Device does not support haptics"
            print(statusMessage)
            return
        }
        var events: [CHHapticEvent] = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        // convert events into a pattern and play them immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            statusMessage = "Playing: Increase Haptics..."
        } catch {
            statusMessage = "Failed to play pattern: \(error.localizedDescription)"
            print(statusMessage)
        }
    }
    
    func decreaseHaptics() {
        // confirm device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            statusMessage = "Device does not support haptics"
            print(statusMessage)
            return
        }
        var events: [CHHapticEvent] = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert events into a pattern and play them immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            statusMessage = "Playing: Decrease Haptics..."
        } catch {
            statusMessage = "Failed to play pattern: \(error.localizedDescription)"
            print(statusMessage)
        }
    }
}

#Preview {
    HapticEffectsExample()
}

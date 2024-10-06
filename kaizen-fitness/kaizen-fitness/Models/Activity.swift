import Foundation

struct Activity: Hashable, Codable {
    let title: String
    let type: FitnessType
    let duration: DurationRange
    let effectiveBodyParts: [BodyPart]
    let musicTitle: String
    
    enum FitnessType: String, Codable {
        case stretch = "Stretch"
        case relax = "Relax"
        case stressRelief = "Stress relief"
    }
    
    struct DurationRange: Hashable, Codable {
        let min: Int
        let max: Int
    }
    
    enum BodyPart: String, Codable {
        case neck = "Neck"
        case shoulder = "Shoulder"
        case arm = "Arm"
        case face = "Face"
    }
    
    static let stretchesToRelieveShoulderAndNeckTension = {
        Activity(
            title: "Stretches to Relieve Shoulder and Neck Tension",
            type: .stretch,
            duration: .init(min: 15, max: 30),
            effectiveBodyParts: [.neck, .shoulder],
            musicTitle: "Relaxing"
        )
    }()
    
    static let shoulderShrugAndRoll = {
        Activity(
            title: "Shoulder Shrug and Roll",
            type: .stretch,
            duration: .init(min: 5, max: 20),
            effectiveBodyParts: [.neck, .shoulder],
            musicTitle: "Relaxing"
        )
    }()
    
    static let breathMethod = {
        Activity(
            title: "Breath method",
            type: .relax,
            duration: .init(min: 10, max: 20),
            effectiveBodyParts: [.shoulder, .face],
            musicTitle: "Chill"
        )
    }()
    
    static let steeringWheelPush = {
        Activity(
            title: "Steering Wheel Push",
            type: .relax,
            duration: .init(min: 20, max: 25),
            effectiveBodyParts: [.shoulder, .arm],
            musicTitle: "Chill"
        )
    }()
    
    static let seatedNeckRoll = {
        Activity(
            title: "Seated Neck Roll",
            type: .relax,
            duration: .init(min: 5, max: 15),
            effectiveBodyParts: [.neck, .shoulder],
            musicTitle: "Workout"
        )
    }()
    
    static let shout = {
        Activity(
            title: "Shout",
            type: .relax,
            duration: .init(min: 10, max: 20),
            effectiveBodyParts: [.shoulder, .face],
            musicTitle: "Workout"
        )
    }()
}

import Foundation

struct FitnessPlan: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let type: FitnessType
    let duration: DurationRange
    let effectiveBodyParts: [BodyPart]
    let musicTitle: String
    let destinationName: String = ""
    let destinationLatitude: Float = 0
    let destinationLongitude: Float = 0
    
    enum FitnessType: String {
        case stretch = "Stretch"
        case relax = "Relax"
    }
    
    struct DurationRange: Hashable {
        let min: Int
        let max: Int
    }
    
    enum BodyPart: String {
        case neck = "Neck"
        case shoulder = "Shoulder"
        case arm = "Arm"
        case face = "Face"
    }
}

struct Quiz: Codable {

    let id: Int
    let title: String
    let description: String
    let category: QuizCategory
    let level: Int
    let image: String
    let questions: [Question]
}

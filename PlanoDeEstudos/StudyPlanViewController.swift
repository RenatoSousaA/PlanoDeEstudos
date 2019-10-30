import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    // MARK: - Properties
    let sm = StudyManager.shared
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfSection.isHidden = !tfSection.isHidden
//        UIView.animate(withDuration: 0.5) {
//            self.dpDate.frame.size.height = 280
//        }
    }

    // MARK: - IBActions
    @IBAction func schedule(_ sender: UIButton) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id: id)
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria: \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.section)"
        content.categoryIdentifier = "Lembrete"
        
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: dpDate.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: studyPlan.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        sm.addPlan(studyPlan)
        navigationController!.popViewController(animated: true)
    }
    
}

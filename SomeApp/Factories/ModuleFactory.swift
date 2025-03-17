import Foundation

class ModuleFactory {
    func createEnterPhoneModule() -> EnterPhoneViewController {
        EnterPhoneViewController()
    }
    func createConformPhoneModule() -> ConformPhoneViewController {
        ConformPhoneViewController()
    }
    func createEnterPasswordModule() -> EnterPasswordViewController {
        EnterPasswordViewController()
    }
    func createEnterNameModule() -> EnterNameViewController {
        EnterNameViewController()
    }
    func createEnterBirthdayModule() -> EnterBirthdayViewController {
        EnterBirthdayViewController()
    }
}

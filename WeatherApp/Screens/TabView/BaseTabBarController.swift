/// `BaseTabBarController ` es una clase que maneja la interacción de la TabView y los componentes de la misma
/// `tabBarView` representa la tabView
/// `tabbarItemBackgroundView` representa el icono de selección de las opciones que tiene la TabView
/// `buttons` es un array que contiene los butones de la TabView : home, navigation y list
///`viewControllersList` es la lista de los controladores de home, navigation y list.

import UIKit


class BaseTabBarController: UITabBarController {

    private let tabBarView = UIView()
    
    private let tabbarItemBackgroundView = UIView()
    
    private var buttons: [UIButton] = []
    private var viewControllersList: [UIViewController] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabView()
        generateMenuControllers()

    }
    
    private func setupTabView() {
        // Agregar la vista personalizada del tabBar
        view.addSubview(tabBarView)
        tabBarView.backgroundColor = .secondarySystemFill
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabBarView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            tabBarView.heightAnchor.constraint(equalToConstant: 60),
            tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
        
        tabBarView.layer.cornerRadius = 30
        
        // Fondo dinámico que sigue al botón seleccionado
        tabBarView.addSubview(tabbarItemBackgroundView)
        tabbarItemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        tabbarItemBackgroundView.widthAnchor.constraint(equalTo: tabBarView.widthAnchor, multiplier: 1/3.0, constant: -10).isActive = true
           tabbarItemBackgroundView.heightAnchor.constraint(equalTo: tabBarView.heightAnchor, constant: -10).isActive = true
           tabbarItemBackgroundView.centerYAnchor.constraint(equalTo: tabBarView.centerYAnchor).isActive = true
           tabbarItemBackgroundView.layer.cornerRadius = 25
        tabbarItemBackgroundView.backgroundColor = .selected
        
    }
    
    
    private func generateMenuControllers() {
       
        for option in MenuTabOptions.allCases {
            let button = UIButton()
            let size = CGSize(width: 25, height: 25)
            let image = option.icon.resize(targetSize: size).withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            buttons.append(button)
            viewControllersList.append(option.viewControllerMenu)
        }
        setViewControllers(viewControllersList, animated: true)
        setupButtons()

    }
    
    
    
    private func setupButtons() {
        for (index, button) in buttons.enumerated() {
            tabBarView.addSubview(button)
            button.tag = index
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .white
            
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: tabBarView.centerYAnchor),
                button.widthAnchor.constraint(equalTo: tabBarView.widthAnchor, multiplier: 1 / CGFloat(buttons.count)),
                button.heightAnchor.constraint(equalTo: tabBarView.heightAnchor)
            ])
            
            if index == 0 {
                button.leftAnchor.constraint(equalTo: tabBarView.leftAnchor).isActive = true
            } else {
                button.leftAnchor.constraint(equalTo: buttons[index - 1].rightAnchor).isActive = true
            }
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        // Configurar posición inicial del fondo
        
        updateBackgroundPosition(for: selectedIndex)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedIndex = index
        updateBackgroundPosition(for: index)
        switchToViewController(at: index)
    }
    
    private func updateBackgroundPosition(for index: Int) {
        UIView.animate(withDuration: 0.3) {
            self.tabbarItemBackgroundView.center.x = self.buttons[index].center.x
        }
    }
    
    private func switchToViewController(at index: Int) {
        guard index < viewControllersList.count else { return }
        selectedViewController = viewControllersList[index]
    }
    
  
   
}



extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}


enum MenuTabOptions: CaseIterable, Hashable {
    case home
    case list
    case location
    
    var icon: UIImage {
            switch self {
            case .home:
                return UIImage(systemName: "house.fill") ?? UIImage()
            case .list:
                return UIImage(systemName: "list.bullet") ?? UIImage()
                case .location:
                return UIImage(systemName: "map.fill") ?? UIImage()
            }
        }
    
    
    var viewControllerMenu: UIViewController {
        switch self {
            case .home:
                return HomeViewController()
            case .list:
                return ListViewController()
            case .location:
                return MapViewController()
        }
    }
}

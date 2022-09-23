//
//  UserLocationViewController.swift
//  UrologyAmerica
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class UserLocationViewController: BaseViewController, ViewController {

    typealias ViewModel = UserLocationViewModel
    private var viewModel: UserLocationViewModel!

    @IBOutlet private var mapView: MKMapView!

    func configure(with viewModel: UserLocationViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationStyle(with: .clear)
    }
}

private extension UserLocationViewController {

    func configure() {

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(withColor: .black, tapHandler: { [weak self] in
            self?.viewModel.onBack()
        })
        let addressLabel = MediumLabel()
        addressLabel.fontSize = 13.0
        addressLabel.labelColor = .darkGray
        addressLabel.numberOfLines = 0
        viewModel.name.bind(to: addressLabel)
        self.navigationItem.titleView = addressLabel
        mapView.showsUserLocation = true
        _ = viewModel.hasCordinates.observeNext { [weak self] in
            if $0 {
                self?.updateMap()
            }
        }
    }

    func updateMap() {
        let center = CLLocationCoordinate2D(latitude: viewModel.latitude.value, longitude: viewModel.longitude.value)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }
}

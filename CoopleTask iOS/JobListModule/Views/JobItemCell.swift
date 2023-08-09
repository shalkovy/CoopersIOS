//
//  JobItemCell.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 09/08/2023.
//

import UIKit

class JobItemCell: UITableViewCell {
    let jobItemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let streetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let zipLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with jobItem: JobItem) {
        jobItemNameLabel.text = jobItem.name
        streetLabel.text = jobItem.location.addressStreet
        zipLabel.text = jobItem.location.zip
        cityLabel.text = jobItem.location.city
    }
    
    private func setupLabels() {
        contentView.addSubview(jobItemNameLabel)
        contentView.addSubview(streetLabel)
        contentView.addSubview(zipLabel)
        contentView.addSubview(cityLabel)
        
        jobItemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        streetLabel.translatesAutoresizingMaskIntoConstraints = false
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            jobItemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            jobItemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            jobItemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            streetLabel.topAnchor.constraint(equalTo: jobItemNameLabel.bottomAnchor, constant: 8),
            streetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            streetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            zipLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 8),
            zipLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            zipLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            cityLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 8),
            cityLabel.leadingAnchor.constraint(equalTo: zipLabel.trailingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}


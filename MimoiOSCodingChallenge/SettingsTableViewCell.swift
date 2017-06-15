//
//  Created by Mimohello GmbH on 16.02.17.
//  Copyright (c) 2017 Mimohello GmbH. All rights reserved.
//

import UIKit
import PureLayout

@objc protocol SettingsTableViewCellDelegate : class {
	func switchChangedValue(switcher: UISwitch)
}

class SettingsTableViewCell : UITableViewCell {
	
	weak var delegate : SettingsTableViewCellDelegate?
	let selectionSwitch = UISwitch()
	let label = UILabel()
	let secondaryLabel = UILabel()
	let activityIndicator = UIActivityIndicatorView()
	private var didSetConstraints = false
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.white
		selectionStyle = .default
		
		label.font = UIFont.systemFont(ofSize: 14)
		
		contentView.addSubview(label)
		contentView.addSubview(selectionSwitch)
		contentView.addSubview(activityIndicator)
		contentView.addSubview(secondaryLabel)
		
		selectionSwitch.addTarget(self, action: #selector(switched), for: .valueChanged)
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if !didSetConstraints {
			let padding : CGFloat = 16
			
			label.autoPinEdge(toSuperviewEdge: .left, withInset: padding)
			label.autoAlignAxis(toSuperviewAxis: .horizontal)
			
			selectionSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
			selectionSwitch.autoAlignAxis(toSuperviewAxis: .horizontal)
			
			activityIndicator.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
			activityIndicator.autoAlignAxis(toSuperviewAxis: .horizontal)
			
			secondaryLabel.autoPinEdge(toSuperviewEdge: .right, withInset: padding)
			secondaryLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
			
			didSetConstraints = true
		}
		super.updateConstraints()
	}
	
	@objc private func switched() {
		delegate?.switchChangedValue(switcher: selectionSwitch)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		selectionStyle = .default
		label.text = nil
		secondaryLabel.text = nil
		selectionSwitch.setOn(false, animated: false)
		delegate = nil
	}
}

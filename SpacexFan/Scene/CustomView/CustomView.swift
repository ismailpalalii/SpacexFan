//
//  CustomView.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import UIKit
import Lottie
import SnapKit

class CustomView: UIView {
    private var animationView: AnimationView?

    override init(frame: CGRect) {
        super.init(frame: frame)

        animationView = .init(name: "45722-rocket-loader")

        animationView?.contentMode = .scaleAspectFit

        animationView?.loopMode = .loop

        animationView?.animationSpeed = 0.5

        animationView?.play()

        animationView?.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        })
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

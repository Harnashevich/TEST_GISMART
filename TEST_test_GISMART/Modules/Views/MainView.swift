//
//  MainView.swift
//  TEST_test_GISMART
//
//  Created by Harnashevich on 2.07.22.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - UI
    
    /// ImageVIew "Music"
    private lazy var musicLogoImageView = createImageView()
    
    /// Label with days
    private lazy var daysLabel = createTimerLabel()
    /// Label with hours
    private lazy var hoursLabel = createTimerLabel()
    /// Label with minutes
    private lazy var minutesLabel = createTimerLabel()
    /// Label with seconds
    private lazy var secondsLabel = createTimerLabel()
    /// Label with colon symbol after daysLabel
    private lazy var colonAfterDaysLabel = createColonLabel()
    /// Label with colon symbol after hoursLabel
    private lazy var colonAfterHoursLabel = createColonLabel()
    /// Label with colon symbol after minutesLabel
    private lazy var colonAfterMinutesLabel = createColonLabel()
    
    /// Stack with countdown Timer
    private lazy var timerStack = createTimerStack()
    /// Label "For true music fans"
    private lazy var forFansLabel = createLabel(color: AppTheme.Colors.white,
                                                font: AppTheme.Fonts.SFSemiBold(5.dynamicSize()))
    /// Label "90% OFF"
    private lazy var saleLabel = createLabel(color: AppTheme.Colors.white,
                                             font: AppTheme.Fonts.SFHeavy(25.dynamicSize()))
    /// Label "LAST-MINUTE..."
    private lazy var lastMinuteLabel = createLabel(color: AppTheme.Colors.white,
                                                   font: AppTheme.Fonts.SFSemiBold(10.dynamicSize()))
    /// Label "Hundreds of songs in you pocket"
    private lazy var hundredsLabel = createLabel(color: AppTheme.Colors.lightGray,
                                                 font: AppTheme.Fonts.SFRegular(6.dynamicSize()))
    /// Button activate offer
    private lazy var activateButton = createActivateButton()
    /// Label "Privacy"
    private lazy var privacyLabel = createLabel(color: AppTheme.Colors.lightGray,
                                                font: AppTheme.Fonts.SFRegular(4.dynamicSize()))
    /// Label "Restore"
    private lazy var restoreLabel = createLabel(color: AppTheme.Colors.lightGray,
                                                font: AppTheme.Fonts.SFRegular(4.dynamicSize()))
    /// Label "Terms"
    private lazy var termsLabel = createLabel(color: AppTheme.Colors.lightGray,
                                              font: AppTheme.Fonts.SFRegular(4.dynamicSize()))
    /// Stack with labels "Privacy", Restore", "Terms"
    private lazy var bottomStack = createTimerStack()
    
    
    private lazy var fakeLabel = createColonLabel()
    
    
    //MARK: - Variables
    
    private lazy var remainingTimeInSeconds: Int = 86400 + 1
    private lazy var formatter = DateFormatterManager.shared
    private var timer: Timer!
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNotification()
        configureUI()
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Callbacks
    
    /// Button press closure
    var didTapActivateButton: (() -> Void)?
}

//MARK: - MainView private methods

extension MainView {
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIScene.didActivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willDeactivateNotification, object: nil)
    }
    
    private func configureUI() {
        backgroundColor = AppTheme.Colors.black
        
        daysLabel.text = ""
        hoursLabel.text = ""
        minutesLabel.text = ""
        secondsLabel.text = ""
        
        fakeLabel.text = String()
        
        forFansLabel.text = "For true music fans"
        saleLabel.text = "90% OFF"
        lastMinuteLabel.text = "LAST-MINUTE CHANCE! \n to claim your offer"
        hundredsLabel.text = "Hundreds of songs in you pocket"
        
        privacyLabel.text = "Privacy"
        restoreLabel.text = "Restore"
        termsLabel.text = "Terms"
    }
    
    private func addViews() {
        addSubviews(musicLogoImageView, timerStack, fakeLabel, forFansLabel, saleLabel, lastMinuteLabel, hundredsLabel, activateButton, bottomStack)
        timerStack.addArrangedSubviews(daysLabel, colonAfterDaysLabel, hoursLabel, colonAfterHoursLabel, minutesLabel, colonAfterMinutesLabel, secondsLabel)
        bottomStack.addArrangedSubviews(privacyLabel, restoreLabel, termsLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            musicLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            musicLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            musicLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: checkDevice()),
            musicLogoImageView.widthAnchor.constraint(equalTo: musicLogoImageView.heightAnchor, multiplier: 2),
            
            timerStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
            timerStack.centerXAnchor.constraint(equalTo: fakeLabel.centerXAnchor, constant: -16),
            
            fakeLabel.leadingAnchor.constraint(equalTo: musicLogoImageView.trailingAnchor),
            fakeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            forFansLabel.centerXAnchor.constraint(equalTo: timerStack.centerXAnchor),
            forFansLabel.bottomAnchor.constraint(equalTo: timerStack.topAnchor, constant: -20),
            
            saleLabel.centerXAnchor.constraint(equalTo: timerStack.centerXAnchor),
            saleLabel.bottomAnchor.constraint(equalTo: forFansLabel.topAnchor, constant: -8),
            
            lastMinuteLabel.centerXAnchor.constraint(equalTo: timerStack.centerXAnchor),
            lastMinuteLabel.bottomAnchor.constraint(equalTo: saleLabel.topAnchor, constant: -12),
            
            hundredsLabel.centerXAnchor.constraint(equalTo: timerStack.centerXAnchor),
            hundredsLabel.topAnchor.constraint(equalTo: timerStack.bottomAnchor, constant: 16),
            
            activateButton.heightAnchor.constraint(equalToConstant: 30.dynamicSize()),
            activateButton.widthAnchor.constraint(equalTo: timerStack.widthAnchor, multiplier: 1),
            activateButton.centerXAnchor.constraint(equalTo: timerStack.centerXAnchor),
            activateButton.topAnchor.constraint(equalTo: hundredsLabel.bottomAnchor, constant: 15),
            
            bottomStack.centerXAnchor.constraint(equalTo: timerStack.centerXAnchor),
            bottomStack.topAnchor.constraint(equalTo: activateButton.bottomAnchor, constant: 20),
        ])
    }
    
    private func checkDevice() -> Double {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 0.5
        default:
            return 0.4
        }
    }
    
    private func chechLabelAnimation(label: UILabel, type: String) {
        if label.text != type {
            label.createTimerAnimation(isActivated: true)
        } else {
            label.createTimerAnimation(isActivated: false)
        }
    }
    
    private func createImageView() -> UIImageView {
        let image = UIImageView()
        image.image = AppTheme.Images.musicLogo
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    private func createTimerLabel() -> UILabel {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 25.dynamicSize()).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20.dynamicSize()).isActive = true
        label.textColor = AppTheme.Colors.white
        label.font = AppTheme.Fonts.SFBold(10.dynamicSize())
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.backgroundColor = AppTheme.Colors.gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createColonLabel() -> UILabel {
        let label = UILabel()
        label.textColor = AppTheme.Colors.white
        label.font = AppTheme.Fonts.SFBold(10.dynamicSize())
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ":"
        return label
    }
    
    private func createLabel(color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = color
        label.font = font
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTimerStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func createActivateButton() -> UIButton {
        let button = GradientButton(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        button.addShadow(shadowColor: AppTheme.Colors.pink.cgColor, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 20, shadowRadius: 20)
        button.setTitle("ACTIVATE OFFER", for: .normal)
        button.addTarget(self, action: #selector(activateButtonTapped), for: .touchUpInside)
        button.setTitleColor(AppTheme.Colors.white, for: .normal)
        button.titleLabel?.font = AppTheme.Fonts.SFSemiBold(8.dynamicSize())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

//MARK: - MainView methods

extension MainView {
    
    @objc private func activateButtonTapped() {
        didTapActivateButton?()
        timer.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didEnterBackground(notification: NSNotification) {
        print("play")
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(step),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func willEnterForeground(notification: NSNotification) {
        print("pause")
        timer.invalidate()
    }
    
    @objc private func step() {
        if remainingTimeInSeconds > 0 {
            remainingTimeInSeconds -= 1
        } else {
            timer.invalidate()
            remainingTimeInSeconds = 0
        }
        
        secondsLabel.createTimerAnimation(isActivated: true)
        
        chechLabelAnimation(label: minutesLabel,
                            type: formatter.getTime(seconds: remainingTimeInSeconds).minutes)
        
        chechLabelAnimation(label: hoursLabel,
                            type: formatter.getTime(seconds: remainingTimeInSeconds).hour)
        
        chechLabelAnimation(label: daysLabel,
                            type: Int(remainingTimeInSeconds/86400).daysLabelFormat())
        
        
        
        daysLabel.text = Int(remainingTimeInSeconds/86400).daysLabelFormat()
        hoursLabel.text = "\(formatter.getTime(seconds: remainingTimeInSeconds).hour)"
        minutesLabel.text = "\(formatter.getTime(seconds: remainingTimeInSeconds).minutes)"
        secondsLabel.text = "\(formatter.getTime(seconds: remainingTimeInSeconds).seconds)"
    }
}
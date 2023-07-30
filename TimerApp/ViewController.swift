//
//  ViewController.swift
//  TimerApp
//
//  Created by zaehorang on 2023/07/27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var seconds: Int = 0
    weak var timer: Timer?   //강한 순환 참조 문제를 막기 위해 weak 키워드 사용

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
    }
    

    @IBAction func sliderChanged(_ sender: UISlider) {
        //슬라이더의 수치를 초 단위로 계산하고 레이블에 표시
        seconds = Int(sender.value * 60)
        mainLabel.text =  "\(seconds)초"
        
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        configureUI()
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        //슬라이더 표시된 초만큼 카운트
        //끝나면 알람
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            if seconds > 0 {
                seconds -= 1
                mainLabel.text =  "\(seconds)초"
                slider.value = Float(seconds) / 60.0
                
                //좀 더 정확한 시간 계산을 위해 조건문 추가: ex) 3, 2, 1, 0 -> 0때문에 1초 더 세지는 것을 막기 위함
                if seconds == 0 {
                    AudioServicesPlayAlertSound(SystemSoundID(1322))
                }
                
                
            } else {
                mainLabel.text = "초를 선택하세요"
                timer?.invalidate()
                timer = nil
            }
            
            
            
            
        })

    }
    
    
}


//
//  PageController.swift
//  InteractiveStory
//
//  Created by Marquis Dennis on 4/11/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit

class PageController: UIViewController {

	var page:Page?
	
	let artWork = UIImageView()
	let storyLabel = UILabel()
	let firstChoiceButton = UIButton(type: .System)
	let secondChoiceButton = UIButton(type: .System)
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	init(page: Page) {
		self.page = page
		
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .whiteColor()
		
		if let page = page {
			artWork.image = page.story.artWork
			let attributedString = NSMutableAttributedString(string: page.story.text)
			
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.lineSpacing = 10 //points
			
			attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
			
			storyLabel.attributedText = attributedString
			
			if let firstChoice = page.firstChoice {
				firstChoiceButton.setTitle(firstChoice.title, forState: .Normal)
				firstChoiceButton.addTarget(self, action: #selector(PageController.loadFirstChoice), forControlEvents: .TouchUpInside)
			} else {
				firstChoiceButton.setTitle("Play Again", forState: .Normal)
				firstChoiceButton.addTarget(self, action: #selector(PageController.playAgain), forControlEvents: .TouchUpInside)
			}
			
			if let secondChoice = page.secondChoice {
				secondChoiceButton.setTitle(secondChoice.title, forState: .Normal)
				secondChoiceButton.addTarget(self, action: #selector(PageController.loadSecondChoice), forControlEvents: .TouchUpInside)
			}
		}
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		view.addSubview(artWork)
		
		artWork.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activateConstraints([
			artWork.topAnchor.constraintEqualToAnchor(view.topAnchor),
			artWork.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
			artWork.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
			artWork.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
		])
		
		view.addSubview(storyLabel)
		
		storyLabel.translatesAutoresizingMaskIntoConstraints = false
		storyLabel.numberOfLines = 0
		
		NSLayoutConstraint.activateConstraints([
			storyLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 16.0),
			storyLabel.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -16.0),
			storyLabel.topAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -48.0)
		])
		
		view.addSubview(firstChoiceButton)
		firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints([
			firstChoiceButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
			firstChoiceButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -80.0)
		])
		
		view.addSubview(secondChoiceButton)
		secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints([
			secondChoiceButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
			secondChoiceButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -32.0)
		])
	}
	
	func loadFirstChoice() {
		if let page = page, firstChoice = page.firstChoice {
			let nextPage = firstChoice.page
			let pageController = PageController(page: nextPage)
			
			navigationController?.pushViewController(pageController, animated: true)
		}
	}
	
	func loadSecondChoice() {
		if let page = page, secondChoice = page.secondChoice {
			let nextPage = secondChoice.page
			let pageController = PageController(page: nextPage)
			
			navigationController?.pushViewController(pageController, animated: true)
		}
	}
	
	func playAgain() {
		navigationController?.popToRootViewControllerAnimated(true)
	}
}

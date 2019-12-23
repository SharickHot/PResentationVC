import UIKit

class CardPresentationController: PresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return containerView.bounds
            .inset(by: UIEdgeInsets(top: containerView.bounds.height - 400 - containerView.safeAreaInsets.bottom, left: 0, bottom: 0, right: 0))
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
//        presentedView?.layer.cornerRadius = 48
        containerView?.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)));
        containerView?.addGestureRecognizer(tap)
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                }, completion: nil)
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = .clear
            }, completion: nil)
        }
    }
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}

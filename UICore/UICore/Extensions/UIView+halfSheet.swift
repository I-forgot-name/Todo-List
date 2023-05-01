//
//  UIView+halfSheet.swift
//  UICore
//
//  Created by MacBook Pro on 30.04.2023.
//

import SwiftUI

public extension View {
    func halfSheet<Content: View>(
        showSheet: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        return self
            .background(
                HalfSheetHelper(sheetView: content(), showSheet: showSheet, onDismiss: onDismiss)
            )
    }
}

struct HalfSheetHelper<Content: View>: UIViewControllerRepresentable {

    var sheetView: Content
    let controller: UIViewController = UIViewController()
    @Binding var showSheet: Bool
    var onDismiss: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        }
    }

    //on dismiss...
    final class Coordinator: NSObject, UISheetPresentationControllerDelegate {

        var parent: HalfSheetHelper

        init(parent: HalfSheetHelper) {
            self.parent = parent
        }

        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onDismiss()
        }
    }
}

// Custom UIHostingController for halfSheet...
final class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        view.backgroundColor = .clear
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]

            //MARK: - sheet grabber visbility
            // Индикатор захвата в верхней части контроллера
            presentationController.prefersGrabberVisible = false

            // this allows you to scroll even during medium detent
            presentationController.prefersScrollingExpandsWhenScrolledToEdge = false

            //MARK: - sheet corner radius
            presentationController.preferredCornerRadius = 30

            // for more sheet customisation check out this great article https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/#scrolling
        }
    }
}

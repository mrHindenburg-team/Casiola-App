import StoreKit
import Foundation

@Observable
@MainActor
final class StoreManager {

    // MARK: - Product identifiers

    static let premiumStyleID = "Casiola.premiumStyle"
    static let aiCoachID      = "Casiola.aiCoach"

    // MARK: - State

    var products: [Product] = []
    var purchasedIDs: Set<String> = []
    var isLoading = false
    var purchaseError: String?

    // MARK: - Derived helpers

    var hasPremiumStyle: Bool { purchasedIDs.contains(Self.premiumStyleID) }
    var hasAICoach: Bool      { purchasedIDs.contains(Self.aiCoachID) }

    var premiumStyleProduct: Product? {
        products.first { $0.id == Self.premiumStyleID }
    }

    var aiCoachProduct: Product? {
        products.first { $0.id == Self.aiCoachID }
    }
    
   @ObservationIgnored private var intentsTask: Task<Void, Never>?
    @ObservationIgnored private var updates: Task<Void, Never>?
    
    
    init() {
        updates = observeTransactionUpdates()
        intentsTask = observePurchaseIntents()
    }
    
    deinit {
        intentsTask?.cancel()
        updates?.cancel()
    }

    // MARK: - Actions

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            products = try await Product.products(for: [Self.premiumStyleID, Self.aiCoachID])
        } catch {
            purchaseError = "Could not load products. Check your connection."
        }
        await checkEntitlements()
    }

    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    await transaction.finish()
                    purchasedIDs.insert(transaction.productID)
                }
            case .userCancelled, .pending:
                break
            @unknown default:
                break
            }
        } catch {
            purchaseError = "Purchase failed. Please try again."
        }
    }

    func restore() async {
        do {
            try await AppStore.sync()
            await checkEntitlements()
        } catch {
            purchaseError = "Restore failed. Please try again."
        }
    }

    // MARK: - Private

    private func checkEntitlements() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                purchasedIDs.insert(transaction.productID)
            }
        }
    }
    
    private func observePurchaseIntents() -> Task<Void, Never> {
        Task(priority: .background) { [weak self] in
            for await intent in PurchaseIntent.intents {
                guard let self else { return }
                await self.purchase(intent.product)
            }
        }
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                await self.handle(verificationResult: result)
            }
        }
    }
    
    @MainActor
    private func handle(verificationResult: VerificationResult<Transaction>) async {
        if case .verified(let transaction) = verificationResult {
            purchasedIDs.insert(transaction.productID)
            await transaction.finish()
        }
    }
}

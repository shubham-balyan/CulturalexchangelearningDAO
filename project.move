module CulturalExchange::LearningDAO {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a learning contribution.
    struct Contribution has store, key {
        total_rewards: u64,  // Total rewards distributed
    }

    /// Function to register a new contributor with an initial reward balance.
    public fun register_contributor(creator: &signer) {
        let contribution = Contribution { total_rewards: 0 };
        move_to(creator, contribution);
    }

    /// Function to reward contributors with tokens for sharing cultural knowledge.
    public fun reward_contributor(admin: &signer, contributor: address, amount: u64) acquires Contribution {
        let contribution = borrow_global_mut<Contribution>(contributor);

        // Transfer tokens from admin to contributor
        let reward = coin::withdraw<AptosCoin>(admin, amount);
        coin::deposit<AptosCoin>(contributor, reward);

        // Update reward balance
        contribution.total_rewards = contribution.total_rewards + amount;
    }
}

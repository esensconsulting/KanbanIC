import Principal "mo:base/Principal";
actor {
    stable var currentValue: Nat = 0;

    public func increment(): async () {
        currentValue += 1;
    };

    public query func getValue(): async Nat {
        currentValue;
    };
    
    public query(msg) func getPrincipal(): async Text {
        Principal.toText(msg.caller);
    };
};

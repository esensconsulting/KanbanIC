/// Public-facing types.
module {
    public type Timestamp = Int; // See mo:base/Time and Time.now()
    public type UserId = Text; // chosen by createUser
    public type ProfilePic = [Nat8]; // encoded as a PNG file

}
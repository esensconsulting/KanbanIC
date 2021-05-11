import State "lib/State";
import Types "lib/Types";
import Time "mo:base/Time";

shared ({caller = initPrincipal}) actor class Kanban () {
  public type ProfilePic = Types.ProfilePic;
  public type Timestamp = Types.Timestamp;
  public type UserId = Types.UserId;

  var state = State.empty({ admin = initPrincipal });

  public query func checkUsernameAvailable(userName_ : Text): async Bool {
    switch (state.profiles.get(userName_)) {
      case (?_) { /* error -- ID already taken. */ false };
      case null { /* ok, not taken yet. */ true };
    }
  };

  /// null means that the principal is unrecognized,
  /// otherwise, returns a non-empty array of usernames.
  public shared(msg) func getUserNameByPrincipal(p:Principal) : async ?[Text] {
    if ( msg.caller == p ) {
      ?state.access.userPrincipal.get1(p)
    } else {
      // access control check fails; do not reveal username of p.
      null
    }
  };

  // responsible for adding metadata from the user to the state.
  // a null principal means that the username has no valid callers (yet), and the admin
  // must relate one or more principals to it.
  func createProfile_(userName_ : Text, p: ?Principal, pic_ : ?ProfilePic) : ?State.Profile {
    switch (state.profiles.get(userName_)) {
      case (?_) { /* error -- ID already taken. */ null };
      case null { /* ok, not taken yet. */
        let now = Time.now();
        let profile: State.Profile = {
            userName = userName_ ;
            createdAt = now ;
        };
        state.profiles.put(userName_, profile);
        // rewards init invariant: rewards is initialized to zero (is non-null).
        // state.rewards.put(userName_, 0);
        // state.eventLog.add({
        //   time = now;
        //   kind = #createProfile({userName=userName_; pic=pic_})
        // });
        // state.access.userRole.put(userName_, #user);
        switch p {
          case null { }; // no related principals, yet.
          case (?p) { state.access.userPrincipal.put(userName_, p); }
        };
        // return the full profile info
        //getProfilePlus_(userName_)
        ?(profile);
      };
    }
  };

  public shared(msg) func createProfile(userName : Text, pic : ?ProfilePic) : async ?State.Profile {
    do ? {
      // accessCheck(msg.caller, #create, #user userName)!;
      createProfile_(userName, ?msg.caller, pic)!
    }
  };
}
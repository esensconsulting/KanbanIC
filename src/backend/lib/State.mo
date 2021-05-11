import Text "mo:base/Text";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Trie "mo:base/Trie";
import TrieMap "mo:base/TrieMap";
import Types "./Types";
import Access "./Access";

module {
  // Our representation of finite mappings.
  public type MapShared<X, Y> = Trie.Trie<X, Y>;
  public type Map<X, Y> = TrieMap.TrieMap<X, Y>;
  public type Timestamp = Int; // See mo:base/Time and Time.now()

  public type CreateProfile = {
    userName : Text;
    pic: ?Types.ProfilePic;
  };
  /// User profile.
  public type Profile = {
    userName : Text ;
    createdAt : Timestamp;
  };

  public type State = {
    access : Access.Access;
    boards : Map<Nat, Text>;
    profiles : Map<Types.UserId, Profile>;
  };
  public func empty (init : { admin : Principal }) : State {
    let st : State = {
      access = Access.Access();
      boards = TrieMap.TrieMap<Nat, Text>(Nat.equal, Hash.hash);
      profiles = TrieMap.TrieMap<Types.UserId, Profile>(Text.equal, Text.hash);
    };
    st
  };
}
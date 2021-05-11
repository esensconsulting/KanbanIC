import RelObj "RelObj";
import Types "Types";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
module {
  public class Access () {
    /// Relating usernames and roles.
    // public var userRole : RelObj.RelObj<Types.UserId, Types.Role> =
    // RelObj.RelObj<Types.UserId, Role.Role>
    // ((Text.hash, Role.hash), (Text.equal, Role.equal));

    /// Relating usernames and (system-level) principal identifiers.
    public var userPrincipal : RelObj.RelObj<Types.UserId, Principal> = RelObj.RelObj<Types.UserId, Principal>
      ((Text.hash, Principal.hash), (Text.equal, Principal.equal));
  }
}

import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import TrieMap "mo:base/TrieMap";
import Array "mo:base/Array";

module {

    public type Id = Nat32;

    // A workgroup contains multiple boards
    public type Workgroup = {
        title: Text;
    };

    // A board represent a project
    public type Board = {
        title: Text;
    };
    public type BoardDto = {
        title: Text;
        columns: [ColumnDto]
    };

    // A column contains a collection of cards
    public type Column = {
        title: Text;
        boardId: Nat32;
    };
    public type ColumnDto = {
        title: Text;
        boardId: Nat32;
        cards: [Card]
    };

    // A card contains a title and description of the work to be done
    public type Card = {
        title: Text;
        description: Text;
        columnId: Nat32;
    };

    public func getNextId(obj: Any, id: ?Id) : Id {
        switch (id) {
            case (?id) id + 1;
            case (null) 0;
        }
    };

    func nat32ToHash (n : Nat32) : Nat32 {
        return (n);
    };

    public func getBoardColumns(id: Id, columnEntries:Iter.Iter<(Id, Column)>): Iter.Iter<(Id, Column)> {
        let columns: TrieMap.TrieMap<Id,Column> = TrieMap.fromEntries<Id,Column>(columnEntries, Nat32.equal, nat32ToHash);
        let filtered: TrieMap.TrieMap<Id,Column> = TrieMap.mapFilter<Id,Column,Column>(columns, Nat32.equal, nat32ToHash, func(k,v){ 
          if(v.boardId == id) {
            return ?v;
          } else {
            return null;
          }
        });
        filtered.entries()
    };

    public func getColumnCards(id: Id, cardEntries:Iter.Iter<(Id, Card)>): Iter.Iter<(Id, Card)> {
        let cards: TrieMap.TrieMap<Id,Card> = TrieMap.fromEntries<Id,Card>(cardEntries, Nat32.equal, nat32ToHash);
        let filtered: TrieMap.TrieMap<Id,Card> = TrieMap.mapFilter<Id,Card,Card>(cards, Nat32.equal, nat32ToHash, func(k,v){ 
          if(v.columnId == id) {
            return ?v;
          } else {
            return null;
          }
        });
        filtered.entries();
    }

};
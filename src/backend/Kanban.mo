import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import DB "./db/database";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Trie "mo:base/Trie";
import TrieMap "mo:base/TrieMap";
import Types "./KanbanTypes";

shared ({caller = initPrincipal}) actor class Kanban () {
  type Id = Types.Id;
  type Workgroup = Types.Workgroup;
  type Board = Types.Board;
  type BoardDto = Types.BoardDto;
  type Card = Types.Card;
  type Column = Types.Column;
  type ColumnDto = Types.ColumnDto;

  func nat32ToHash (n : Nat32) : Nat32 {
    return (n);
  };

  let dbWorkgroups = DB.Database<Id, Workgroup>(Types.getNextId, Nat32.equal,#hash nat32ToHash); //The hash is the Nat32 itself
  let dbBoard = DB.Database<Id, Board>(Types.getNextId, Nat32.equal,#hash nat32ToHash); 
  let dbCards = DB.Database<Id, Card>(Types.getNextId, Nat32.equal,#hash nat32ToHash);
  let dbColumns = DB.Database<Id, Column>(Types.getNextId, Nat32.equal,#hash nat32ToHash);

  public func createBoard(title: Text) : async Id {
    dbBoard.create({ title; })
  };
  
  public query func readBoard(id: Nat32) : async DB.Res<Board> {
    dbBoard.read(id)
  };

  public query func getBoardDto(id: Nat32) : async DB.Res<BoardDto> {
    switch(dbBoard.read(id)) {
      case (#err(error)) {
          #err(#invalidId)
      };
      case (#ok(board)) {
        let columns = Iter.map<(Id,Column),ColumnDto>(Types.getBoardColumns(id, dbColumns.entries()), func (colKey,colValue) {
          let cards = Iter.map<(Id,Card),Card>(Types.getColumnCards(colKey,dbCards.entries()), func(cardK, cardV){
            cardV
          });
          {
            title=colValue.title;
            boardId=colValue.boardId;
            cards=Iter.toArray(cards);
          }
        });

        let boardDto: BoardDto = {
          title=board.title;
          columns=Iter.toArray(columns)
        };
        #ok(boardDto)
      };
    }
  };

  public func createColumn(title: Text, boardId: Id) : async Id {
    dbColumns.create({ title; boardId})
  };
  
  public query func readColumn(id: Nat32) : async DB.Res<Column> {
    dbColumns.read(id)
  };

  public func createCard(title: Text, description: Text, columnId: Id) : async Id {
    dbCards.create({ title; description; columnId})
  };
  
  public query func readCard(id: Nat32) : async DB.Res<Card> {
    dbCards.read(id)
  };
}
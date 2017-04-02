module kiwi.record.sql_ast.ast_node;

// import std.range : isOutputRange;
//
// import kiwi.record.sql_ast.insert;
//
// struct AstNode
// {
//     enum Type
//     {
//         invalid,
//         next,
//         insert,
//         values,
//         returning
//     }
//
//     private union Node
//     {
//         Next next;
//         Insert insert;
//         Values values;
//         Returning returning;
//     }
//
//     private Type type;
//     private Node node;
//
//     Next next()
//     {
//         assert(type == AstType.next);
//         return node.next;
//     }
//
//     Insert insert()
//     {
//         assert(type == AstType.insert);
//         return node.insert;
//     }
//
//     Values values()
//     {
//         assert(type == AstType.values);
//         return node.values;
//     }
//
//     Returning returning()
//     {
//         assert(type == AstType.returning);
//         return node.returning;
//     }
// }

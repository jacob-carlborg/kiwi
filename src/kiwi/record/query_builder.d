module kiwi.record.query_builder;

// import std.format;
//
// import kiwi.record.sql_ast.ast_node;
// import kiwi.record.sql_ast.insert;
// import kiwi.record.sql_ast.next;
//
// struct QueryBuilder
// {
//     private string tableName;
//     private string[] columnNames;
//     private AstNode node;
//
//     this(string tableName, string[] columnNames)
//     {
//         this.tableName = tableName;
//         this.columnNames = columnNames;
//     }
//
//     private this(string tableName, string[] columnNames, in ref AstNode node)
//     {
//         this(tableName, columnNames);
//         this.node = node;
//     }
//
//     QueryBuilder insert(Values...)(Values values)
//     {
//         auto insert = Insert(tableName, columnNames, Insert.valuesToSql(values));
//
//         if (node.type == AstNode.Type.invalid)
//             return QueryBuilder(tableName, columnNames, insert);
//         else
//             return QueryBuilder(tableName, columnNames, Next(node, insert));
//     }
// }

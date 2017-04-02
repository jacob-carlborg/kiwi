module kiwi.record.sql_builder;

// import std.format : formattedWrite;
// import std.range : isOutputRange;
//
// import kiwi.record.sql_ast.insert;
//
// void toSql(OutputRange)(AstNode node, OutputRange range)
//     if (isOutputRange!(OutputRange))
// {
//     with(AstType)
//         final switch(node.type)
//         {
//             case invalid: assert(false, "Invalid SQL AST node type"); break;
//             case next: node.next.toSql(range); break;
//             case insert: node.insert.toSql(range); break;
//             case values: node.values.toSql(range); break;
//             case returning: node.returning.toSql(range); break;
//         }
// }
//
// void toSql(OutputRange)(Next node, OutputRange range)
//     if (isOutputRange!(OutputRange))
// {
//     node.node.toSql(range);
//     range.put(" ");
//     node.next.toSql(range);
// }
//
// void toSql(OutputRange)(Insert node, OutputRange range)
//     if (isOutputRange!(OutputRange))
// {
//     formattedWrite(range, "INSERT INTO %s (%(%s, %))", node.tableName,
//         node.columnNames);
// }
//
// void toSql(OutputRange)(Values node, OutputRange range)
//     if (isOutputRange!(OutputRange))
// {
//     formattedWrite(range, "VALUES (%(%s, %))", node.values);
// }
//
// void toSql(OutputRange)(Returning node, OutputRange range)
//     if (isOutputRange!(OutputRange))
// {
//     formattedWrite(range, "RETURNING %s", node.columnName);
// }

module kiwi.record.persistence;

import kiwi.model.dirty_tracking;

mixin template Persistence(Fields...)
{
    mixin DirtyTracking!(Fields, __persistedKey);

    private enum __persistedKey = "kiwi.record.Persistence.persisted";

    bool isNewRecord()
    {
        return !isPersisted;
    }

    bool isPersisted()
    {
        return fieldHasChanged!(__persistedKey);
    }

    // bool save()
    // {
    //     return isNewRecord ? create() : update();
    // }
    //
    // bool create()
    // {
    //     auto sql = QueryBuilder().
    //         insert(tableName, columns.name).
    //         values(fields).
    //         returning("id").
    //         toSql();
    //
    //     execute(sql);
    // }
}

// INSERT INTO "events" ("cname", "created_at", "live", "name", "start_at",
//     "suspend_at", "updated_at") VALUES ('asd', '2016-12-06 07:15:46.353473',
//     'f', 'asd', '2016-12-06 07:15:26.290911', '2016-12-06 07:15:17.206547',
//     '2016-12-06 07:15:46.353473') RETURNING "id"

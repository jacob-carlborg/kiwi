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
}

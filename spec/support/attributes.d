module spec.support.attributes;

import unit_threaded;

/// UDA for describing a group of specs.
struct describe
{
    /// The description
    string description;
}

/// ditto
alias context = describe;

/// UDA for description a single spec.
alias it = Name;

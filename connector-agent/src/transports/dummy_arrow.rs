use crate::destinations::arrow::ArrowDestination;
use crate::dummy_typesystem::DummyTypeSystem;
use crate::sources::dummy::DummySource;
use crate::typesystem::TypeConversion;
use chrono::{DateTime, NaiveDate, NaiveDateTime, Utc};

pub struct DummyArrowTransport;

impl_transport!(
    name = DummyArrowTransport,
    systems = DummyTypeSystem => DummyTypeSystem,
    route = DummySource => ArrowDestination,
    mappings = {
        [F64      => F64      | f64           => f64           | conversion all]
        [I64      => I64      | i64           => i64           | conversion all]
        [Bool     => Bool     | bool          => bool          | conversion all]
        [String   => String   | String        => String        | conversion all]
        [DateTime => DateTime | DateTime<Utc> => DateTime<Utc> | conversion all]
    }
);

impl TypeConversion<NaiveDateTime, DateTime<Utc>> for DummyArrowTransport {
    fn convert(val: NaiveDateTime) -> DateTime<Utc> {
        DateTime::from_utc(val, Utc)
    }
}

impl TypeConversion<NaiveDate, DateTime<Utc>> for DummyArrowTransport {
    fn convert(val: NaiveDate) -> DateTime<Utc> {
        DateTime::from_utc(val.and_hms(0, 0, 0), Utc)
    }
}
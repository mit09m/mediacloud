import time
import datetime

# noinspection PyPackageRequirements
import dateutil.parser

from mediawords.util.perl import decode_string_from_bytes_if_needed


def get_sql_date_from_epoch(epoch: int) -> str:
    # Returns local date by default, no need to set timezone
    try:
        return datetime.datetime.fromtimestamp(int(epoch)).strftime('%Y-%m-%d %H:%M:%S')
    except( ValueError ):
        # mimic perl's behavior of sending the 0 epoch date on an error
        return '1970-01-01 00:00:00'


def sql_now() -> str:
    return get_sql_date_from_epoch(int(time.time()))


def get_epoch_from_sql_date(date: str) -> int:
    """Given a date in the sql format 'YYYY-MM-DD', return the epoch time."""
    date = decode_string_from_bytes_if_needed(date)
    parsed_date = dateutil.parser.parse(date)
    return int(parsed_date.timestamp())


def increment_day(date: str, days: int = 1) -> str:
    """Given a date in the sql format 'YYYY-MM-DD', increment it by $days days."""
    date = decode_string_from_bytes_if_needed(date)
    if days == 0:
        return date
    epoch_date = get_epoch_from_sql_date(date) + (((days * 24) + 12) * 60 * 60)
    return datetime.datetime.fromtimestamp(int(epoch_date)).strftime('%Y-%m-%d')

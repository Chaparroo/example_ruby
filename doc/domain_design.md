# Hotel Booking — Domain Design

## Entities & Fields

### users
| Field | Type | Notes |
|---|---|---|
| name | string | |
| identification | string | |
| email | string | unique |
| phone | string | E.164 format e.g. +573001234567 |
| password_digest | string | managed by has_secure_password |

---

### hotels
| Field | Type | Notes |
|---|---|---|
| name | string | |
| address | string | |
| city | string | |
| country | string | |
| description | text | |

---

### room_types
| Field | Type | Notes |
|---|---|---|
| name | string | e.g. Suite, Double, Single |
| description | text | |

---

### rooms
| Field | Type | Notes |
|---|---|---|
| hotel_id | references | belongs_to :hotel |
| room_type_id | references | belongs_to :room_type |
| number | string | room identifier e.g. "302" |
| description | text | |
| price | decimal | precision: 10, scale: 2 |

---

### reservations
| Field | Type | Notes |
|---|---|---|
| user_id | references | belongs_to :user |
| room_id | references | belongs_to :room |
| check_in | date | |
| check_out | date | |
| guests_count | integer | |
| total_price | decimal | precision: 10, scale: 2 — frozen at booking time |
| status | integer | enum: pending, confirmed, cancelled, expired |

---

## Relationships

```
Hotel --< Room >-- RoomType
User --< Reservation >-- Room
```

- A hotel has many rooms
- A room belongs to one hotel and one room_type
- A user has many reservations
- A reservation belongs to one user and one room

---

## Availability Rule

Availability is NOT stored as a field.
A room is available for a date range if there are NO confirmed reservations
that overlap with the requested check_in / check_out.

Overlap condition: `existing.check_in < requested.check_out AND existing.check_out > requested.check_in`

---

## Reservation States

```
pending -> confirmed -> cancelled
pending -> expired (no payment within time limit — future: background job)
```

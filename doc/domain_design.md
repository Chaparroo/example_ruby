# Hotel Booking — Domain Design

## Entities & Fields

### users
| Field | Type | Notes |
|---|---|---|
| nombre | string | |
| identificacion | string | |
| email | string | unique |
| telefono | string | E.164 format e.g. +573001234567 |
| password_digest | string | managed by has_secure_password |

---

### hotels
| Field | Type | Notes |
|---|---|---|
| nombre | string | |
| direccion | string | |
| ciudad | string | |
| pais | string | |
| descripcion | text | |

---

### room_types
| Field | Type | Notes |
|---|---|---|
| nombre | string | e.g. Suite, Doble, Sencilla |
| descripcion | text | |

---

### rooms
| Field | Type | Notes |
|---|---|---|
| hotel_id | references | belongs_to :hotel |
| room_type_id | references | belongs_to :room_type |
| numero | string | room identifier e.g. "302" |
| descripcion | text | |
| precio | decimal | precision: 10, scale: 2 |

---

### reservations
| Field | Type | Notes |
|---|---|---|
| user_id | references | belongs_to :user |
| room_id | references | belongs_to :room |
| check_in | date | |
| check_out | date | |
| cantidad_personas | integer | |
| precio_total | decimal | precision: 10, scale: 2 — frozen at booking time |
| estado | integer | enum: pending, confirmed, cancelled, expired |

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

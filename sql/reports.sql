-- Get the count of plotholes in the "Suburbia" district
SELECT COUNT(*) FROM p3db.pothole WHERE
pothole.location_id IN (
    SELECT location_id FROM p3db.pothole_location WHERE
    pothole_location.district = "Suburbia"
)

-- Calculate repair priority
CREATE FUNCTION

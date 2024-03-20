
DROP SCHEMA IF EXISTS p3db;
CREATE SCHEMA p3db;
USE p3db;

--
-- Table structure for table `pothole_location`
--
CREATE TABLE pothole_location (
    location_id INT NOT NULL,
    street_name VARCHAR(60) NOT NULL,
    zipcode INT NOT NULL,
    postion VARCHAR(60) NOT NULL,
    district VARCHAR(60) NOT NULL,

	PRIMARY KEY (location_id)
);

--
-- Table structure for table `pothole`
--
CREATE TABLE pothole (
    pothole_id SMALLINT NOT NULL,
    location_id SMALLINT NOT NULL,
    p_size SMALLINT,

    PRIMARY KEY (pothole_id),
    FOREIGN KEY (location_id) REFERENCES pothole_location(location_id)

);

--
-- Table structure for table `user`
--
CREATE TABLE p_user (
    user_id SMALLINT NOT NULL,
    pwd VARCHAR(50), -- Encrypted or Key

	PRIMARY KEY (user_id)
);

CREATE TYPE SEVER_ENUM AS ENUM('severe', 'minor');

--
-- Table structure for table `property_damage`
--
CREATE TABLE property_damage (
    damage_id SMALLINT NOT NULL,
    citizen_name VARCHAR(50),
    location_id SMALLINT,
    phone VARCHAR(10),
    d_type SEVER_ENUM,
    cost DECIMAL(5,2),

    PRIMARY KEY (damage_id),
    FOREIGN KEY (location_id) REFERENCES pothole_location(location_id)

);

--
-- Table structure for table `work_crew`
--
CREATE TABLE work_crew (
    crew_id SMALLINT NOT NULL,
    num_people INT,

    PRIMARY KEY (crew_id)
);

--
-- Table structure for table `equipment`
--
CREATE TABLE equipment (
    equipment_id SMALLINT NOT NULL,
    p_weight INT,
    p_name VARCHAR(50),
    cost DECIMAL(5,2),

  PRIMARY KEY (equipment_id)
);

--
-- Bridge table structure for crew/equipment relationship
--
CREATE TABLE crew_equipment (
    crew_id SMALLINT NOT NULL,
    equipment_id SMALLINT NOT NULL,

    PRIMARY KEY (crew_id, equipment_id),
    FOREIGN KEY (crew_id) REFERENCES work_crew(crew_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TYPE COMP_ENUM AS ENUM('done', 'in progress', 'requested');

--
-- Table structure for table `work_order`
--
CREATE TABLE work_order (
    order_id SMALLINT NOT NULL,
    pothole_id SMALLINT,
    crew_id SMALLINT, 
    hour_spent SMALLINT,
    filler_used SMALLINT, 
    cost SMALLINT, 
    completion_status COMP_ENUM, 
    
    PRIMARY KEY (order_id),
    FOREIGN KEY (pothole_id) REFERENCES pothole(pothole_id),
    FOREIGN KEY (crew_id) REFERENCES work_crew(crew_id)
);
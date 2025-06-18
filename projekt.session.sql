
DROP DATABASE team08;
CREATE DATABASE team08;
USE team08;

CREATE TABLE booking
(
  booking_id  SMALLINT NOT NULL,
  seat_number SMALLINT NULL    ,
  client_id   SMALLINT NOT NULL,
  trip_id     SMALLINT NOT NULL,
  PRIMARY KEY (booking_id)
);

CREATE TABLE client
(
  client_id            SMALLINT    NOT NULL,
  first_name           VARCHAR(50) NOT NULL,
  last_name            VARCHAR(50) NOT NULL,
  client_contact_id    SMALLINT    NOT NULL,
  emergency_contact_id SMALLINT    NOT NULL,
  PRIMARY KEY (client_id)
) COMMENT 'list of clients';

CREATE TABLE client_contact
(
  client_contact_id SMALLINT     NOT NULL,
  phone             VARCHAR(22)  NOT NULL,
  email             VARCHAR(100) NOT NULL,
  PRIMARY KEY (client_contact_id)
);

CREATE TABLE cost
(
  cost_id     SMALLINT      NOT NULL,
  description TEXT          NULL    ,
  amount      decimal(10,2) NULL    ,
  trip_id     SMALLINT      NOT NULL,
  PRIMARY KEY (cost_id)
);

CREATE TABLE emergency_contact
(
  emergency_contact_id SMALLINT     NOT NULL,
  phone                VARCHAR(22)  NULL    ,
  email                VARCHAR(100) NULL    ,
  PRIMARY KEY (emergency_contact_id)
);

CREATE TABLE employee
(
  employee_id SMALLINT      NOT NULL,
  first_name  VARCHAR(50)   NULL    ,
  last_name   varchar(50)   NULL    ,
  position    VARCHAR(20)   NULL    ,
  hire_date   DATE          NULL    ,
  salary      DECIMAL(10,2) NULL,    
  fire_date DATE NULL,
  PRIMARY KEY (employee_id)
) COMMENT 'list of staff';

CREATE TABLE galaxy
(
  galaxy_id SMALLINT    NOT NULL,
  galaxy    VARCHAR(50) NOT NULL,
  PRIMARY KEY (galaxy_id)
);

CREATE TABLE planet
(
  planet_id         SMALLINT    NOT NULL,
  planet            VARCHAR(50) NULL    ,
  system_id         SMALLINT    NOT NULL,
  orbit_period_days INT         NOT NULL,
  special_features  TEXT     NULL    ,
  day0_x_coord      FLOAT       NOT NULL,
  day0_y_coord      FLOAT       NOT NULL,
  day0_z_coord      FLOAT       NOT NULL,
  PRIMARY KEY (planet_id)
);

CREATE TABLE planet_feature
(
  planet_id  SMALLINT NOT NULL,
  feature_id SMALLINT NOT NULL,
  PRIMARY KEY (planet_id, feature_id)
);

CREATE TABLE planetary_system
(
  system_id    SMALLINT    NOT NULL,
  system       VARCHAR(50) NULL    ,
  central_star VARCHAR(50) NULL    ,
  x_coord      FLOAT       NOT NULL,
  y_coord      FLOAT       NOT NULL,
  z_coord      FLOAT       NOT NULL,
  galaxy_id    SMALLINT    NOT NULL,
  PRIMARY KEY (system_id)
);

CREATE TABLE rocket
(
  rocket_id SMALLINT    NOT NULL,
  name      VARCHAR(50) NULL    ,
  capacity  SMALLINT    NOT NULL,
  PRIMARY KEY (rocket_id)
);

CREATE TABLE special_feature
(
  feature_id SMALLINT NOT NULL,
  feature    TEXT     NULL    ,
  PRIMARY KEY (feature_id)
);

CREATE TABLE transaction
(
  transaction_id SMALLINT      NOT NULL,
  amount         DECIMAL(10,2) NULL    ,
  method         VARCHAR(20)   NULL    ,
  payment_date   DATE          NULL    ,
  trip_id        SMALLINT      NOT NULL,
  client_id      SMALLINT      NOT NULL,
  PRIMARY KEY (transaction_id)
);

CREATE TABLE trip
(
  trip_id        SMALLINT                                  NOT NULL,
  trip_type_id    SMALLINT                                  NOT NULL,
  rocket_id      SMALLINT                                  NOT NULL,
  departure_date DATE                                      NULL    ,
  return_date    DATE                                      NULL    ,
  status         ENUM("Scheduled", "Completed", "Delayed") NULL    ,
  speed          INT                                       NOT NULL,
  delay_days INT NULL,
  PRIMARY KEY (trip_id)
);

CREATE TABLE trip_employee
(
  trip_employee_id SMALLINT                                                                    NOT NULL,
  role_in_trip     ENUM("Technician", "Mission Specialist", "Commander", "Pilot", "Navigator") NULL    ,
  employee_id      SMALLINT                                                                    NOT NULL,
  trip_id          SMALLINT                                                                    NOT NULL,
  PRIMARY KEY (trip_employee_id)
);

CREATE TABLE trip_type
(
  trip_type_id   SMALLINT    NOT NULL,
  name          VARCHAR(50) NULL    ,
  is_round_trip BOOLEAN     NULL    ,
  planet_id     SMALLINT    NOT NULL,
  PRIMARY KEY (trip_type_id)
);

ALTER TABLE transaction
  ADD CONSTRAINT FK_trip_TO_transaction
    FOREIGN KEY (trip_id)
    REFERENCES trip (trip_id);

ALTER TABLE trip
  ADD CONSTRAINT FK_trip_type_TO_trip
    FOREIGN KEY (trip_type_id)
    REFERENCES trip_type (trip_type_id);

ALTER TABLE trip
  ADD CONSTRAINT FK_rocket_TO_trip
    FOREIGN KEY (rocket_id)
    REFERENCES rocket (rocket_id);

ALTER TABLE booking
  ADD CONSTRAINT FK_trip_TO_booking
    FOREIGN KEY (trip_id)
    REFERENCES trip (trip_id);

ALTER TABLE cost
  ADD CONSTRAINT FK_trip_TO_cost
    FOREIGN KEY (trip_id)
    REFERENCES trip (trip_id);

ALTER TABLE planet
  ADD CONSTRAINT FK_planetary_system_TO_planet
    FOREIGN KEY (system_id)
    REFERENCES planetary_system (system_id);

ALTER TABLE trip_type
  ADD CONSTRAINT FK_planet_TO_trip_type
    FOREIGN KEY (planet_id)
    REFERENCES planet (planet_id);

ALTER TABLE planetary_system
  ADD CONSTRAINT FK_galaxy_TO_planetary_system
    FOREIGN KEY (galaxy_id)
    REFERENCES galaxy (galaxy_id);

ALTER TABLE booking
  ADD CONSTRAINT FK_client_TO_booking
    FOREIGN KEY (client_id)
    REFERENCES client (client_id);

ALTER TABLE transaction
  ADD CONSTRAINT FK_client_TO_transaction
    FOREIGN KEY (client_id)
    REFERENCES client (client_id);

ALTER TABLE client
  ADD CONSTRAINT FK_emergency_contact_TO_client
    FOREIGN KEY (emergency_contact_id)
    REFERENCES emergency_contact (emergency_contact_id);

ALTER TABLE client
  ADD CONSTRAINT FK_client_contact_TO_client
    FOREIGN KEY (client_contact_id)
    REFERENCES client_contact (client_contact_id);

ALTER TABLE trip_employee
  ADD CONSTRAINT FK_employee_TO_trip_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id);

ALTER TABLE trip_employee
  ADD CONSTRAINT FK_trip_TO_trip_employee
    FOREIGN KEY (trip_id)
    REFERENCES trip (trip_id);

ALTER TABLE planet_feature
  ADD CONSTRAINT FK_planet_TO_planet_feature
    FOREIGN KEY (planet_id)
    REFERENCES planet (planet_id);

ALTER TABLE planet_feature
  ADD CONSTRAINT FK_special_feature_TO_planet_feature
    FOREIGN KEY (feature_id)
    REFERENCES special_feature (feature_id);

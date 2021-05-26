CREATE SEQUENCE firm_seq
 MINVALUE 1
 START WITH 1
 INCREMENT BY 1
 CACHE 20;

create table FIRM (firm_id  number NOT NULL, street varchar(60), zip int, city varchar(30), state char(2), phone_num varchar(20), name varchar(50) NOT NULL,
                  CONSTRAINT firm_pk1 PRIMARY KEY (firm_id));
insert into FIRM values (firm_seq.NEXTVAL, 'Edge Drive', 21217, 'Baltimore', 'MD', '4411231467', 'Onyx Realtors');
insert into FIRM values (firm_seq.NEXTVAL, 'Laguna Ave', 90210, 'Los Angeles', 'CA', '2524793579', 'Beach Realtors');

commit;


CREATE SEQUENCE agent_seq
 MINVALUE 1
 START WITH 1
 INCREMENT BY 1
 CACHE 20;

create table AGENT (agent_id number NOT NULL, fname  varchar(30) NOT NULL, lname varchar(30) NOT NULL, street varchar(60) NOT NULL, zip int NOT NULL, city varchar(30) NOT NULL, state char(2) NOT NULL, salary numeric(12,2), tot_amt_sales int, firm_id number NOT NULL,
                   CONSTRAINT agent_pk1 PRIMARY KEY (agent_id), 
                   CONSTRAINT fk_firm1
                    FOREIGN KEY (firm_id)
                    REFERENCES FIRM(firm_id));
insert into AGENT values (agent_seq.NEXTVAL, 'Thomas', 'Jones', 'Glenwood Drive', 20877, 'Gaithersburg', 'MD', 50100.00, 2, 1);
insert into AGENT values (agent_seq.NEXTVAL, 'Sara', 'Clarke', 'Rosebud Lane', 1111, 'Frederick', 'MD', 45000.00, 5, 1);
insert into AGENT values (agent_seq.NEXTVAL, 'Bob', 'Ross', 'Cross Street', 84857, 'Hollywood', 'CA', 75000.00, 2, 2);

commit;


CREATE SEQUENCE property_seq
 MINVALUE 1
 START WITH 1
 INCREMENT BY 1
 CACHE 20;
                   
create table PROPERTY (property_id number NOT NULL, street varchar(60) NOT NULL, zip int NOT NULL, city varchar(30) NOT NULL, state char(2) NOT NULL, asking_price numeric(12,2), tot_size int, status varchar(20) NOT NULL, date_of_const DATE , 
                      property_type varchar(30) NOT NULL, firm_id number NOT NULL, agent_id number,
                      CONSTRAINT property_pk1 PRIMARY KEY (property_id),
                      CONSTRAINT fk_firm2
                        FOREIGN KEY (firm_id)
                        REFERENCES FIRM(firm_id),
                      CONSTRAINT fk_agent1
                        FOREIGN KEY (agent_id)
                        REFERENCES AGENT(agent_id));
insert into PROPERTY values (property_seq.NEXTVAL, 'Lilly Lane', 20495, 'Germantown', 'MD', 600300.00, 1054, 'available', to_date('21/01/1998','DD/MM/YYYY'), 'Single Familiy', 1, 2);
insert into PROPERTY values (property_seq.NEXTVAL, 'Jones Street', 46465, 'Sunnyvale', 'CA', 805560.00, 1010, 'sold', to_date('24/07/2011','DD/MM/YYYY'), 'Condo', 2, 3);

commit;
 
 
CREATE SEQUENCE rooms_seq
 MINVALUE 1
 START WITH 1
 INCREMENT BY 1
 CACHE 20;
         
create table ROOMS (room_id number NOT NULL, room_type varchar(50) NOT NULL, room_size int, flooring_type varchar(50), property_id number,
                   CONSTRAINT room_pk PRIMARY KEY (room_id),  
                   CONSTRAINT fk_property1
                    FOREIGN KEY (property_id)
                    REFERENCES PROPERTY(property_id));
insert into ROOMS values (rooms_seq.NEXTVAL, 'Bedroom', 340, 'Hardwood', 1);
insert into ROOMS values (rooms_seq.NEXTVAL, 'living room', 140, 'Hardwood', 1);
insert into ROOMS values (rooms_seq.NEXTVAL, 'Kitchen', 257, 'Hardwood', 1);
insert into ROOMS values (rooms_seq.NEXTVAL, 'Bathroom', 240, 'Hardwood', 1);
insert into ROOMS values (rooms_seq.NEXTVAL, 'Bedroom', 400, 'Carpet', 2);
insert into ROOMS values (rooms_seq.NEXTVAL, 'living room', 440, 'Hardwood', 2);
insert into ROOMS values (rooms_seq.NEXTVAL, 'Kitchen', 240, 'Hardwood', 2);
insert into ROOMS values (rooms_seq.NEXTVAL, 'Bathroom', 140, 'Tile', 2);
commit;
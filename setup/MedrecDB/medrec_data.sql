INSERT INTO "MEDREC_OWNER"."ADMINISTRATORS" (
"ID", "EMAIL", "PASSWORD", "USERNAME", "VERSION" )
VALUES (
201,'admin@avitek.com','weblogic','admin@avitek.com',1
);

COMMIT;

INSERT INTO "MEDREC_OWNER"."OPENJPA_SEQUENCE_TABLE" (
"ID", "SEQUENCE_VALUE" )
VALUES (
0,251
);

COMMIT;

INSERT INTO "MEDREC_OWNER"."PATIENTS"
VALUES (
51,'page@fish.com','weblogic','page@fish.com','4151234564',
TIMESTAMP '1972-03-18 00:00:00','MALE','888888888','APPROVED',3,
'Page','Trout','A','Ponte Verde','United States','FL',
'235 Montgomery St','Suite 15','32301'
);
INSERT INTO "MEDREC_OWNER"."PATIENTS"
VALUES (
52,'fred@golf.com','weblogic','fred@golf.com','4151234564',
TIMESTAMP '1965-04-26 00:00:00','MALE','123456789','APPROVED',3,
'Fred','Winner','I','San Francisco','United States','CA',
'1224 Post St','Suite 100','94115'
);
INSERT INTO "MEDREC_OWNER"."PATIENTS"
VALUES (
53,'volley@ball.com','weblogic','volley@ball.com','4151234564',
TIMESTAMP '1971-09-17 00:00:00','MALE','333333333','APPROVED',3,
'Gabrielle','Spiker','H','San Francisco','United States','CA',
'1224 Post St','Suite 100','94115'
);
INSERT INTO "MEDREC_OWNER"."PATIENTS"
VALUES (
54,'charlie@star.com','weblogic','charlie@star.com','4151234564',
TIMESTAMP '1973-11-29 00:00:00','MALE','444444444','REGISTERED',3,
'Charlie','Florida','E','Ponte Verde','United States','FL',
'235 Montgomery St','Suite 15','32301'
);
INSERT INTO "MEDREC_OWNER"."PATIENTS"
VALUES (
55,'larry@bball.com','weblogic','larry@bball.com','4151234564',
TIMESTAMP '1959-03-13 00:00:00','MALE','777777777','APPROVED',3,
'Larry','Parrot','J','San Francisco','United States','CA',
'1224 Post St','Suite 100','94115'
);

COMMIT;

INSERT INTO "MEDREC_OWNER"."PHYSICIANS" (
"ID", "EMAIL", "PASSWORD", "USERNAME", "PHONE", "VERSION", "FIRSTNAME", "LASTNAME", "MIDDLENAME" )
VALUES (
1,'mary@md.com','weblogic','mary@md.com','1234567812',4,'Mary','Oblige','J'
);

COMMIT;

Insert into "MEDREC_OWNER"."DRUGS"  (ID,NAME,FREQUENCY,PRICE,VERSION) values (101,'Advil','1/4hrs',1.0, 2);
Insert into "MEDREC_OWNER"."DRUGS"  (ID,NAME,FREQUENCY,PRICE,VERSION) values (102,'Codeine','1/6hrs',2.5,2);
Insert into "MEDREC_OWNER"."DRUGS"  (ID,NAME,FREQUENCY,PRICE,VERSION) values (103,'Drixoral','1tspn/4hrs',3.75,2);

COMMIT;

Insert into "MEDREC_OWNER"."PRESCRIPTIONS"  (ID,DATE_PRESCRIBED,FREQUENCY,INSTRUCTIONS,REFILLS_REMAINING,VERSION,DOSAGE,DRUG_ID) values (101,TIMESTAMP '1999-07-18 00:00:00','1/4hrs',null,0,2,1,101);
Insert into "MEDREC_OWNER"."PRESCRIPTIONS"  (ID,DATE_PRESCRIBED,FREQUENCY,INSTRUCTIONS,REFILLS_REMAINING,VERSION,DOSAGE,DRUG_ID) values (102,TIMESTAMP '1999-07-30 00:00:00','1/6hrs',null,1,2,1,102);
Insert into "MEDREC_OWNER"."PRESCRIPTIONS"  (ID,DATE_PRESCRIBED,FREQUENCY,INSTRUCTIONS,REFILLS_REMAINING,VERSION,DOSAGE,DRUG_ID) values (103,TIMESTAMP '1999-07-18 00:00:00','1tspn/4hrs',null,0,2,1,103);


COMMIT;

INSERT INTO "MEDREC_OWNER"."RECORDS"
VALUES (
151,TIMESTAMP '1991-05-01 00:00:00',TIMESTAMP '1991-05-01 00:00:00','Allergic to coffee. Drink tea.',
'','Drowsy all day.',2,51,1,85,70,75,125,98,180
);
INSERT INTO "MEDREC_OWNER"."RECORDS"
VALUES (
152,TIMESTAMP '1991-05-01 00:00:00',TIMESTAMP '1991-05-01 00:00:00','Light cast needed.',
'At least 20 sprained ankles since 15.','Sprained ankle.',
2,53,1,85,70,75,125,98,180
);
INSERT INTO "MEDREC_OWNER"."RECORDS"
VALUES (
153,TIMESTAMP '1989-08-05 00:00:00',TIMESTAMP '1989-08-05 00:00:00','Severely sprained interior ligament. Surgery required.','Cast will be necessary before and after.','Twisted knee while playing soccer.',2,52,1,85,70,75,125,98,180
);
INSERT INTO "MEDREC_OWNER"."RECORDS"
VALUES (
154,TIMESTAMP '1993-06-30 00:00:00',TIMESTAMP '1993-06-30 00:00:00','Common cold. Prescribed codiene cough syrup.','Call back if not better in 10 days.','Sneezing, coughing, stuffy head.',2,52,1,85,70,75,125,98,180
);
INSERT INTO "MEDREC_OWNER"."RECORDS"
VALUES (
155,TIMESTAMP '1999-07-18 00:00:00',TIMESTAMP '1999-07-18 00:00:00','Mild stroke.  Aspirin advised.','Patient needs to stop smoking.','Complains about chest pain.',2,52,1,85,70,75,125,98,180
);
INSERT INTO "MEDREC_OWNER"."RECORDS"
VALUES (
156,TIMESTAMP '1991-05-01 00:00:00',TIMESTAMP '1991-05-01 00:00:00','Patient is crazy.  Recommend politics.','','Overjoyed with everything.',2,55,1,85,70,75,125,98,180
);

COMMIT;

INSERT INTO "MEDREC_OWNER"."RECORDS_PRESCRIPTIONS"
VALUES (
154,102
);
INSERT INTO "MEDREC_OWNER"."RECORDS_PRESCRIPTIONS"
VALUES (
155,101
);
INSERT INTO "MEDREC_OWNER"."RECORDS_PRESCRIPTIONS"
VALUES (
155,103
);

COMMIT;
